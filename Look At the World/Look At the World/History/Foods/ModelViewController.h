//
//  ModelViewController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/29.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface ModelViewController : UIViewController
+(ModelViewController *)creatWithDictionary:(NSDictionary*) foodMessage;

@property (nonatomic, strong) UIImageView* foodImage;
@property (nonatomic, strong) UILabel* foodLabel;
@property (nonatomic, strong) UILabel* location;
@property (nonatomic, strong) UILabel* describe;

@end

NS_ASSUME_NONNULL_END
