//
//  AVPlayerManager.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/19.
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerManager : NSObject

@property (nonatomic, strong) NSMutableArray<AVPlayer *> *playerArray;

+ (AVPlayerManager *)shareManager;
- (void)play:(AVPlayer *)player;
- (void)pause:(AVPlayer *)player;
- (void)pauseAll;
- (void)replay:(AVPlayer *)player;
- (void)removeAllPlayers;

@end

NS_ASSUME_NONNULL_END
