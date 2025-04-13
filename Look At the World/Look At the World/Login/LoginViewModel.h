//
//  LoginViewModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import <AFNetworking/AFNetworking.h>
#import "LoginModel.h"
#import "CodeModel.h"
#import "NoticeModel.h"
#import "RegisterModel.h"
#import "ManagerPost.h"

typedef void (^DataBlock)(CodeModel * _Nonnull mainModel);
typedef void (^ErrorBlock)(NSError * _Nonnull error);
//typedef void (^NetworkCompletionHandler)(id _Nullable responseObject, NSError * _Nullable error);
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, copy) NSString* emailInputText;
@property (nonatomic, assign) BOOL internalIsQQEmail;
@property (nonatomic, copy) NSString* passwordInputText;
@property (nonatomic, assign) BOOL internalIsQQpassword;

- (void)Email:(NSString*) email CodeWithSuccess:(DataBlock) dataBlock
      failure:(ErrorBlock) errorBlock;
- (void)PostUrlString:(NSString*) urlString parameters:(NSDictionary*) parameters completion:(NetworkCompletionHandler)completion;


@end

NS_ASSUME_NONNULL_END
