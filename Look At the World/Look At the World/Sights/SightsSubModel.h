//
//  SightsSubModel.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SightsSubModel : NSObject

@property (strong, nonatomic, readwrite)NSString* sid;
@property (strong, nonatomic, readwrite)NSString* name;
@property (strong, nonatomic, readwrite)NSString* describe;
@property (strong, nonatomic, readwrite)NSArray* view;
@property (strong, nonatomic, readwrite)NSString* location;
@property (strong, nonatomic, readwrite)NSString* article;
@property (strong, nonatomic, readwrite)NSString* created_at;
@property (strong, nonatomic, readwrite)NSString* updated_at;

@end

NS_ASSUME_NONNULL_END
