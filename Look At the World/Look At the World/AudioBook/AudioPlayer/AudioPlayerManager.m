//
//  AudioPlayerManager.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/8.
//

#import "AudioPlayerManager.h"

NSString *const AudioPlayerDidStartPlayingNotification = @"AudioPlayerDidStartPlayingNotification";
NSString *const AudioPlayerDidPauseNotification = @"AudioPlayerDidPauseNotification";
NSString *const AudioPlayerDidStopNotification = @"AudioPlayerDidStopNotification";
NSString *const AudioPlayerDidFinishPlayingNotification = @"AudioPlayerDidFinishPlayingNotification";
NSString *const AudioPlayerDidUpdateProgressNotification = @"AudioPlayerDidUpdateProgressNotification";

@interface AudioPlayerManager ()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *currentItem;
@property (nonatomic, strong) id timeObserver; // 用于监听播放进度
@property (nonatomic, strong) id loadTimeObserver;
@property (nonatomic, assign) BOOL isWaitingForBuffer;
@property (nonatomic, assign) NSTimeInterval pendingSeekTime;
@end

@implementation AudioPlayerManager

+ (instancetype)sharedManager {
    static AudioPlayerManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AudioPlayerManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    [self removeObservers];
}

- (void)playAudioWithURL:(NSURL *)url {
    if (!url) return;
    NSURL *requestedURL = nil;
    // 1. 首先检查 currentItem 是否存在
    if (self.currentItem) {
        // 2. 安全类型转换
        if ([self.currentItem.asset isKindOfClass:[AVURLAsset class]]) {
            AVURLAsset *urlAsset = (AVURLAsset *)self.currentItem.asset;
            requestedURL = urlAsset.URL;
        } else {
            NSLog(@"当前 asset 不是 AVURLAsset 类型");
        }
    } else {
        NSLog(@"当前没有可用的 playerItem");
    }
    // 使用 requestedURL（可能为 nil）
    if (requestedURL) {
        NSLog(@"当前播放 URL: %@", requestedURL);
        if([url.absoluteString isEqualToString:requestedURL.absoluteString]) {
            [self.player play];
            return;
        }
    }
    // 1. 停止当前播放
    [self stop];
    // 2. 创建新的 AVPlayerItem
    self.currentItem = [AVPlayerItem playerItemWithURL:url];
    self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
   [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
   [audioSession setActive:YES error:nil];

    
    // 3. 添加监听（播放完成、进度更新）
    [self addObservers];
    [self setPlaybackRate:1.0f];
    // 4. 开始播放
    [self play];
    // 5. 发送通知：开始播放新音频
    [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerDidStartPlayingNotification object:nil];
}



- (void)setPlaybackRate:(float)rate {
    if (!self.player || !self.currentItem) {
            NSLog(@"播放器未准备好");
            return;
    }
    float validRate = fmaxf(0.5, fminf(rate, 3.0));
    [self.player pause];
    self.player.rate = validRate;
    if (validRate > 0) {
        [self.player play];
    }
    if (@available(iOS 7.0, *)) {
        self.currentItem.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmTimeDomain;
    }
}

- (void)play {
    [self.player play];
    [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerDidStartPlayingNotification object:nil];
}

- (void)pause {
    [self.player pause];
    [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerDidPauseNotification object:nil];
}

- (void)stop {
    [self.player pause];
    [self removeObservers];
    self.player = nil;
    self.currentItem = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerDidStopNotification object:nil];
}

