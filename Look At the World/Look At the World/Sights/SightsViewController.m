//
//  SightsViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "SightsViewController.h"
#import "ScrollTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "ListTableViewCell.h"
#import "Masonry.h"
#import "AFNetworking/AFNetworking.h"
#import "SightsModel.h"
#import "YYModel/YYModel.h"
#import "SDWebImage/SDWebImage.h"
#import "SightsWebViewController.h"
#import "ManagerPost.h"

@interface SightsViewController ()
@property (nonatomic, strong) UIButton* avatarButton;
@end

@implementation SightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"人间有美";
    self.sightsModelArray = [NSMutableArray array];
    self.sightsView = [[SightsView alloc] initWithFrame:self.view.frame];
    self.sightsView.sightsTableView.delegate = self;
    self.sightsView.sightsTableView.dataSource = self;
    [self.sightsView.sightsTableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.sightsView];
    
    // 创建容器
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];

    // 创建按钮
    self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.avatarButton.frame = CGRectMake(1, 1, 34, 34); // 四周留2pt边距
    self.avatarButton.layer.cornerRadius = 17;
    self.avatarButton.layer.masksToBounds = YES;
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;

    // 设置图片
    UIImage *originalImage = [[ManagerPost sharedManager] getavatarImage];

    if (@available(iOS 15.0, *)) {
        UIButtonConfiguration *config = [UIButtonConfiguration plainButtonConfiguration];
        config.image = originalImage;
        self.avatarButton.configuration = config;
    } else {
        [self.avatarButton setImage:originalImage forState:UIControlStateNormal];
    }

    // 添加交互
    [self.avatarButton addTarget:self action:@selector(pushMine) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:self.avatarButton];

    // 添加到导航栏
    UIBarButtonItem *avatarItem = [[UIBarButtonItem alloc] initWithCustomView:container];
    self.navigationItem.rightBarButtonItem = avatarItem;
    
    UIImageView *layerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 660, 394, 300)];
    [layerImageView setBackgroundColor:[UIColor whiteColor]];
    [self.sightsView addSubview:layerImageView];
    [self loadDataAndUpdateUI];
    
    [self loadNavgationBar];
}
-(void) pushMine {
    PersonalController* personalController = [[PersonalController alloc] init];
    [self.navigationController pushViewController:personalController animated:YES];
}
- (void)loadDataAndUpdateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loadState = TableViewLoadStateInit;
        NSLog(@"开始加载");
    });
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSString* urlString = @"https://travel.knoci.cn/scenes/list";
        [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"limit":@""} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            SightsModel* sightsModel = [SightsModel yy_modelWithJSON:responseObject];
            NSLog(@"%@", sightsModel);
            NSDictionary* sightsModelDictionary = [sightsModel yy_modelToJSONObject];
            NSLog(@"%@", sightsModelDictionary);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.loadState = TableViewLoadStateIdle;
                [self.sightsModelArray addObjectsFromArray:sightsModelDictionary[@"data"]];
                [self.sightsView.sightsTableView reloadData];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)loadNavgationBar {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
//    UIView *searchView = [[UIView alloc] init];
//    
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 260, 36)];
//    searchBar.placeholder = @"去有风的地方";
//    searchBar.backgroundImage = [[UIImage alloc] init];
//    searchBar.layer.cornerRadius = 8;
//    searchBar.layer.masksToBounds = YES;
//    
//    [searchView addSubview:searchBar];
    
//    UIButton *avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    avatarButton.frame = CGRectMake(0, 0, 5, 5);
//    avatarButton.layer.cornerRadius = 18; // 圆形头像
//    avatarButton.layer.masksToBounds = YES;
//    [avatarButton setImage:[UIImage imageNamed:@"头像.jpg"] forState:UIControlStateNormal];
    
//    [self.navigationController.navigationBar addSubview:searchView];
//    [self.navigationController.navigationBar addSubview:avatarButton];
    
//    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.navigationController.navigationBar.mas_left).offset(10);
//        make.right.equalTo(avatarButton.mas_left).offset(-10);
//        make.height.mas_equalTo(36);
//        make.centerY.equalTo(self.navigationController.navigationBar.mas_centerY);
//    }];
//    
//    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(searchView);
//    }];
    
