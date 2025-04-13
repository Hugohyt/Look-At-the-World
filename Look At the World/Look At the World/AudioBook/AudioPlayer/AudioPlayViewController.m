//
//  AudioPlayViewController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/18.
//

#import "AudioPlayViewController.h"

@interface AudioPlayViewController ()
@property (nonatomic, assign) CGRect initialFrame;
@end

@implementation AudioPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioPlayView = [[AudioPlayView alloc] init];
    self.audioPlayView.frame = self.view.bounds;
    [self.view addSubview:self.audioPlayView];
    //设置渐变色背景
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.audioPlayView.bounds;
    // 将 UIColor 对象转换为 CGColorRef 对象
    NSArray* cgColors = @[(id)[UIColor colorWithRed:255.0/255.0 green:165.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor];
    gradientLayer.colors = cgColors;
    NSArray* locations = @[@0.0, @0.6];
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [self.audioPlayView.layer insertSublayer:gradientLayer atIndex:0];
    [self SettingAuthor];
    self.currentButtonState = ButtonStateSecond;
    [self updateButtonAppearance];
    self.audioPlayView.coverImage.image = self.bookImage.image;
    self.audioPlayView.playBtn.selected = YES;
    //获取音频
    NSURL *audioURL = [NSURL URLWithString:self.dataModel.audio];
    NSLog(@"%@", self.dataModel.audio);
    
    [[AudioPlayerManager sharedManager] playAudioWithURL:audioURL];
    [self setupNotifications];
    [self updateUI];
    //手势事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnProgressView:)];
    [self.audioPlayView.slider addGestureRecognizer:tapGesture];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanOnProgressView:)];
    [self.audioPlayView.slider addGestureRecognizer:panGesture];
    [panGesture addTarget:self action:@selector(panGestureBegan:)];
    [panGesture addTarget:self action:@selector(panGestureEnded:)];
    [self.audioPlayView.playBtn addTarget:self action:@selector(playPauseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.audioPlayView.nextBtn addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.audioPlayView.priorBtn addTarget:self action:@selector(priorButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.audioPlayView.multipleBtn addTarget:self action:@selector(PressMultiple) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *panGesture1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.audioPlayView addGestureRecognizer:panGesture1];
}

#pragma mark - 手势控制进度条
// 处理滑动手势开始
- (void)panGestureBegan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.audioPlayView.slider mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.audioPlayView.multipleBtn.mas_bottom).mas_offset(37.5);
        }];
        [self.view layoutIfNeeded];
    }
}

// 处理滑动手势结束
- (void)panGestureEnded:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        [self.audioPlayView.slider mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.audioPlayView.multipleBtn.mas_bottom).mas_offset(40);
        }];
        [self.view layoutIfNeeded];
    }
}

- (void)handleTapOnProgressView:(UITapGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self.audioPlayView.slider];
    float progress = location.x / self.audioPlayView.slider.bounds.size.width;
    [[AudioPlayerManager sharedManager] seekToProgress:progress];
    [self.audioPlayView.slider setProgress:progress animated:YES];
}


// 处理滑动进度条事件
- (void)handlePanOnProgressView:(UIPanGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self.audioPlayView.slider];
    float progress = location.x / self.audioPlayView.slider.bounds.size.width;
    if (progress < 0) {
        progress = 0;
    } else if (progress > 1) {
        progress = 1;
    }
    AudioPlayerManager *player = [AudioPlayerManager sharedManager];
    [player seekToProgress:progress];
    [self updateUI];
    [self.audioPlayView.slider setProgress:progress animated:YES];
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.initialFrame = self.audioPlayView.frame;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.audioPlayView];
        
        // 只允许下滑（translation.y为正数）
        if (translation.y > 0) {
            CGRect frame = self.audioPlayView.frame;
            frame.origin.y += translation.y;
            self.audioPlayView.frame = frame;
        }
        
        [gesture setTranslation:CGPointZero inView:self.audioPlayView];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGFloat distance = self.audioPlayView.frame.origin.y - self.initialFrame.origin.y;
        
        // 只有当是下滑时才判断是否要退出
        if (distance > 0) {
            if (distance > self.audioPlayView.frame.size.height / 3) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.audioPlayView.frame = CGRectMake(0,
                                                        self.audioPlayView.frame.size.height,
                                                        self.audioPlayView.frame.size.width,
                                                        self.audioPlayView.frame.size.height);
                } completion:^(BOOL finished) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                }];
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    self.audioPlayView.frame = self.initialFrame;
                }];
            }
        } else {
            // 如果是上滑，直接回到原位
            [UIView animateWithDuration:0.3 animations:^{
                self.audioPlayView.frame = self.initialFrame;
            }];
        }
    }
}

