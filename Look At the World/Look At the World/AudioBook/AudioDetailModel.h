//
//  AudioDetailModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSArray* data;
@property (nonatomic, assign) NSString* msg;
@end

NS_ASSUME_NONNULL_END
