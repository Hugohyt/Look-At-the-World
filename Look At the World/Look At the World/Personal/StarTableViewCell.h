//
//  StarTableViewCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import <UIKit/UIKit.h>
#import "StarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StarTableViewCell : UITableViewCell

@property (strong, nonatomic)UIImageView *iconImageView;
@property (strong, nonatomic)UILabel *nameLabel;

-(void)configureWithModel:(StarModel*)model;

@end

NS_ASSUME_NONNULL_END
