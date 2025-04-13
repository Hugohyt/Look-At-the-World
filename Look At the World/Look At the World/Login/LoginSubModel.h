//
//  LoginSubModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginSubModel : NSObject
@property (nonatomic, retain) NSString* uid;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* avatar;
@end

NS_ASSUME_NONNULL_END
