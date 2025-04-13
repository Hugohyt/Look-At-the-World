//
//  ModelViewController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/29.
//

#import "ModelViewController.h"

@interface ModelViewController ()

@end

@implementation ModelViewController


+ (ModelViewController *)creatWithDictionary:(NSDictionary *)foodMessage {
    ModelViewController* con = [[ModelViewController alloc] init];
    dispatch_group_t imageLoadGroup = dispatch_group_create();

    con.foodImage = [[UIImageView alloc] init];
    [con.view addSubview:con.foodImage];
    [con.foodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(con.view);
        make.top.equalTo(con.view).offset(15);
        make.width.equalTo(con.view).multipliedBy(0.9);
        make.height.equalTo(con.foodImage.mas_width).multipliedBy(260.0/333.0);
    }];

    dispatch_group_enter(imageLoadGroup);
    NSURL *imageURL = [NSURL URLWithString:foodMessage[@"view"][0]];
    [con.foodImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"图片加载失败");
        } else {
            NSLog(@"图片加载成功");
        }
        dispatch_group_leave(imageLoadGroup);
    }];

    con.foodLabel = [[UILabel alloc] init];
    con.location = [[UILabel alloc] init];
    con.describe = [[UILabel alloc] init];

    [con.view addSubview:con.foodLabel];
    [con.view addSubview:con.location];
    [con.view addSubview:con.describe];

    [con.foodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(con.view);
        make.top.equalTo(con.foodImage.mas_bottom).offset(20);
        make.width.equalTo(con.view).multipliedBy(0.8);
        make.height.mas_equalTo(30);
    }];

    [con.location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(con.foodLabel.mas_centerX).offset(20);
        make.top.equalTo(con.foodLabel.mas_bottom).offset(5);
        make.right.equalTo(con.foodLabel.mas_right);
        make.height.mas_equalTo(25);
    }];

    [con.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(con.view);
        make.top.equalTo(con.location.mas_bottom).offset(20);
        make.width.equalTo(con.view).multipliedBy(0.8);
    }];
    
    con.foodLabel.text = foodMessage[@"name"];
    con.foodLabel.textAlignment = NSTextAlignmentCenter;
    con.foodLabel.font = [UIFont fontWithName:@"zihunjianqishoushu_T" size:24];

    NSString* str = [NSString stringWithFormat:@"——%@", foodMessage[@"location"]];
    con.location.text = str;
    con.location.textAlignment = NSTextAlignmentLeft;
    con.location.font = [UIFont fontWithName:@"zihunjianqishoushu_T" size:18];

    con.describe.numberOfLines = 0;
    con.describe.text = foodMessage[@"describe"];
    con.describe.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:18];
    
    return con;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.9 blue:0.8 alpha:1.0];
}

@end
