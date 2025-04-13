//
//  VideoView.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/13.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoResourceLoader.h"

@protocol AVPlayerUpdateDelegate <NSObject>

- (void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status;

@end

NS_ASSUME_NONNULL_BEGIN

@interface VideoView : UIView

@property (strong, nonatomic, readwrite)AVPlayer* player;
@property (strong, nonatomic, readwrite)AVPlayerLayer* playerLayer;
@property (strong, nonatomic, readwrite)AVPlayerItem* playerItem;

@property (strong, nonatomic, readwrite)UIImageView* pauseIconImageView;
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
@property (strong, nonatomic, readwrite)UIView* containerView;
@property (strong, nonatomic, readwrite)id<AVPlayerUpdateDelegate>delegate;
@property (nonatomic, strong)NSString* PlayerItemString;
@property (nonatomic ,strong)NSDictionary* articleModelDicitionay;
@property (strong, nonatomic, readwrite)UIActivityIndicatorView* fullscreenIndicator;

- (void)startDownloadBackgroundTaskWithString:(NSString*)string;
- (void)startDownloadBackgroundTaskWithString:(NSString*)string success:(void (^)(void))successCallback;
- (void)playVideo;

@end

NS_ASSUME_NONNULL_END
