//
//  ManagerPost.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/27.
//

#import "ManagerPost.h"
static ManagerPost* managerSington = nil;
@implementation ManagerPost

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
    return [ManagerPost sharedManager];
}

- (void)sendPostRequestWithURL:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(NetworkCompletionHandler)completion {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if (manager && urlString && parameters) {
        [manager POST:urlString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(completion) {
                completion(responseObject, nil);
            }
            LoginModel* loginmodel = [LoginModel yy_modelWithJSON:responseObject];
            LoginSubModel* loginSubModel = loginmodel.data;
            if(loginSubModel.name != nil) {
                self.personalModel = loginmodel.data;
                NSLog(@"data = %@", self.personalModel.name);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(completion) {
                completion(nil, error);
            }
        }];
    } 
}

- (LoginSubModel*) getModel {
    return self.personalModel;
}

- (void)uploadImageToServer:(NSString *)url
                     image:(UIImage *)image
                parameters:(NSDictionary *)parameters
               completion:(NetworkCompletionHandler)completion {
    
    // 1. 创建会话管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2. 设置超时时间
    manager.requestSerializer.timeoutInterval = 30.0;
    
    // 3. 图片压缩（可根据需要调整）
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    if (!imageData) {
        if (completion) {
            completion(nil, [NSError errorWithDomain:@"com.yourapp.upload"
                                                code:-1
                                            userInfo:@{NSLocalizedDescriptionKey: @"图片数据转换失败"}]);
        }
        return;
    }
    
    // 4. 发起上传请求
    [manager POST:url
       parameters:nil headers:parameters
          constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
              [formData appendPartWithFileData:imageData
                                          name:@"file"
                                      fileName:@"upload.jpg"
                                      mimeType:@"image/jpg"];
          }
          progress:^(NSProgress * _Nonnull uploadProgress) {
              // 进度回调（可选）
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"上传进度: %.2f%%", uploadProgress.fractionCompleted * 100);
              });
          }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              // 成功回调
        NSLog(@"OKOKshjashjasj");
              if (completion) {
                  completion(responseObject, nil);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              // 失败回调
        NSLog(@"NONONO");
        if(error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    
                    NSLog(@"服务器返回错误码: %ld，错误信息: %@", (long)errorModel.code, errorModel.msg);
                }
            } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {
                // server throw exception
                NSLog(@"服务器抛出异常，请稍后重试");
            } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
                // network error
                NSLog(@"网络连接错误，请检查网络设置");
            } else {
                // 其他未知错误
                NSLog(@"发生未知错误: %@", error.localizedDescription);
            }
        } else {
            NSLog(@"上传成功");
        }
              if (completion) {
                  completion(nil, error);
              }
       
          }];
    
}

@end
