//
//  VideoResourceLoader.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/7.
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoResourceLoader : NSObject<AVAssetResourceLoaderDelegate>

- (instancetype)initWithURL:(NSURL *)url;
- (AVURLAsset *)createPlayableAsset;

@end

NS_ASSUME_NONNULL_END
