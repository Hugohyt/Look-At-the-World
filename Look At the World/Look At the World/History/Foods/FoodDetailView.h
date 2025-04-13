//
//  FoodDetailView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface FoodDetailView : UIView

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIScrollView* imageScrollView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* name;
@property (nonatomic, strong) UILabel* placeLabel;
@property (nonatomic, strong) UILabel* place;
@property (nonatomic, strong) UILabel* detailsLabel;
@property (nonatomic, strong) UILabel* details;
@property (nonatomic, strong) UILabel* cookBookLabel;
@property (nonatomic, strong) UILabel* cookBook;
 
@end

NS_ASSUME_NONNULL_END
