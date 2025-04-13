//
//  FoodDetailModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodDetailModel : NSObject

@property (nonatomic, strong) NSString* fid;
@property (nonatomic, strong) NSArray* view;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* describe;
@property (nonatomic, strong) NSString* article;
@property (nonatomic, strong) NSString* recipe;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* created_at;
@property (nonatomic, strong) NSString* updated_at;

@end

NS_ASSUME_NONNULL_END
