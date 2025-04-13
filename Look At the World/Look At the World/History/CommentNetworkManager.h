//
//  CommentNetworkManager.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/8.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN


// CommentNetworkManager.h
@interface CommentNetworkManager : NSObject

@property (strong, nonatomic)NSMutableArray* commentArray;

+ (instancetype)sharedManager;

// 获取文章所有一级评论
- (void)fetchTopLevelCommentsForTarget:(NSString *)targetId
                           completion:(void(^)(NSArray<Comment *> *comments, NSError *error))completion;

// 获取评论的所有二级评论
- (void)fetchAllRepliesForComment:(NSString *)commentId
                      completion:(void(^)(NSArray<Comment *> *replies, NSError *error))completion;

// 获取文章一级评论和下属两条二级评论
- (void)fetchTopLevelCommentsWithPreviewRepliesForTarget:(NSString *)targetId
                                             completion:(void(^)(NSArray<Comment *> *comments, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
