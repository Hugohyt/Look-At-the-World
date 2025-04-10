//
//  HistoryViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "HistoryViewController.h"
#import "HistoryCollectionViewCell.h"
#import "VideoViewController.h"
#import "ArticleViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "HistoryCollectionViewModel.h"
#import "YYModel/YYModel.h"
#import "UIImageView+WebCache.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.imageArray = [NSMutableArray array];
    self.heightArray = [NSMutableArray array];
    
    [self setupLoadingIndicator];
    [self loadDataAndUpdateUI];
    
    self.modelArray = [NSMutableArray array];
    
    UIImageView *layerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 758, 394, 100)];
    [layerImageView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.9 blue:0.8 alpha:1.0]];
    [self.historyView addSubview:layerImageView];
    
    [self.historyView.releaseButton addTarget:self action:@selector(popReleaseView) forControlEvents:UIControlEventTouchUpInside];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"LoadingFooter" forIndexPath:indexPath];

        // 移除旧菊花控件
        for (UIView *view in footer.subviews) {
            [view removeFromSuperview];
        }
        
        // 添加新菊花控件
        self.footerIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        self.footerIndicator.frame = CGRectMake((footer.bounds.size.width - 30) / 2, (footer.bounds.size.height - 30) / 2, 30, 30);
        [footer addSubview:self.footerIndicator];
        [self.footerIndicator hidesWhenStopped];
        footer.hidden = NO;
        NSLog(@"footer:%@",footer);
        
        return footer;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat screenHeight = scrollView.bounds.size.height;
    
//    NSLog(@"%lf %lf %lf",offsetY, contentHeight, screenHeight);
    
    if (contentHeight < screenHeight) {
        return;
    }
       
    if (offsetY > (contentHeight - screenHeight) * 1.0 &&
           self.loadState == CollectionViewLoadStateIdle) {
           NSLog(@"触发加载更多");
           [self loadMoreData];
    }
}

- (void)loadMoreData {
    if (self.loadState == CollectionViewLoadStateLoading) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loadState = CollectionViewLoadStateLoading;
//        self.historyView.loadState = self.loadState;
//        [self.historyView.historyCollectionView reloadData];
        self.footerIndicator.hidden = NO;
        NSLog(@"footerIndicator:%@",self.footerIndicator);
        [self.footerIndicator startAnimating];
    });
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSString* urlString = @"https://travel.knoci.cn/articles/list";
        [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"limit":@"", @"way":@"time", @"reverse":@"true", @"page":[NSString stringWithFormat:@"%d",self.page]} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            HistoryCollectionViewModel* historyCollectionViewModel = [HistoryCollectionViewModel yy_modelWithJSON:responseObject];
            NSDictionary* historyCollectionViewModelDictionary = [historyCollectionViewModel yy_modelToJSONObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.footerIndicator stopAnimating];
                int index = (int)self->_modelArray.count;
                [self updateWithData:historyCollectionViewModelDictionary];
                [self loadImageFormIndex:index];
                self.page++;
                self.loadState = CollectionViewLoadStateIdle;
            });
//            NSLog(@"%@", historyCollectionViewModelDictionary);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    });
}

- (void)setupLoadingIndicator {
    self.fullscreenIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.fullscreenIndicator.color = [UIColor lightGrayColor];
    self.fullscreenIndicator.frame = CGRectMake(176, 400, 40, 40);
    [self.view addSubview:self.fullscreenIndicator];
    [self.historyView bringSubviewToFront:self.fullscreenIndicator];
}

- (void)loadDataAndUpdateUI {
    self.loadState = CollectionViewLoadStateInit;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.fullscreenIndicator startAnimating];
        NSLog(@"开始加载");
        WaterFallLayout *layout = (WaterFallLayout *)self.historyView.historyCollectionView.collectionViewLayout;
    });
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSString* urlString = @"https://travel.knoci.cn/articles/list";
        [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"limit":@"", @"way":@"likes", @"reverse":@"true", @"page":@"1"} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            HistoryCollectionViewModel* historyCollectionViewModel = [HistoryCollectionViewModel yy_modelWithJSON:responseObject];
            NSDictionary* historyCollectionViewModelDictionary = [historyCollectionViewModel yy_modelToJSONObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.page++;
//                [self setHistoryView];
                [self updateWithData:historyCollectionViewModelDictionary];
                [self loadImageFormIndex:0];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    });
}

