//
//  ReplyTableViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReplyTableViewCell : UITableViewCell

@property UIImageView* nameIcon;
@property UILabel* nameLabel;
@property UIButton* likeButton;
@property UILabel* likes;
@property UILabel* timeLabel;
@property UITextView* commentTextView;

@end

NS_ASSUME_NONNULL_END
