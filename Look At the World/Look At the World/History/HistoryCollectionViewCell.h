//
//  HistoryCollectionViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic, readwrite)UIImageView* historyImageView;
@property (strong, nonatomic, readwrite)UIImageView* avatarImageView;
@property (strong, nonatomic, readwrite)UIButton* likesButton;
@property (strong, nonatomic, readwrite)UILabel* titleLabel;
@property (strong, nonatomic, readwrite)UILabel* likesCountLabel;
@property (strong, nonatomic, readwrite)UILabel* nameLabel;
@end

NS_ASSUME_NONNULL_END