- (void)loadImageFormIndex:(int)index {
    __weak id WeakSelf = self;
    dispatch_group_t group = dispatch_group_create();
    NSLog(@"%d", self.modelArray.count);
    for (int i = index; i < _modelArray.count; i++) {
        dispatch_group_enter(group);
        NSLog(@"image:%@", self.modelArray[i][@"view"][0]);
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:self.modelArray[i][@"view"][0]] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (finished && image) {
                __strong HistoryViewController* strongSelf = WeakSelf;
                [strongSelf.imageArray addObject:image];
                dispatch_group_leave(group);
            } else {
                dispatch_group_leave(group);
            }
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.fullscreenIndicator stopAnimating];
        self.loadState = CollectionViewLoadStateIdle;
        if (index == 0) {
            [self setHistoryView];
            self.historyView.waterFallLayout.imageArray = [NSMutableArray array];
        }
        [self.historyView.waterFallLayout.imageArray addObjectsFromArray:self.imageArray];
        [self.historyView.historyCollectionView reloadData];
    });
}

- (void)setHistoryView{
    self.historyView = [[HistoryView alloc] initWithFrame:self.view.frame];
    self.historyView.historyCollectionView.delegate = self;
    self.historyView.historyCollectionView.dataSource = self;
    [self.historyView.historyCollectionView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    self.historyView.historyCollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.historyView];
    [self.historyView.historyCollectionView registerClass:[UICollectionReusableView class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                  withReuseIdentifier:@"LoadingFooter"];
}

- (void)updateWithData:(NSDictionary*)dictonary {
    [self.modelArray addObjectsFromArray:[dictonary valueForKey:@"data"]];
    NSLog(@"%lu %d", (unsigned long)self.modelArray.count, self.page);
    self.historyView.historyCollectionView.delegate = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*) collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HistoryCollectionViewCell* historyCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HistoryCollectionViewCell" forIndexPath:indexPath];
//    NSLog(@"%@", [self.modelArray[indexPath.item] valueForKey:@"video"]);
//    dispatch_group_t group = dispatch_group_create();
//        dispatch_group_enter(group);
//        [historyCollectionViewCell.historyImageView sd_setImageWithURL:[self.modelArray[indexPath.item] valueForKey:@"view"][0] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if ([historyCollectionViewCell.currentIndex isEqual:indexPath]) {
//                [self.imageDicitionary setValue:image forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.item]];
//            }
//            dispatch_group_leave(group);
//        }];
    [historyCollectionViewCell.historyImageView setImage:self.imageArray[indexPath.item]];
        [historyCollectionViewCell.avatarImageView sd_setImageWithURL:[self.modelArray[indexPath.item] valueForKey:@"avatar"] placeholderImage:[UIImage imageNamed:@"头像.jpg"] completed:nil];
        [historyCollectionViewCell.likesCountLabel setText:[NSString stringWithFormat:@"%@", [self.modelArray[indexPath.item] valueForKey:@"likes"]]];
        [historyCollectionViewCell.titleLabel setText:[self.modelArray[indexPath.item] valueForKey:@"title"]];
        [historyCollectionViewCell.nameLabel setText:[self.modelArray[indexPath.item] valueForKey:@"name"]];
        historyCollectionViewCell.backgroundColor = [UIColor whiteColor];
        historyCollectionViewCell.layer.cornerRadius = 5;
        historyCollectionViewCell.layer.masksToBounds = YES;
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        if (self.imageDicitionary.count == self.modelArray.count) {
//            [self.historyView.historyCollectionView reloadData];
//        }
//    });
    return historyCollectionViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.modelArray[indexPath.item][@"video"] boolValue]) {
        VideoViewController* videoViewController = [[VideoViewController alloc] init];
        videoViewController.articleModelDicitionary = [NSDictionary dictionary];
        videoViewController.articleModelDicitionary = self.modelArray[indexPath.item];
        videoViewController.hidesBottomBarWhenPushed = YES;
        videoViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:videoViewController animated:YES completion:nil];
    } else {
        ArticleViewController* articleViewController = [[ArticleViewController alloc] init];
        articleViewController.articleModelDictionary = [NSDictionary dictionary];
        articleViewController.articleModelDictionary = self.modelArray[indexPath.item];
        articleViewController.hidesBottomBarWhenPushed = YES;
        articleViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:articleViewController animated:YES completion:nil];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
