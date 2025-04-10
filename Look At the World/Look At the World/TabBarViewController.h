//
//  TabBarViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import <UIKit/UIKit.h>
#import "LoginSubModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TabBarViewController : UITabBarController

@property (nonatomic, strong) LoginSubModel* personalModel;
- (instancetype)initWithUserModel:(LoginSubModel *)userModel;
- (void)loadTabBar;

@end

NS_ASSUME_NONNULL_END
