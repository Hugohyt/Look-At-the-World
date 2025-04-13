//
//  StarModel.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import "StarModel.h"

@implementation StarModel

- (instancetype)initWithData:(NSDictionary*)dictionary {
    self = [super init];
    self.name = dictionary[@"name"]?:nil;
    self.image = dictionary[@"image"]?:nil;
    return self;
}

@end
