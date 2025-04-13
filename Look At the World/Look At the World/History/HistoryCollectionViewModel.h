//
//  HistoryCollectionViewModel.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/30.
//

#import <Foundation/Foundation.h>
#import "YYModel/YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCollectionViewModel : NSObject <YYModel>

@property(strong, nonatomic, readwrite) NSString* code;
@property(strong, nonatomic, readwrite) NSArray* data;
@property(strong, nonatomic, readwrite) NSString* msg;

@end

NS_ASSUME_NONNULL_END
