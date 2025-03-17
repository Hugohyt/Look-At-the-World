//
//  VideoViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import "VideoViewController.h"
#import "VideoView.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.videoView = [[VideoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.videoView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.videoView];
    
    NSString* urlString = [[NSBundle mainBundle] pathForResource:@"视频" ofType:@"mp4"];
    NSURL* videoURL = [[NSURL alloc] initFileURLWithPath: urlString];
    
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:videoURL];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    playLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    playLayer.shouldRasterize = YES;
    playLayer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.videoView.layer addSublayer:playLayer];
    [self.player play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runLoopTheMovie) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pause)];
    [self.videoView addGestureRecognizer:tapGesture];
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"返回.jpg"] forState:UIControlStateNormal];
    exitButton.frame = CGRectMake(0, 0, 20, 20);
    [exitButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:exitButton];
    
    [self loadButtons];
    [self loadLabelsAndAvatar];
    
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, 394, 10)];
    self.progressSlider.minimumTrackTintColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
    
    UIImage* normalImage = [self drawCircleWithSize:5];
    
    [self.progressSlider setThumbImage:normalImage forState:UIControlStateNormal];
    [self.progressSlider addTarget:self action:@selector(largerThumb) forControlEvents:UIControlEventTouchDown];
    [self.progressSlider addTarget:self action:@selector(smallThumb) forControlEvents:UIControlEventTouchUpInside];
    [self.progressSlider addTarget:self action:@selector(changeProgress) forControlEvents:UIControlEventValueChanged];
    [self monitoringPlayback:self.player.currentItem];
        [self.videoView addSubview:self.progressSlider];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    self.timeLabel.font = [UIFont systemFontOfSize:28];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(0, 400, 394, self.view.frame.size.height - 470);
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor lightGrayColor].CGColor];
    self.gradientLayer.locations = @[@0.0, @1.0];
}

- (void)loadLabelsAndAvatar {
    self.nameLabel = [[UILabel alloc] init];
    self.detailLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(10, 720, 394, 40);
    self.detailLabel.frame = CGRectMake(10, 750, 394, 40);
    [self.videoView addSubview:self.nameLabel];
    [self.videoView addSubview:self.detailLabel];
    [self.nameLabel setText:@"@意梦"];
    [self.detailLabel setText:@"苏轼诗中的“天上宫阙”此刻具像化了"];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.detailLabel.textColor = [UIColor lightGrayColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    self.detailLabel.font = [UIFont systemFontOfSize:18];
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.frame = CGRectMake(334, 460, 50, 50);
    self.avatarImageView.image = [UIImage imageNamed:@"头像.jpg"];
    self.avatarImageView.layer.cornerRadius = 25;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.videoView addSubview:self.avatarImageView];
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
    [self.videoView.layer addSublayer:self.gradientLayer];
    
    CMTime changedTime = CMTimeMakeWithSeconds(self.progressSlider.value, 600);
    self.timeLabel.frame = CGRectMake(self.videoView.frame.size.width/2 - 100, self.videoView.frame.size.height - 180, 1200, 40);
    [self.timeLabel setText:[NSString stringWithFormat:@"%@ / %@",[self formatTimeWithCMTime:self.player.currentItem.currentTime], [self formatTimeWithCMTime:self.player.currentItem.duration]]];
    NSLog(@"%@", self.timeLabel.text);
    [self.videoView addSubview:self.timeLabel];
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

//- (void)dealloc {
//    [self removeObserver:self.playTimeObserver forKeyPath:@"self.player.currentItem"];
//}

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

- (void)loadButtons {
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.likesLabel = [[UILabel alloc] init];
    self.commentsLabel = [[UILabel alloc] init];
    self.starsLabel = [[UILabel alloc] init];
    
    [self.likeButton setImage:[UIImage imageNamed:@"视频点赞.jpg"] forState:UIControlStateNormal];
    [self.commentButton setImage:[UIImage imageNamed:@"评论.jpg"] forState:UIControlStateNormal];
    [self.starButton setImage:[UIImage imageNamed:@"收藏.jpg"] forState:UIControlStateNormal];
    
    self.likeButton.frame = CGRectMake(334, 540, 50, 50);
    self.likesLabel.frame = CGRectMake(334, 590, 50, 20);
    self.commentButton.frame = CGRectMake(334, 630, 50, 50);
    self.commentsLabel.frame = CGRectMake(334, 680, 50, 20);
    self.starButton.frame = CGRectMake(334, 720, 50, 50);
    self.starsLabel.frame = CGRectMake(334, 770, 50, 20);
    
    [self.likesLabel setText:@"2198"];
    [self.commentsLabel setText:@"364"];
    [self.starsLabel setText:@"493"];
    self.likesLabel.font = [UIFont systemFontOfSize:16];
    self.commentsLabel.font = [UIFont systemFontOfSize:16];
    self.starsLabel.font = [UIFont systemFontOfSize:16];
    [self.likesLabel setTextColor:[UIColor whiteColor]];
    [self.commentsLabel setTextColor:[UIColor whiteColor]];
    [self.starsLabel setTextColor:[UIColor whiteColor]];
    self.likesLabel.textAlignment = NSTextAlignmentCenter;
    self.commentsLabel.textAlignment = NSTextAlignmentCenter;
    self.starsLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.videoView addSubview:self.likeButton];
    [self.videoView addSubview:self.commentButton];
    [self.videoView addSubview:self.starButton];
    [self.videoView addSubview:self.likesLabel];
    [self.videoView addSubview:self.commentsLabel];
    [self.videoView addSubview:self.starsLabel];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pause {
    if (self.player.rate == 1.0) {
        [self.player setRate:0.0];
        self.pauseIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂停.jpg"]];
        self.pauseIconImageView.frame = CGRectMake((self.view.frame.size.width - 100) / 2, (self.view.frame.size.height - 100) / 2, 100, 100);
        [self.videoView addSubview:self.pauseIconImageView];
    } else {
        [self.player setRate:1.0];
        self.pauseIconImageView.frame = CGRectMake(0, 0, 0, 0);
        
    }
}

- (void)runLoopTheMovie {
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            NSLog(@"可以播放");
        } else {
            NSLog(@"加载失败");
        }
    }
}

- (void)videoPlay {
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        [self.player play];
        NSLog(@"开始播放");
    } else {
        NSLog(@"播放失败");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
