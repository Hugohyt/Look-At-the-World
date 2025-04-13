//
//  FoodDetailController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/31.
//

#import <UIKit/UIKit.h>
#import "FoodDetailView.h"
#import "FoodDetailModel.h"
#import <SDWebImage/SDWebImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface FoodDetailController : UIViewController
@property (nonatomic, strong) FoodDetailView* detailsView;
@property (nonatomic, strong) UIButton* exitBtn;
@property (nonatomic, strong) FoodDetailModel* detailsModel;
@end

NS_ASSUME_NONNULL_END
