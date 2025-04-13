//
//  LoginModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <Foundation/Foundation.h>
#import "LoginSubModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject
@property (nonatomic, retain) NSString* code;
@property (nonatomic, retain) NSString* msg;
@property (nonatomic, retain) LoginSubModel* data;
@end

NS_ASSUME_NONNULL_END

