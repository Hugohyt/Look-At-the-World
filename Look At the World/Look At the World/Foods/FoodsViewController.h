//
//  FoodsViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import <UIKit/UIKit.h>
#import "ManagerGet.h"
#import <YYModel/YYModel.h>
#import <SDWebImage/SDWebImage.h>
#import "ExpandTransitionAnimator.h"
#import "ModelViewController.h"
#import "NoticeModel.h"
#import "FoodDetailController.h"
#import "LoginSubModel.h"
#import "FoodListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FoodsViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSMutableArray* foodArray;
@property (nonatomic, strong) FoodListModel* listModel;
@property (nonatomic, strong) LoginSubModel* personalModel;

@end

NS_ASSUME_NONNULL_END
