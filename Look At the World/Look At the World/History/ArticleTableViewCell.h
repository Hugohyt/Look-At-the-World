//
//  ArticleTableViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleTableViewCell : UITableViewCell

@property (strong, nonatomic, readwrite)UILabel* titleLabel;
@property (strong, nonatomic, readwrite)UILabel* articleLabel;
@property (strong, nonatomic, readwrite)UILabel* timeLabel;

@end

NS_ASSUME_NONNULL_END
