//
//  VideoView.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/13.
//

#import "VideoView.h"
#import "AVFoundation/AVFoundation.h"
#import "AVPlayerManager.h"

@implementation VideoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.containerView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:self.containerView];
        
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pause)];
    [self addGestureRecognizer:tapGesture];
    
    [self loadButtons];
    [self loadLabelsAndAvatar];
    
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 60, 394, 10)];
    self.progressSlider.minimumTrackTintColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    
    UIImage* normalImage = [self drawCircleWithSize:5];
    
    [self.progressSlider setThumbImage:normalImage forState:UIControlStateNormal];
    [self.progressSlider addTarget:self action:@selector(largerThumb) forControlEvents:UIControlEventTouchDown];
    [self.progressSlider addTarget:self action:@selector(smallThumb) forControlEvents:UIControlEventTouchUpInside];
    [self.progressSlider addTarget:self action:@selector(changeProgress) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.progressSlider];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    self.timeLabel.font = [UIFont systemFontOfSize:28];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(0, 400, 394, self.frame.size.height - 470);
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor lightGrayColor].CGColor];
    self.gradientLayer.locations = @[@0.0, @1.0];
    
    self.PlayerItemString = [NSString string];
    
    self.fullscreenIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.fullscreenIndicator.frame = CGRectMake((self.frame.size.width - 80)/2,
                                                  (self.frame.size.height - 80)/2,
                                                  80, 80);
        self.fullscreenIndicator.hidesWhenStopped = YES;
        [self addSubview:self.fullscreenIndicator];
        
        // 设置初始可见状态
        self.progressSlider.hidden = YES;
        self.timeLabel.hidden = YES;
        self.likeButton.hidden = YES;
        self.likesLabel.hidden = YES;
        self.commentButton.hidden = YES;
        self.commentsLabel.hidden = YES;
        self.starButton.hidden = YES;
        self.starsLabel.hidden = YES;
        self.nameLabel.hidden = YES;
        self.detailLabel.hidden = YES;
        self.avatarImageView.hidden = YES;
    
    return self;
}

- (void)startDownloadBackgroundTaskWithString:(NSString*)string {
    if (self.playerItem && ![self.PlayerItemString isEqualToString:string]) {
        [self.player pause];
        [self.player replaceCurrentItemWithPlayerItem:nil];
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        self.player = nil;
            [self.playerLayer removeFromSuperlayer];
            self.playerLayer = nil;
        NSLog(@"清除清除");
    }
    
    NSLog(@"string:%@ %@", self.PlayerItemString, string);
    if (self.playerItem && [self.PlayerItemString isEqualToString:string]) {
        NSLog(@"%@ %@", self.PlayerItemString, string);
        NSLog(@"已加载好直接用");
        return;
    }
    
    [self.fullscreenIndicator startAnimating];
        self.progressSlider.hidden = YES;
        self.timeLabel.hidden = YES;
        self.pauseIconImageView.hidden = YES;  // 确保暂停图标隐藏
        
        // 隐藏所有交互控件
        self.likeButton.hidden = YES;
        self.likesLabel.hidden = YES;
        self.commentButton.hidden = YES;
        self.commentsLabel.hidden = YES;
        self.starButton.hidden = YES;
        self.starsLabel.hidden = YES;
        self.nameLabel.hidden = YES;
        self.detailLabel.hidden = YES;
        self.avatarImageView.hidden = YES;
    
    NSString* urlString = string;
    NSURL* videoURL = [[NSURL alloc] initWithString:urlString];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:videoURL];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    
self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
self.playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
self.playerLayer.shouldRasterize = YES;
self.playerLayer.rasterizationScale = [UIScreen mainScreen].scale;
[self.containerView.layer addSublayer:self.playerLayer];
//    [self.player play];
    
    if (self.playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runLoopTheMovie) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    self.PlayerItemString = string;
}

- (void)changeValue {
    UILabel* progress = [[UILabel alloc] init];
    progress.backgroundColor = [UIColor clearColor];
    [progress setTextColor:[UIColor lightGrayColor]];
    
}

- (void)largerThumb {
    UIImage* normalImage = [self drawCircleWithSize:30];
    [self.progressSlider setThumbImage:normalImage forState:UIControlStateNormal];
}

- (void)smallThumb {
    UIImage* largerImage = [self drawCircleWithSize:5];
    [self.progressSlider setThumbImage:largerImage forState:UIControlStateNormal];
    self.timeLabel.frame = CGRectMake(0, 0, 0, 0);
    self.likeButton.frame = CGRectMake(334, 540, 50, 50);
    self.likesLabel.frame = CGRectMake(334, 590, 50, 20);
    self.commentButton.frame = CGRectMake(334, 630, 50, 50);
    self.commentsLabel.frame = CGRectMake(334, 680, 50, 20);
    self.starButton.frame = CGRectMake(334, 720, 50, 50);
    self.starsLabel.frame = CGRectMake(334, 770, 50, 20);
    self.nameLabel.frame = CGRectMake(10, 720, 394, 40);
    self.detailLabel.frame = CGRectMake(10, 750, 394, 40);
    self.avatarImageView.frame = CGRectMake(334, 460, 50, 50);
    [self.gradientLayer removeFromSuperlayer];
}

