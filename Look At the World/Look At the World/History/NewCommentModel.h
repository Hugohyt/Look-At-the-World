//
//  NewCommentModel.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/9.
//

#import <Foundation/Foundation.h>
#import "SubNewCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewCommentModel : NSObject

@property (strong, nonatomic, readwrite)NSString* code;
@property (strong, nonatomic, readwrite)SubNewCommentModel* data;
@property (strong, nonatomic, readwrite)NSString* msg;

@end

NS_ASSUME_NONNULL_END
