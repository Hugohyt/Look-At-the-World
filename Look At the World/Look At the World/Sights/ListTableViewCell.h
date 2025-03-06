//
//  ListTableViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListTableViewCell : UITableViewCell

@property (strong, nonatomic, readwrite)UIImageView *sightsImageView;
@property (strong, nonatomic, readwrite)UILabel *sightsNameLabel;
@property (strong, nonatomic, readwrite)UILabel *sightsProductionLabel;
@property (strong, nonatomic, readwrite)UILabel *sightsLocationLabel;

@end

NS_ASSUME_NONNULL_END
