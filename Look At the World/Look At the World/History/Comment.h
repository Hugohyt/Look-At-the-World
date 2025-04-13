//
//  Comment.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comment : NSObject

@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *replycid;  // 回复的评论ID，空字符串表示一级评论
@property (nonatomic, strong) NSString *replyname;  // 回复的用户名
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;
@property (assign, nonatomic)BOOL isExpand;

// 子评论数组
@property (nonatomic, strong) NSMutableArray<Comment *> *replies;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
