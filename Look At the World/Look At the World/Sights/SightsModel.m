//
//  SightsModel.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "SightsModel.h"
#import "SightsSubModel.h"

@implementation SightsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[SightsSubModel class]};
}

@end
