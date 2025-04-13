//
//  CodeModel.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import "CodeModel.h"

@implementation CodeModel

+ (NSDictionary*)modelContainerPropertyGenericClass {
    return @{@"data":[CodeSubModel class]};
}
@end