//    [avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.navigationController.navigationBar.mas_right).offset(-10);
//        make.centerY.equalTo(self.navigationController.navigationBar.mas_centerY);
//        make.width.height.mas_equalTo(40);
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sightsModelArray.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return 240;
//    } else if (indexPath.section == 1){
//        return 200;
//    } else {
//        return 120;
//    }
//}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScrollTableViewCell* scrollTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ScrollTableViewCell"];
        
        NSArray* array = [NSArray arrayWithObjects:[UIImage imageNamed:@"北京.jpg"], [UIImage imageNamed:@"深圳.jpg"],  [UIImage imageNamed:@"三亚.jpg"], [UIImage imageNamed:@"杭州.jpg"], [UIImage imageNamed:@"桂林.jpg"], [UIImage imageNamed:@"大连.jpg"], [UIImage imageNamed:@"大理.jpg"], [UIImage imageNamed:@"成都.jpg"], nil];
        NSArray* titleArray = [NSArray arrayWithObjects:@"北 京", @"深 圳", @"三 亚", @"杭 州", @"桂 林", @"大 连", @"大 理", @"成 都", nil];
        
        for (int i = 0; i <= 15; i++) {
            UIImageView* imageView = [[UIImageView alloc] init];
            if (i == 15) {
                imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, 240);
            } else {
                imageView.frame = CGRectMake((i + 1) * (394 - 20), 0, 394 - 20, 240);
            }
            imageView.image = array[i % 8];

            [scrollTableViewCell.sightsScrollView addSubview:imageView];
            
            imageView.layer.cornerRadius = 10;
            imageView.layer.masksToBounds = YES;
            
            UILabel* titleLabel = [[UILabel alloc] init];
            titleLabel.text = titleArray[i % 8];
            titleLabel.frame = CGRectMake((i + 1) * 374 + 20, 160, 400, 70);
            [titleLabel setFont:[UIFont fontWithName:@"zihungutengshoushu_T" size:60]];
            [titleLabel setTextColor:[UIColor colorWithRed:0.95 green:0.9 blue:0.8 alpha:1.0]];
            
            titleLabel.layer.shadowColor = [UIColor colorWithRed:0.3 green:0.25 blue:0.2 alpha:1].CGColor;
            titleLabel.layer.shadowOffset = CGSizeMake(1, 1);
            titleLabel.layer.shadowOpacity = 0.8;
            titleLabel.layer.shadowRadius = 1;
            
            [scrollTableViewCell.sightsScrollView addSubview:titleLabel];
            
        }
        scrollTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return scrollTableViewCell;
        
    } else if (indexPath.section == 1) {
        
        ButtonTableViewCell* buttonTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ButtonTableViewCell"];
        buttonTableViewCell.layer.masksToBounds = NO;
        buttonTableViewCell.layer.shadowColor = [UIColor blackColor].CGColor;
        buttonTableViewCell.layer.shadowOffset = CGSizeMake(2, 2);
        buttonTableViewCell.layer.shadowOpacity = 0.3;
        buttonTableViewCell.layer.shadowRadius = 4;
        
        [buttonTableViewCell.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.tag = idx;
            [obj addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }];
        return buttonTableViewCell;
    } else {
        ListTableViewCell* listTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell"];
        
        [listTableViewCell.sightsImageView sd_setImageWithURL:self.sightsModelArray[indexPath.section - 2][@"view"][0] completed:nil];
        listTableViewCell.sightsNameLabel.text = self.sightsModelArray[indexPath.section - 2][@"name"];
        listTableViewCell.sightsLocationLabel.text = self.sightsModelArray[indexPath.section - 2][@"location"];
        listTableViewCell.sightsProductionLabel.text = self.sightsModelArray[indexPath.section - 2][@"describe"];
        
        listTableViewCell.layer.masksToBounds = NO;
        listTableViewCell.layer.shadowColor = [UIColor blackColor].CGColor;
        listTableViewCell.layer.shadowOffset = CGSizeMake(2, 2);
        listTableViewCell.layer.shadowOpacity = 0.3;
        listTableViewCell.layer.shadowRadius = 4;
        return listTableViewCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1) {
        SightsWebViewController* sightsWebViewController = [[SightsWebViewController alloc] init];
        sightsWebViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        sightsWebViewController.subSightsModelDictionary = self.sightsModelArray[indexPath.section - 2];
        //    [self presentViewController:sightsWebViewController animated:YES completion:nil];
        sightsWebViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sightsWebViewController animated:YES];
    } else {
        return;
    }
}

- (void)click:(UIButton*)button {
    SightsWebViewController* sightsWebViewController = [[SightsWebViewController alloc] init];
    sightsWebViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    sightsWebViewController.hidesBottomBarWhenPushed = YES;
    switch (button.tag) {
        case 0:
            sightsWebViewController.url = @"https://index.knoci.cn/%E5%8C%97%E4%BA%AC";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 1:
            sightsWebViewController.url = @"https://index.knoci.cn/%E6%B7%B1%E5%9C%B3";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 2:
            sightsWebViewController.url = @"https://index.knoci.cn/%E5%8C%97%E4%BA%AC";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 3:
            sightsWebViewController.url = @"https://index.knoci.cn/%E6%9D%AD%E5%B7%9E";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 4:
            sightsWebViewController.url = @"https://index.knoci.cn/%E6%A1%82%E6%9E%97";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 5:
            sightsWebViewController.url = @"https://index.knoci.cn/%E5%8C%97%E4%BA%AC";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 6:
            sightsWebViewController.url = @"https://index.knoci.cn/%E5%A4%A7%E8%BF%9E";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 7:
            sightsWebViewController.url = @"https://index.knoci.cn/%E5%A4%A7%E7%90%86";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        case 8:
            sightsWebViewController.url = @"https://index.knoci.cn/%E6%88%90%E9%83%BD";
            [self.navigationController pushViewController:sightsWebViewController animated:YES];
            break;
        default:
            break;
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
