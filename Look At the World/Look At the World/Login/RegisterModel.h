//
//  RegisterModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterModel : NSObject
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* avatar;
@property (nonatomic, retain) NSString* code;
@end

NS_ASSUME_NONNULL_END
