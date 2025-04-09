//
//  AudioDetailsController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/19.
//

#import "AudioDetailsController.h"

@interface AudioDetailsController ()
@property (nonatomic, strong) UIImageView* bookImage;
@end

@implementation AudioDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chapterArr = [NSArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    CGRect viewFrame = self.view.frame;
    //    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGRect adjustedFrame = CGRectMake(0, 0, viewFrame.size.width, 754.333);
    self.bookImage = [[UIImageView alloc] init];
    self.audioDetailsView = [[AudioDetailsView alloc] init];
    self.audioDetailsView.frame = adjustedFrame;
    [self.view addSubview:self.audioDetailsView];
    self.audioDetailsView.tableView.delegate = self;
    self.audioDetailsView.tableView.dataSource = self;
    self.audioDetailsView.tableView.estimatedRowHeight = 50;
    self.audioDetailsView.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pressleft)];
    id manager = [ManagerGet sharedManager];
    NSString* url = @"https://travel.knoci.cn/audiobooks/details";
    // 构建完整的 URL，将参数拼接在 URL 后面
    NSMutableString *urlWithParams = [NSMutableString stringWithString:url];
    [urlWithParams appendString:@"?"];
    [urlWithParams appendFormat:@"bid=%@", self.dataModel.bid];
    NSLog(@"%@", urlWithParams);
    [manager GetRequestWithURL:urlWithParams completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
        if(error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    NSLog(@"服务器返回错误码: %ld，错误信息: %@", (long)errorModel.code, errorModel.msg);
                }
            } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {
                // server throw exception
                NSLog(@"服务器抛出异常，请稍后重试");
            } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
                // network error
                NSLog(@"网络连接错误，请检查网络设置");
            } else {
                // 其他未知错误
                NSLog(@"发生未知错误: %@", error.localizedDescription);
            }
        } else {
            self.listModel = [AudioDetailModel yy_modelWithJSON:responseObject];
            NSLog(@"%@", self.listModel.data);
            self.chapterArr = self.listModel.data;
            // 在主线程中更新 UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.audioDetailsView.tableView reloadData];
            });
        }
    }];
    
}

-(void) pressleft {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section != 2) {
        return 1;
    } else {
        return self.chapterArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        AudioDetailsAuthorCell* cell = [self.audioDetailsView.tableView dequeueReusableCellWithIdentifier:@"AudioDetailsAuthorCell"];
        if(!cell) {
            cell = [[AudioDetailsAuthorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AudioDetailsAuthorCell"];
        }
        double rating = [self.dataModel.rating doubleValue];
        cell.scoreLabel.text = [NSString stringWithFormat:@"%.1f", rating];
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld万", self.dataModel.playcount];
        cell.chaoterLabel.text = [NSString stringWithFormat:@"%ld章", self.dataModel.chapternum];
        cell.renewLabel.text = @"已完结";
        cell.bookName.text = self.dataModel.name;
        cell.authorName.text = self.dataModel.author;
        NSURL *imageURL = [NSURL URLWithString:self.dataModel.view];
        [cell.bookImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"图片加载失败%@", self.dataModel.name);
            } else {
                NSLog(@"图片加载成功%@", self.dataModel.name);
                self.bookImage.image = cell.bookImage.image;
            }
    //        dispatch_group_leave(imageLoadGroup);
        }];
        return cell;
    } else if(indexPath.section == 2){
        AudioDetailsSubListCell* listCell = [self.audioDetailsView.tableView dequeueReusableCellWithIdentifier:@"AudioDetailsSubListCell"];
        if(!listCell) {
            listCell = [[AudioDetailsSubListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AudioDetailsSubListCell"];
        }
        listCell.numberLabel.text = [NSString stringWithFormat:@"%@", self.chapterArr[indexPath.row][@"chapter"]];
        listCell.title.text = self.chapterArr[indexPath.row][@"name"];
        NSInteger duration = [self.chapterArr[indexPath.row][@"duration"] intValue];
        NSInteger minutes = duration / 60;
        NSInteger seconds = duration % 60;
        listCell.playTime.text = [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
        return listCell;
    } else {
        AudioDetailsProfileCell* profileCell = [self.audioDetailsView.tableView dequeueReusableCellWithIdentifier:@"AudioDetailsProfileCell"];
        if(!profileCell) {
            profileCell = [[AudioDetailsProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AudioDetailsProfileCell"];
        }
        profileCell.profileLabel.text = [NSString stringWithFormat:@"%@", self.dataModel.description1];
        return profileCell;
    }
}

#pragma mark - selectCell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 2) {
        AudioPlayViewController* player = [[AudioPlayViewController alloc] init];
        player.modalPresentationStyle = UIModalPresentationFullScreen;
//        player.previousViewControllerView = self.audioDetailsView;
        player.bookImage = [[UIImageView alloc] init];
        player.bookImage.image = self.bookImage.image;
        player.chapterArr = [NSArray array];
        player.chapterArr = self.chapterArr;
        player.indexpath = indexPath.row;
        player.dataModel = [AudioDetailDataModel yy_modelWithDictionary:self.chapterArr[indexPath.row]];
        [self presentViewController:player animated:YES completion:nil];
    }
}

@end
