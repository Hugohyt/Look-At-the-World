//
//  LoginViewModel.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()
@end

@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if(self) {
        [self addObserver:self forKeyPath:@"emailInputText" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"passwordInputText" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
#pragma mark - Post请求
//发送验证码
- (void)Email:(NSString*) email CodeWithSuccess:(DataBlock) dataBlock
                failure:(ErrorBlock) errorBlock {
    NSDictionary* parameters = @{@"email":email};
    NSLog(@"parameters:%@",parameters);
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString* urlString = @"https://travel.knoci.cn/user/register/verify";
    // 构建完整的 URL，将参数拼接在 URL 后面
    NSMutableString *urlWithParams = [NSMutableString stringWithString:urlString];
    [urlWithParams appendString:@"?"];
    NSArray *keys = [parameters allKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *value = parameters[key];
        [urlWithParams appendFormat:@"%@=%@", key, value];
        if (i < keys.count - 1) {
            [urlWithParams appendString:@"&"];
        }
    }
    NSLog(@"urlString=%@", urlString);
    //开始POST请求
    [manager POST:urlWithParams parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"yanzhengma:%@", responseObject);
            CodeModel* codeModel = [CodeModel yy_modelWithJSON:responseObject];
            dataBlock(codeModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
    }];
}

- (void)PostUrlString:(NSString*) urlString parameters:(NSDictionary*) parameters completion:(NetworkCompletionHandler)completion {
    id manager = [ManagerPost sharedManager];
    NSLog(@"%@", urlString);
    [manager sendPostRequestWithURL:urlString parameters:parameters completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
            if(error) {
                completion(nil, error);
            } else {
                NSLog(@"yanzhengma:%@", responseObject);
                completion(responseObject, nil);
            }
    }];
}
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"emailInputText"]) {
        NSString *newText = change[NSKeyValueChangeNewKey];
        NSLog(@"开始判断");
        NSString *pattern = @"@[a-zA-Z0-9]{2,3}\\.com$";
        NSError *error = nil;
        // 创建正则表达式对象
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        if (error) {
            NSLog(@"正则表达式创建失败: %@", error.localizedDescription);
        }
        // 在字符串中查找匹配项
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newText options:0 range:NSMakeRange(0, newText.length)];
        self.internalIsQQEmail = numberOfMatches > 0 ? 1 : 0;
    } else if ([keyPath isEqualToString:@"passwordInputText"]) {
        NSString* password = change[NSKeyValueChangeNewKey];
        NSInteger passLong = password.length;
        if(passLong >= 6 && passLong <=20) {
            self.internalIsQQpassword = YES;
        } else {
            self.internalIsQQpassword = NO;
        }
    }
}

- (void)dealloc {
    // 移除 KVO 监听，防止内存泄漏
    [self removeObserver:self forKeyPath:@"emailInputText"];
    [self removeObserver:self forKeyPath:@"passwordInputText"];  
}
@end