- (UIImage*)drawCircleWithSize:(CGFloat)size {
    // 1. 创建画布
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2. 画白色圆点
    CGRect circleRect = CGRectMake(0, 0, size, size);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(context, circleRect);
    
    // 3. 获取图像
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;
}

- (void)loadButtons {
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.likesLabel = [[UILabel alloc] init];
    self.commentsLabel = [[UILabel alloc] init];
    self.starsLabel = [[UILabel alloc] init];
    
    self.likeButton.tag = 00;
    self.starButton.tag = 00;
    
    [self.likeButton setImage:[UIImage imageNamed:@"视频点赞.jpg"] forState:UIControlStateNormal];
    [self.commentButton setImage:[UIImage imageNamed:@"评论.jpg"] forState:UIControlStateNormal];
    [self.starButton setImage:[UIImage imageNamed:@"收藏.jpg"] forState:UIControlStateNormal];
    
    [self.likeButton addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    [self.starButton addTarget:self action:@selector(star:) forControlEvents:UIControlEventTouchUpInside];
    
    self.likeButton.frame = CGRectMake(334, 540, 50, 50);
    self.likesLabel.frame = CGRectMake(334, 590, 50, 20);
    self.commentButton.frame = CGRectMake(334, 630, 50, 50);
    self.commentsLabel.frame = CGRectMake(334, 680, 50, 20);
    self.starButton.frame = CGRectMake(334, 720, 50, 50);
    self.starsLabel.frame = CGRectMake(334, 770, 50, 20);
    
//    [self.likesLabel setText:@"2198"];
//    [self.commentsLabel setText:@"364"];
//    [self.starsLabel setText:@"493"];
    self.likesLabel.font = [UIFont systemFontOfSize:16];
    self.commentsLabel.font = [UIFont systemFontOfSize:16];
    self.starsLabel.font = [UIFont systemFontOfSize:16];
    [self.likesLabel setTextColor:[UIColor whiteColor]];
    [self.commentsLabel setTextColor:[UIColor whiteColor]];
    [self.starsLabel setTextColor:[UIColor whiteColor]];
    self.likesLabel.textAlignment = NSTextAlignmentCenter;
    self.commentsLabel.textAlignment = NSTextAlignmentCenter;
    self.starsLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.likeButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.starButton];
    [self addSubview:self.likesLabel];
    [self addSubview:self.commentsLabel];
    [self addSubview:self.starsLabel];
}

- (void)like:(UIButton*)button {
    if (button.tag == 00) {
        [button setImage:[UIImage imageNamed:@"已点赞.jpg"] forState:UIControlStateNormal];
        int num = [_likesLabel.text intValue];
        num++;
        [_likesLabel setText:[NSString stringWithFormat:@"%d", num]];
        button.tag = 01;
    } else {
        [button setImage:[UIImage imageNamed:@"视频点赞.jpg"] forState:UIControlStateNormal];
        int num = [_likesLabel.text intValue];
        num--;
        [_likesLabel setText:[NSString stringWithFormat:@"%d", num]];
        button.tag = 00;
    }
}

- (void)star:(UIButton*)button {
    if (button.tag == 00) {
        [button setImage:[UIImage imageNamed:@"已收藏.jpg"] forState:UIControlStateNormal];
        int num = [_starsLabel.text intValue];
        num++;
        [_starsLabel setText:[NSString stringWithFormat:@"%d", num]];
        button.tag = 01;
    } else {
        [button setImage:[UIImage imageNamed:@"收藏.jpg"] forState:UIControlStateNormal];
        int num = [_starsLabel.text intValue];
        num--;
        [_starsLabel setText:[NSString stringWithFormat:@"%d", num]];
        button.tag = 00;
    }
}

- (void)loadLabelsAndAvatar {
    self.nameLabel = [[UILabel alloc] init];
    self.detailLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(10, 720, 394, 40);
    self.detailLabel.frame = CGRectMake(10, 750, 394, 40);
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailLabel];
//    [self.nameLabel setText:@"@意梦"];
//    [self.detailLabel setText:@"苏轼诗中的“天上宫阙”此刻具像化了"];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.detailLabel.textColor = [UIColor lightGrayColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    self.detailLabel.font = [UIFont systemFontOfSize:18];
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.frame = CGRectMake(334, 460, 50, 50);
//    self.avatarImageView.image = [UIImage imageNamed:@"头像.jpg"];
    self.avatarImageView.layer.cornerRadius = 25;
    self.avatarImageView.layer.masksToBounds = YES;
    [self addSubview:self.avatarImageView];
}

