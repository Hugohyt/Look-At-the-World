//
//  TabBarViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "TabBarViewController.h"
#import "SightsViewController.h"
#import "FoodsViewController.h"
#import "BooksViewController.h"
#import "HistoryViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.shadowImage = [[UIImage alloc] init];
    self.tabBar.backgroundImage = [[UIImage alloc] init];
    for (NSString *familyName in [UIFont familyNames]) {
            NSLog(@"字体家族名称: %@", familyName);
            for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
                NSLog(@"\t字体名称: %@", fontName);
            }
        }
    [self loadTabBar];
}


- (void)loadTabBar {
    NSLog(@"loadTabBar");
    SightsViewController* sightsViewController = [[SightsViewController alloc] init];
    FoodsViewController* foodsViewController = [[FoodsViewController alloc] init];
    BooksViewController* booksViewController = [[BooksViewController alloc] init];
    HistoryViewController* historyViewController = [[HistoryViewController alloc] init];
    
    
    UIImage *sightsTabImage = [[UIImage imageNamed:@"风景.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *foodsTabImage = [[UIImage imageNamed:@"美食.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *booksTabImage = [[UIImage imageNamed:@"书籍.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *historyTabImage = [[UIImage imageNamed:@"历史.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UITabBarItem *tabBarSightsItem = [[UITabBarItem alloc] initWithTitle:@"人间有美" image:sightsTabImage selectedImage:sightsTabImage];
    UITabBarItem *tabBarFoodsItem = [[UITabBarItem alloc] initWithTitle:@"人间有味" image:foodsTabImage selectedImage:foodsTabImage];
    UITabBarItem *tabBarBooksItem = [[UITabBarItem alloc] initWithTitle:@"人间有道" image:booksTabImage selectedImage:booksTabImage];
    UITabBarItem *tabBarHistoryItem = [[UITabBarItem alloc] initWithTitle:@"人间有趣" image:historyTabImage selectedImage:historyTabImage];
    
    UIFont *customFont = [UIFont fontWithName:@"zihun98hao-lingfangti" size:18];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: customFont,
                                                        NSForegroundColorAttributeName: [UIColor brownColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: customFont,
                                                        NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.25 blue:0 alpha:1]} forState:UIControlStateSelected];
    
    tabBarSightsItem.titlePositionAdjustment = UIOffsetMake(0, +10);
    tabBarFoodsItem.titlePositionAdjustment = UIOffsetMake(0, +10);
    tabBarBooksItem.titlePositionAdjustment = UIOffsetMake(0, +10);
    tabBarHistoryItem.titlePositionAdjustment = UIOffsetMake(0, +10);
    
    
    
//    tabBarSightsItem.imageInsets = UIEdgeInsetsMake(16, 0, -16, 0);
//    tabBarFoodsItem.imageInsets = UIEdgeInsetsMake(16, 0, -16, 0);
//    tabBarBooksItem.imageInsets = UIEdgeInsetsMake(16, 0, -16, 0);
//    tabBarHistoryItem.imageInsets = UIEdgeInsetsMake(16, 0, -16, 0);
    
    sightsViewController.tabBarItem = tabBarSightsItem;
    foodsViewController.tabBarItem = tabBarFoodsItem;
    booksViewController.tabBarItem = tabBarBooksItem;
    historyViewController.tabBarItem = tabBarHistoryItem;
    
    
    UINavigationController *navSightsViewController = [[UINavigationController alloc] initWithRootViewController: sightsViewController];
    UINavigationController *navFoodsViewController = [[UINavigationController alloc] initWithRootViewController: foodsViewController];
    UINavigationController *navBooksViewController = [[UINavigationController alloc] initWithRootViewController: booksViewController];
    UINavigationController *navHistoryViewController = [[UINavigationController alloc] initWithRootViewController: historyViewController];
    
    NSArray *array = [NSArray arrayWithObjects:navSightsViewController, navFoodsViewController, navBooksViewController, navHistoryViewController, nil];
    
    self.viewControllers = array;
}



@end
