//
//  AudioPlayerManager.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/8.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

// 播放状态通知
extern NSString *const AudioPlayerDidStartPlayingNotification;  // 开始播放
extern NSString *const AudioPlayerDidPauseNotification;        // 暂停
extern NSString *const AudioPlayerDidStopNotification;         // 停止
extern NSString *const AudioPlayerDidFinishPlayingNotification; // 播放完成
extern NSString *const AudioPlayerDidUpdateProgressNotification; // 进度更新

@interface AudioPlayerManager : NSObject

+ (instancetype)sharedManager;

- (void)playAudioWithURL:(NSURL *)url;
- (void)seekToProgress:(float)progress;
- (void)setPlaybackRate:(float)rate;
- (void)play;
- (void)pause;
- (void)stop;

@property (nonatomic, strong, readonly) NSURL *currentAudioURL; // 当前播放的音频URL
@property (nonatomic, assign, readonly) BOOL isPlaying;         // 是否正在播放
@property (nonatomic, assign) float progress;         // 当前播放进度（0.0 ~ 1.0）
@property (nonatomic, assign) NSTimeInterval currentTime; // 当前播放时间（秒）
@property (nonatomic, assign) NSTimeInterval duration;    // 总时长（秒）

@end

NS_ASSUME_NONNULL_END