#pragma mark - 设置控件位置
-(void) SettingAuthor {
    self.audioPlayView.titleLabel.text = self.dataModel.name;
    self.audioPlayView.titleLabel.numberOfLines = 1;
    [self.audioPlayView.titleScrollView addSubview:self.audioPlayView.titleLabel];
    [self.audioPlayView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.height.mas_offset(30);
    }];
    // 计算文本标签的大小
    [self.audioPlayView.titleLabel sizeToFit];
        
    // 设置滚动视图的内容大小
    self.audioPlayView.titleScrollView.contentSize = self.audioPlayView.titleLabel.frame.size;
    [self startAutoScroll];
}

- (void)startAutoScroll {
    // 计算滚动的总距离
    CGFloat totalDistance = self.audioPlayView.titleScrollView.contentSize.width - self.audioPlayView.titleScrollView.bounds.size.width;
    if (totalDistance <= 0) {
        return; // 如果内容宽度小于等于滚动视图宽度，无需滚动
    }
    // 滚动速度，单位：点/秒
    CGFloat scrollSpeed = 50.0;
    // 计算滚动所需的时间
    NSTimeInterval scrollDuration = totalDistance / scrollSpeed;
    // 滚动到文本末尾
    [UIView animateWithDuration:scrollDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGPoint bottomOffset = CGPointMake(totalDistance, 0);
        self.audioPlayView.titleScrollView.contentOffset = bottomOffset;
    } completion:^(BOOL finished) {
        // 滚动到末尾后，立即回到开头
        [UIView animateWithDuration:0.0 animations:^{
            self.audioPlayView.titleScrollView.contentOffset = CGPointZero;
        } completion:^(BOOL finished) {
            // 延迟一小段时间后再次开始滚动
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self startAutoScroll];
            });
        }];
    }];
}

#pragma mark - 监听
- (void) setupNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 播放开始
    [center addObserver:self
               selector:@selector(handlePlaybackStarted)
                   name:AudioPlayerDidStartPlayingNotification
                 object:nil];
    
    // 暂停
    [center addObserver:self
               selector:@selector(handlePlaybackPaused)
                   name:AudioPlayerDidPauseNotification
                 object:nil];
    
    // 播放完成
    [center addObserver:self
               selector:@selector(handlePlaybackFinished)
                   name:AudioPlayerDidFinishPlayingNotification
                 object:nil];
    
    // 在 setupNotifications 中添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleProgressUpdate:)
                                                 name:AudioPlayerDidUpdateProgressNotification
                                               object:nil];
}

    // 处理进度更新
- (void) handleProgressUpdate:(NSNotification *)notification {
//    if (self.audioPlayView.slider.state == UIControlEventTouchUpInside) return;
    
//    float progress = [notification.userInfo[@"progress"] floatValue];
    NSTimeInterval currentTime = [notification.userInfo[@"currentTime"] doubleValue];
    NSTimeInterval duration = [notification.userInfo[@"duration"] doubleValue];
    
//    // 更新滑动条（需判断是否正在拖动）
//    if (!self.audioPlayView.slider.highlighted) {
//        self.audioPlayView.slider.progress = progress;
//    }
    [self updateUI];
    // 更新时间标签
    self.audioPlayView.currentTimeLabel.text = [self formattedTime:currentTime];
    self.audioPlayView.totalTimeLabel.text = [self formattedTime:duration];
}

#pragma mark - UI 更新
- (void)updateUI {
    AudioPlayerManager *player = [AudioPlayerManager sharedManager];
    
    // 1. 更新播放/暂停按钮
    self.audioPlayView.playBtn.selected = player.isPlaying;
    
    // 2. 更新歌曲信息（示例）
    self.audioPlayView.titleLabel.text = self.dataModel.name;
//    self.audioPlayView.authorLabel.text = self.
    // 3. 更新进度条
    self.audioPlayView.slider.progress = player.progress;
    
    // 4. 更新时间标签
    self.audioPlayView.currentTimeLabel.text = [self formattedTime:player.currentTime];
    self.audioPlayView.totalTimeLabel.text = [self formattedTime:player.duration];
}

