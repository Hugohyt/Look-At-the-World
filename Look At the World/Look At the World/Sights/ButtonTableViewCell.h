//
//  ButtonTableViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ButtonTableViewCell : UITableViewCell

@property (strong, nonatomic, readwrite)NSMutableArray<UIButton *> *buttons;

@end

NS_ASSUME_NONNULL_END
