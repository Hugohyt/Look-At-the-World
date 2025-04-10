//
//  VideoModel.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/7.
//

#import <Foundation/Foundation.h>
#import "VideoSubModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoModel : NSObject

@property(strong, nonatomic, readwrite) NSString* code;
@property(strong, nonatomic, readwrite) VideoSubModel* data;
@property(strong, nonatomic, readwrite) NSString* msg;

@end

NS_ASSUME_NONNULL_END
