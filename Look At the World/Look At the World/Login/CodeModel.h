//
//  CodeModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <Foundation/Foundation.h>
#import "CodeSubModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CodeModel : NSObject
@property (nonatomic, retain) NSString* code;
@property NSDictionary* data;
@property NSString* msg;
@end

NS_ASSUME_NONNULL_END
