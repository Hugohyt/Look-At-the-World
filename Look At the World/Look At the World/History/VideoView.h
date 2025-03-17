//
//  VideoView.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoView : UIView

@property (strong, nonatomic, readwrite)UIButton* likeButton;
@property (strong, nonatomic, readwrite)UIButton* commentButton;
@property (strong, nonatomic, readwrite)UIButton* starButton;
@property (strong, nonatomic, readwrite)UILabel* likesLabel;
@property (strong, nonatomic, readwrite)UILabel* commentsLabel;
@property (strong, nonatomic, readwrite)UILabel* starsLabel;

@end

NS_ASSUME_NONNULL_END
