//
//  CommentNetworkManager.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/8.
//

#import "CommentNetworkManager.h"
#import "AFNetworking/AFNetworking.h"
#import "CommentModel.h"
#import "YYModel/YYModel.h"

// CommentNetworkManager.m
@implementation CommentNetworkManager

+ (instancetype)sharedManager {
    static CommentNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)fetchTopLevelCommentsForTarget:(NSString *)targetId
                           completion:(void(^)(NSArray<Comment *> *comments, NSError *error))completion {
    NSString* urlString = @"https://travel.knoci.cn/comments/list";
    [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"aid":targetId} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CommentModel* commentModel = [CommentModel yy_modelWithJSON:responseObject];
        NSDictionary* dicitionary = [commentModel yy_modelToJSONObject];
        NSLog(@"评论:%@", dicitionary);
        NSMutableArray *comments = [NSMutableArray array];
        for (NSDictionary *dict in dicitionary[@"data"]) {
            Comment *comment = [[Comment alloc] initWithDictionary:dict];
            [comments addObject:comment];
        }
            completion(comments, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

- (void)fetchAllRepliesForComment:(NSString *)commentId
                      completion:(void(^)(NSArray<Comment *> *replies, NSError *error))completion {
    NSString* urlString = @"https://travel.knoci.cn/comments/findreply";
    [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"cid":commentId} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CommentModel* commentModel = [CommentModel yy_modelWithJSON:responseObject];
        NSDictionary* dicitionary = [commentModel yy_modelToJSONObject];
        NSLog(@"评论:%@", dicitionary);
        NSMutableArray *replys = [NSMutableArray array];
        for (NSDictionary *dict in dicitionary[@"data"]) {
            Comment *comment = [[Comment alloc] initWithDictionary:dict];
            [replys addObject:comment];
        }
            completion(replys, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

- (void)fetchTopLevelCommentsWithPreviewRepliesForTarget:(NSString *)targetId
                                             completion:(void(^)(NSArray<Comment *> *comments, NSError *error))completion {
    NSString* urlString = @"https://travel.knoci.cn/comments/listwith";
    [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"aid":targetId} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CommentModel* commentModel = [CommentModel yy_modelWithJSON:responseObject];
        NSDictionary* dicitionary = [commentModel yy_modelToJSONObject];
        NSMutableArray *comments = [NSMutableArray array];
        for (NSDictionary *dict in dicitionary[@"data"]) {
            Comment *comment = [[Comment alloc] initWithDictionary:dict];
            if (comment.replycid.length == 0) {
                [comments addObject:comment];
            } else {
                [comments enumerateObjectsUsingBlock:^(Comment*  _Nonnull topComment, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([topComment.cid isEqualToString:comment.replycid]) {
                        [topComment.replies addObject:comment];
                    }
                }];
            }
        }
            completion(comments, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

@end
