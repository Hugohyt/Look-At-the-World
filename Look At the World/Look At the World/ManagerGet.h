//
//  ManagerGet.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/2.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>

typedef void (^NetworkCompletionHandler)(id  _Nullable responseObject, NSError * _Nullable error);
NS_ASSUME_NONNULL_BEGIN

@interface ManagerGet : NSObject

+ (instancetype)sharedManager;

- (void)GetRequestWithURL:(NSString *)urlString completion:(NetworkCompletionHandler)completion;
- (void)GetRequestWithURL:(NSString *)urlString andParameters:(NSDictionary*) parameters completion:(NetworkCompletionHandler)completion;
@end

NS_ASSUME_NONNULL_END
