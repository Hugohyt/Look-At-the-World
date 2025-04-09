//
//  StarModel.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface StarModel : NSObject

@property (strong, nonatomic)NSString* name;
@property (strong, nonatomic)UIImage* image;

- (instancetype)initWithData:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
