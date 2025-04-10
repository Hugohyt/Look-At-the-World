//
//  VideoSubModel.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoSubModel : NSObject

@property(strong, nonatomic, readwrite)NSString* aid;
@property(strong, nonatomic, readwrite)NSString* uid;
@property(strong, nonatomic, readwrite)NSString* title;
@property(strong, nonatomic, readwrite)NSString* avatar;
@property(strong, nonatomic, readwrite)NSString* name;
@property(strong, nonatomic, readwrite)NSArray* view;
@property(strong, nonatomic, readwrite)NSString* content;
@property(assign, nonatomic, readwrite)int likes;
@property(assign, nonatomic, readwrite)int comments;
@property(assign, nonatomic, readwrite)int favorite;
@property(strong, nonatomic, readwrite)NSString* created_at;
@property(strong, nonatomic, readwrite)NSString* updated_at;
@property(assign, nonatomic, readwrite)BOOL video;
@property(strong, nonatomic, readwrite)NSString* videoid;

@end

NS_ASSUME_NONNULL_END
