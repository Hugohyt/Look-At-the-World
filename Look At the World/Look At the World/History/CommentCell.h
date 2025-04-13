//
//  CommentCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell <UITextViewDelegate>

@property UIImageView* nameIcon;
@property UILabel* nameLabel;
@property UIButton* likeButton;
@property UILabel* likes;
@property UILabel* timeLabel;
@property UITextView* commentTextView;

//- (void)setupCellShortCommentsDate:(CommentModel*)model;

@end

NS_ASSUME_NONNULL_END
