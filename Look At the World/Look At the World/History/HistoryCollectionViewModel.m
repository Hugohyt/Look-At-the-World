//
//  HistoryCollectionViewModel.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/30.
//

#import "HistoryCollectionViewModel.h"
#import "ArticleModel.h"

@implementation HistoryCollectionViewModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[ArticleModel class]};
}

@end
