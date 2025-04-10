//
//  SubNewCommentModel.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubNewCommentModel : NSObject

@property (strong, nonatomic, readwrite)NSString* cid;
@property (strong, nonatomic, readwrite)NSString* targer;
@property (strong, nonatomic, readwrite)NSString* content;
@property (assign, nonatomic, readwrite)int likes;
@property (strong, nonatomic, readwrite)NSString* name;
@property (strong, nonatomic, readwrite)NSString* avatar;
@property (strong, nonatomic, readwrite)NSString* replyname;
@property (strong, nonatomic, readwrite)NSString* replycid;
@property (strong, nonatomic, readwrite)NSString* time;
@property (strong, nonatomic, readwrite)NSString* created_at;
@property (strong, nonatomic, readwrite)NSString* updated_at;

@end

NS_ASSUME_NONNULL_END
