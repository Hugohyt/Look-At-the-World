//
//  ManagerGet1.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/10.
//

#import "ManagerGet.h"
static ManagerGet* managerSington = nil;
@implementation ManagerGet

+ (nonnull instancetype)sharedManager {
    if (!managerSington) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            managerSington = [[super allocWithZone:NULL] init];
        });
    }
    return managerSington;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [ManagerGet sharedManager];
}

- (void)GetRequestWithURL:(NSString *)urlString andParameters:(NSDictionary*) parameters completion:(NetworkCompletionHandler)completion {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion) {
            completion(nil, error);
        }
    }];
}

- (void)GetRequestWithURL:(NSString *)urlString completion:(NetworkCompletionHandler)completion {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion) {
            completion(nil, error);
        }
    }];
}


@end
