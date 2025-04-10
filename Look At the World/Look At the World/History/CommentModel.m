//
//  CommentModel.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/7.
//

#import "CommentModel.h"
#import "SubCommentModel.h"

@implementation CommentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[SubCommentModel class]};
}

@end
