//
//  ScrollTableViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollTableViewCell : UITableViewCell <UIScrollViewDelegate>

@property UIScrollView *sightsScrollView;
@property NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
