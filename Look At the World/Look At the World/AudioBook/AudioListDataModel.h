//
//  AudioListDataModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioListDataModel : NSObject
@property (nonatomic, assign) NSString* bid;
@property (nonatomic, assign) NSString* view;
@property (nonatomic, assign) NSString* author;
@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, assign) NSInteger chapternum;
@property (nonatomic, assign) NSNumber* rating;
@property (nonatomic, assign) NSString* description1;
@property (nonatomic, assign) NSString* created_at;
@property (nonatomic, assign) NSString* updated_at;

@end

NS_ASSUME_NONNULL_END
