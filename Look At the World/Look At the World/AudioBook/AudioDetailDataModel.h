//
//  AudioDetailDataModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailDataModel : NSObject
@property (nonatomic, assign) NSString* did;
@property (nonatomic, assign) NSString* bid;
@property (nonatomic, assign) NSInteger chapter;
@property (nonatomic, assign) NSString* audio;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSString* created_at;
@property (nonatomic, assign) NSString* updated_at;

@end

NS_ASSUME_NONNULL_END