- (void)seekToProgress:(float)progress {
    if (!self.currentItem || progress < 0 || progress > 1) return;
    
    // 计算目标时间（总时长 * 进度）
    NSTimeInterval duration = CMTimeGetSeconds(self.currentItem.duration);
    NSTimeInterval targetTime = duration * progress;
    CMTime cmTime = CMTimeMakeWithSeconds(targetTime, NSEC_PER_SEC);
    // 检查是否已缓冲到目标位置
    NSArray *loadedRanges = self.currentItem.loadedTimeRanges;
    BOOL isBuffered = NO;
    //其实没什么用
    for (NSValue *rangeValue in loadedRanges) {
        CMTimeRange range = [rangeValue CMTimeRangeValue];
        NSTimeInterval start = CMTimeGetSeconds(range.start);
        NSTimeInterval end = start + CMTimeGetSeconds(range.duration);
        if (targetTime >= start && targetTime <= end) {
            isBuffered = YES;
            break;
        }
    }
    
    if (isBuffered) {
        // 已缓冲，直接跳转
        [self.player seekToTime:CMTimeMakeWithSeconds(targetTime, NSEC_PER_SEC)];
    } else {
        // 未缓冲，记录目标位置并暂停
        self.isWaitingForBuffer = YES;
        self.pendingSeekTime = targetTime;
        [self.player pause];
        
        // 添加缓冲监听
        [self startMonitoringBufferForPendingSeek];
    }
    // 跳转到指定时间
    [self.player seekToTime:cmTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

#pragma mark - Observers
-(void) startMonitoringBufferForPendingSeek {
    __weak typeof(self) weakSelf = self;
    self.loadTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1)
                                                                 queue:dispatch_get_main_queue()
                                                                 usingBlock:^(CMTime time) {
        [weakSelf checkBufferForPendingSeek];
    }];
}

- (void)checkBufferForPendingSeek {
    if (!self.isWaitingForBuffer) 
        return;
    
    NSArray* loadedRanges = self.currentItem.loadedTimeRanges;
    for (NSValue *rangeValue in loadedRanges) {
        CMTimeRange range = [rangeValue CMTimeRangeValue];
        NSTimeInterval start = CMTimeGetSeconds(range.start);
        NSTimeInterval end = start + CMTimeGetSeconds(range.duration);
        
        if (self.pendingSeekTime >= start && self.pendingSeekTime <= end) {
            // 已缓冲到目标位置
            [self.player seekToTime:CMTimeMakeWithSeconds(self.pendingSeekTime, NSEC_PER_SEC)];
            [self.player play];
            self.isWaitingForBuffer = NO;
            [self removeBufferObserver];
            break;
        }
    }
}

- (void)removeBufferObserver {
    if (self.timeObserver) {
        [self.player removeTimeObserver:self.loadTimeObserver];
        self.loadTimeObserver = nil;
    }
}


- (void)addObservers {
    // 1. 监听播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.currentItem];
    
    // 2. 监听播放进度（每秒更新一次）
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1)
                                                                 queue:dispatch_get_main_queue()
                                                             usingBlock:^(CMTime time) {
        float progress = CMTimeGetSeconds(time) / CMTimeGetSeconds(weakSelf.currentItem.duration);
        weakSelf.progress = progress;
        weakSelf.currentTime = CMTimeGetSeconds(time);
        weakSelf.duration = CMTimeGetSeconds(weakSelf.currentItem.duration);
        
        // 发送进度更新通知（携带进度值）
        [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerDidUpdateProgressNotification
                                                            object:nil
                                                          userInfo:@{
            @"progress": @(progress),
            @"currentTime": @(CMTimeGetSeconds(time)),
            @"duration": @(CMTimeGetSeconds(weakSelf.currentItem.duration))
        }];
    }];
}
                         

- (void)removeObservers {
    if (self.timeObserver) {
        [self.player removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)playerDidFinishPlaying:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:AudioPlayerDidFinishPlayingNotification object:nil];
}

#pragma mark - Getters
- (NSURL *)currentAudioURL {
    return [(AVURLAsset *)self.currentItem.asset URL];
}

- (BOOL)isPlaying {
    return (self.player.rate != 0) && (self.player.error == nil);
}

- (float)progress {
    if (self.currentItem.duration.value == 0) return 0;
    return CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.currentItem.duration);
}

- (NSTimeInterval)currentTime {
    return CMTimeGetSeconds(self.player.currentTime);
}

- (NSTimeInterval)duration {
    return CMTimeGetSeconds(self.currentItem.duration);
}

@end
