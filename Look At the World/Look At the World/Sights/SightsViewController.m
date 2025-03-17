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

@interface SightsViewController ()

@end

@implementation SightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sightsView = [[SightsView alloc] initWithFrame:self.view.frame];
    self.sightsView.sightsTableView.delegate = self;
    self.sightsView.sightsTableView.dataSource = self;
    [self.sightsView.sightsTableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.sightsView];
    
    UIImageView *layerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 660, 394, 136)];
    [layerImageView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.9 blue:0.8 alpha:1.0]];
    [self.sightsView addSubview:layerImageView];
    
    [self loadNavgationBar];
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
    
    UIView *searchView = [[UIView alloc] init];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 260, 36)];
    searchBar.placeholder = @"去有风的地方";
    searchBar.backgroundImage = [[UIImage alloc] init];
    searchBar.layer.cornerRadius = 8;
    searchBar.layer.masksToBounds = YES;
    
    [searchView addSubview:searchBar];
    
    UIButton *avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    avatarButton.frame = CGRectMake(0, 0, 5, 5);
    avatarButton.layer.cornerRadius = 18; // 圆形头像
    avatarButton.layer.masksToBounds = YES;
    [avatarButton setImage:[UIImage imageNamed:@"头像.jpg"] forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar addSubview:searchView];
    [self.navigationController.navigationBar addSubview:avatarButton];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationController.navigationBar.mas_left).offset(10);
        make.right.equalTo(avatarButton.mas_left).offset(-10);
        make.height.mas_equalTo(36);
        make.centerY.equalTo(self.navigationController.navigationBar.mas_centerY);
    }];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(searchView);
    }];
    
    [avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationController.navigationBar.mas_right).offset(-10);
        make.centerY.equalTo(self.navigationController.navigationBar.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 240;
    } else if (indexPath.section == 1){
        return 200;
    } else {
        return 120;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScrollTableViewCell* scrollTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ScrollTableViewCell"];
        
        NSArray* array = [NSArray arrayWithObjects:[UIImage imageNamed:@"北京.jpg"], [UIImage imageNamed:@"西安.jpg"],  [UIImage imageNamed:@"甘肃.jpg"], [UIImage imageNamed:@"内蒙古.jpg"], [UIImage imageNamed:@"杭州.jpg"], [UIImage imageNamed:@"哈尔滨.jpg"], [UIImage imageNamed:@"西藏.jpg"], [UIImage imageNamed:@"香港.jpg"], nil];
        NSArray* titleArray = [NSArray arrayWithObjects:@"北 京", @"西 安", @"甘 肃", @"内蒙古", @"杭 州", @"哈尔滨", @"西 藏", @"香 港", nil];
        
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
        
        return scrollTableViewCell;
        
    } else if (indexPath.section == 1) {
        
        ButtonTableViewCell* buttonTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ButtonTableViewCell"];
        buttonTableViewCell.layer.masksToBounds = NO; // 关闭裁剪
        buttonTableViewCell.layer.shadowColor = [UIColor blackColor].CGColor; // 阴影颜色
        buttonTableViewCell.layer.shadowOffset = CGSizeMake(2, 2); // 阴影偏移量
        buttonTableViewCell.layer.shadowOpacity = 0.3; // 阴影透明度
        buttonTableViewCell.layer.shadowRadius = 4;
        
        return buttonTableViewCell;
        
    } else {
        ListTableViewCell* listTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell"];
        listTableViewCell.layer.masksToBounds = NO; // 关闭裁剪
        listTableViewCell.layer.shadowColor = [UIColor blackColor].CGColor; // 阴影颜色
        listTableViewCell.layer.shadowOffset = CGSizeMake(2, 2); // 阴影偏移量
        listTableViewCell.layer.shadowOpacity = 0.3; // 阴影透明度
        listTableViewCell.layer.shadowRadius = 4;
        return listTableViewCell;
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
