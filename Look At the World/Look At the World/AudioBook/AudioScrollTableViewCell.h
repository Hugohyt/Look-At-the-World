//
//  AudioScrollTableViewCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioScrollTableViewCell : UITableViewCell <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView* audioScrollView;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) NSMutableArray* arrTopImage;
@end

NS_ASSUME_NONNULL_END
