//
//  FoodListModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/29.
//

#import <Foundation/Foundation.h>
#import "FoodDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FoodListModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSArray* data;
@property (nonatomic, strong) NSString* msg;

@end

NS_ASSUME_NONNULL_END
