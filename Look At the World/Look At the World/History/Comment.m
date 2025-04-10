//
//  Comment.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/8.
//

#import "Comment.h"

@implementation Comment

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _cid = dict[@"cid"] ?: @"";
        _target = dict[@"target"] ?: @"";
        _content = dict[@"content"] ?: @"";
        _likes = [dict[@"likes"] integerValue];
        _uid = dict[@"uid"] ?: @"";
        _name = dict[@"name"] ?: @"";
        _avatar = dict[@"avatar"] ?: @"";
        _replycid = dict[@"replycid"] ?: @"";
        _replyname = dict[@"replyname"] ?: @"";
        _time = dict[@"time"] ?: @"";
        
        // 日期转换
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
        _createdAt = [formatter dateFromString:dict[@"created_at"]];
        _updatedAt = [formatter dateFromString:dict[@"updated_at"]];
        
        _replies = [NSMutableArray array];
        
        self.isExpand = NO;
    }
    return self;
}

@end