- (NSString *)formattedTime:(NSTimeInterval)time {
    int minutes = (int)time / 60;
    int seconds = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

#pragma mark - 按钮事件
- (void)playPauseButtonTapped:(UIButton *)sender {
    AudioPlayerManager *player = [AudioPlayerManager sharedManager];
    if (player.isPlaying) {
        [player pause];
        sender.selected = NO;
    } else {
        [player play];
        sender.selected = YES;
    }
}

- (void)nextButtonTapped:(UIButton*)sender {
    if (self.indexpath < self.chapterArr.count - 1) {
        self.dataModel = [AudioDetailDataModel yy_modelWithDictionary:self.chapterArr[++self.indexpath]];
        NSURL* urlString = [NSURL URLWithString:self.dataModel.audio];
        [[AudioPlayerManager sharedManager] playAudioWithURL:urlString];
        [self updateUI];
    } else {
        self.indexpath = -1;
        self.dataModel = [AudioDetailDataModel yy_modelWithDictionary:self.chapterArr[++self.indexpath]];
        NSURL* urlString = [NSURL URLWithString:self.dataModel.audio];
        [[AudioPlayerManager sharedManager] playAudioWithURL:urlString];
        [self updateUI];
    }
}

- (void)priorButtonTapped:(UIButton*)sender {
    if (self.indexpath > 0) {
        self.dataModel = [AudioDetailDataModel yy_modelWithDictionary:self.chapterArr[--self.indexpath]];
        NSURL* urlString = [NSURL URLWithString:self.dataModel.audio];
        [[AudioPlayerManager sharedManager] playAudioWithURL:urlString];
        [self updateUI];
    } else {
        self.indexpath = self.chapterArr.count;
        self.dataModel = [AudioDetailDataModel yy_modelWithDictionary:self.chapterArr[--self.indexpath]];
        NSURL* urlString = [NSURL URLWithString:self.dataModel.audio];
        [[AudioPlayerManager sharedManager] playAudioWithURL:urlString];
        [self updateUI];
    }
}

// 更新按钮外观
- (void)updateButtonAppearance {
    switch (_currentButtonState) {
        case ButtonStateInitial:
            [self.audioPlayView.multipleBtn setImage:[[UIImage imageNamed:@"0.7倍速.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            break;
            
        case ButtonStateSecond:
            [self.audioPlayView.multipleBtn setImage:[[UIImage imageNamed:@"1.0倍速.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            break;
            
        case ButtonStateThird:
            [self.audioPlayView.multipleBtn setImage:[[UIImage imageNamed:@"1.2倍速.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            break;
            
        case ButtonStateFourth:
            [self.audioPlayView.multipleBtn setImage:[[UIImage imageNamed:@"1.5倍速.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            break;
        case ButtonStateFifth:
            [self.audioPlayView.multipleBtn setImage:[[UIImage imageNamed:@"2.0倍速.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            break;
    }
//    添加动画效果（可选）
//    [UIView animateWithDuration:0.3 animations:^{
//        self.audioPlayView.multipleBtn.transform = CGAffineTransformMakeScale(1.1, 1.1);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.audioPlayView.multipleBtn.transform = CGAffineTransformIdentity;
//        }];
//    }];
}

// 处理不同状态下的操作（示例）
- (void)handleStateChange {
    AudioPlayerManager *player = [AudioPlayerManager sharedManager];
    switch (_currentButtonState) {
        case ButtonStateInitial:
            [player setPlaybackRate:0.7f];
            break;
        case ButtonStateSecond:
            [player setPlaybackRate:1.0f];
            break;
        case ButtonStateThird:
            [player setPlaybackRate:1.2f];
            break;
        case ButtonStateFourth:
            [player setPlaybackRate:1.5f];
            break;
        case ButtonStateFifth:
            [player setPlaybackRate:2.0f];
            break;
    }
}

-(void) PressMultiple {
    _currentButtonState = (_currentButtonState + 1) % 5;
    [self updateButtonAppearance];
    // 根据状态执行不同操作（可选）
    [self handleStateChange];
}

#pragma mark - 通知回调
- (void)handlePlaybackStarted {
    [self updateUI];
}

- (void)handlePlaybackPaused {
    [self updateUI];
}

- (void)handlePlaybackFinished {
    // 自动播放下一首（可选）
    [self nextButtonTapped:nil];
}

- (void)handleProgressUpdate {
    [self updateUI];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

 
