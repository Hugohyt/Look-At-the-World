//
//  AudioBooksButton.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioBooksButton : UIButton

@property (nonatomic, strong) UIImageView* myImageView;
@property (nonatomic, strong) UILabel* mainLabel;
@property (nonatomic, strong) UILabel* subLabel;

- (void)setImage:(UIImageView *)image mainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