- (void)runLoopTheMovie {
    [self.player seekToTime:kCMTimeZero];
    [self videoPlay];
}   

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            NSLog(@"加载好了 准备播放");
            [self.fullscreenIndicator stopAnimating];
                        
                        // 显示所有交互元素
                        self.progressSlider.hidden = NO;
                        self.timeLabel.hidden = NO;
                        self.likeButton.hidden = NO;
                        self.likesLabel.hidden = NO;
                        self.commentButton.hidden = NO;
                        self.commentsLabel.hidden = NO;
                        self.starButton.hidden = NO;
                        self.starsLabel.hidden = NO;
                        self.nameLabel.hidden = NO;
                        self.detailLabel.hidden = NO;
                        self.avatarImageView.hidden = NO;
        } else if (playerItem.status == AVPlayerItemStatusFailed){
            NSLog(@"加载失败");
//            [self retry];
        }
        if (self.delegate) {
            [self.delegate onPlayItemStatusUpdate:playerItem.status];
        }
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//- (void)retry {
//
//}

- (void)videoPlay {
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        [[AVPlayerManager shareManager] play:self.player];
        self.pauseIconImageView.frame = CGRectMake(0, 0, 0, 0);
        [self monitoringPlayback:self.player.currentItem];
        NSLog(@"开始播放");
    } else {
        NSLog(@"播放失败");
    }
}

- (void)playVideo {
    [self videoPlay];
}

- (void)pause {
    if (self.player.rate == 1.0) {
            [[AVPlayerManager shareManager] pause:self.player];
            if (!self.pauseIconImageView) {
                self.pauseIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂停.jpg"]];
            }
            // 只在非加载状态显示暂停图标
            if (!self.fullscreenIndicator.isAnimating) {
                self.pauseIconImageView.frame = CGRectMake((self.frame.size.width - 100)/2,
                                                          (self.frame.size.height - 100)/2,
                                                          100, 100);
                [self addSubview:self.pauseIconImageView];
            }
        } else {
            [self.player setRate:1.0];
            self.pauseIconImageView.frame = CGRectMake(0, 0, 0, 0);
        }
}

- (void)changeProgress {
    self.isSliding = YES;
    if (self.playTimeObserver) {
        [self.player removeTimeObserver:self.playTimeObserver];
        self.playTimeObserver = nil;
    }
    self.likeButton.frame = CGRectMake(0, 0, 0, 0);
    self.likesLabel.frame = CGRectMake(0, 0, 0, 0);
    self.commentButton.frame = CGRectMake(0, 0, 0, 0);
    self.commentsLabel.frame = CGRectMake(0, 0, 0, 0);
    self.starButton.frame = CGRectMake(0, 0, 0, 0);
    self.starsLabel.frame = CGRectMake(0, 0, 0, 0);
    self.nameLabel.frame = CGRectMake(0, 0, 0, 0);
    self.detailLabel.frame = CGRectMake(0, 0, 0, 0);
    self.avatarImageView.frame = CGRectMake(0, 0, 0, 0);
    
    [self.layer addSublayer:self.gradientLayer];
    NSLog(@"%f",self.progressSlider.value);
    
    CMTime changedTime = CMTimeMakeWithSeconds(self.progressSlider.value, 600);
    self.timeLabel.frame = CGRectMake(self.frame.size.width/2 - 100, self.frame.size.height - 180, 1200, 40);
    [self.timeLabel setText:[NSString stringWithFormat:@"%@ / %@",[self formatTimeWithCMTime:self.player.currentItem.currentTime], [self formatTimeWithCMTime:self.player.currentItem.duration]]];
    NSLog(@"%@", self.timeLabel.text);
    [self addSubview:self.timeLabel];
    [self.player.currentItem seekToTime:changedTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        if (finished) {
            self.isSliding = NO;
            [self monitoringPlayback:self.player.currentItem];
        }
    }]; //为什么要改成 toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero 和没有有什么区别
}

- (NSString*)formatTimeWithCMTime:(CMTime)time {
    if (CMTIME_IS_INDEFINITE(time) || CMTIME_IS_INVALID(time)) {
        return @"00:00";
    }
    NSTimeInterval totalSeconds = CMTimeGetSeconds(time);
    NSInteger minutes = (NSInteger)totalSeconds / 60;
    NSInteger seconds = (NSInteger)totalSeconds % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes,(long)seconds];
}

- (void)monitoringPlayback:(AVPlayerItem *)item {
    __weak typeof(self)WeakSelf = self;
    
    self.playTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float currentPlayTime = CMTimeGetSeconds(WeakSelf.player.currentItem.currentTime);
        
        if (CMTIME_IS_NUMERIC(WeakSelf.player.currentItem.duration)) {
            WeakSelf.progressSlider.maximumValue = CMTimeGetSeconds(WeakSelf.player.currentItem.duration);
        }
        
        if (WeakSelf.isSliding == NO) {
            WeakSelf.progressSlider.value = currentPlayTime;
        } else {
            return;
        }
    }];
}

@end
