//
//  AVPlayerManager.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/19.
//

#import "AVPlayerManager.h"

@implementation AVPlayerManager

+ (AVPlayerManager*)shareManager {
    static dispatch_once_t once;
    static AVPlayerManager* manager;
    dispatch_once(&once, ^{
        manager = [[AVPlayerManager alloc] init];
        manager.playerArray = [[NSMutableArray alloc] init];
    });
    return manager;
}

- (void)play:(AVPlayer *)player {
    [self.playerArray enumerateObjectsUsingBlock:^(AVPlayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj pause];
    }];
    if (![self.playerArray containsObject:player]) {
        [self.playerArray addObject:player];
    }
    [player play];
}

- (void)pause:(AVPlayer*)player {
    if ([self.playerArray containsObject:player]) {
        [player pause];
    }
}

- (void)pauseAll {
    [self.playerArray enumerateObjectsUsingBlock:^(AVPlayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj pause];
    }];
}

- (void)replay:(AVPlayer *)player {
    [self.playerArray enumerateObjectsUsingBlock:^(AVPlayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj pause];
    }];
    if (![self.playerArray containsObject:player]) {
        [player seekToTime:kCMTimeZero];
        [self play:player];
    } else {
        [self.playerArray addObject:player];
        [self play:player];
    }
}

- (void)removeAllPlayers {
    [self.playerArray removeAllObjects];
}

@end
