//
//  SightsModel.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SightsModel : NSObject

@property (strong, nonatomic, readwrite)NSString* code;
@property (strong, nonatomic, readwrite)NSArray* data;
@property (strong, nonatomic, readwrite)NSString* msg;

@end

NS_ASSUME_NONNULL_END
