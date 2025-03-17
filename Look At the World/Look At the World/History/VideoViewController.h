//
//  VideoViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoViewController : UIViewController

@property (strong, nonatomic, readwrite)AVPlayer* player;
@property (strong, nonatomic, readwrite)UIImageView* pauseIconImageView;
@property (strong, nonatomic, readwrite)VideoView* videoView;
@property (strong, nonatomic, readwrite)UISlider* progressSlider;
@property (assign, nonatomic, readwrite)BOOL isSliding;
@property (strong, nonatomic, readwrite)id playTimeObserver;
@property (strong, nonatomic, readwrite)UILabel *timeLabel;
@property (strong, nonatomic, readwrite)UIButton* likeButton;
@property (strong, nonatomic, readwrite)UIButton* commentButton;
@property (strong, nonatomic, readwrite)UIButton* starButton;
@property (strong, nonatomic, readwrite)UILabel* likesLabel;
@property (strong, nonatomic, readwrite)UILabel* commentsLabel;
@property (strong, nonatomic, readwrite)UILabel* starsLabel;
@property (strong, nonatomic, readwrite)UILabel* nameLabel;
@property (strong, nonatomic, readwrite)UILabel* detailLabel;
@property (strong, nonatomic, readwrite)UIImageView* avatarImageView;
@property (strong, nonatomic, readwrite)CAGradientLayer* gradientLayer;

@end

NS_ASSUME_NONNULL_END
