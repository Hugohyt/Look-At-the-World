//
//  HistoryCollectionViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import "HistoryCollectionViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@implementation HistoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.historyImageView = [[UIImageView alloc] init];
    self.avatarImageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.likesCountLabel = [[UILabel alloc] init];
    self.likesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nameLabel = [[UILabel alloc] init];
    
    [self.likesButton setImage:[UIImage imageNamed:@"点赞.jpg"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.historyImageView];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.likesCountLabel];
    [self.contentView addSubview:self.likesButton];
    [self.contentView addSubview:self.nameLabel];
    
//    self.historyImageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 80);
//    self.titleLabel.frame = CGRectMake(10, self.historyImageView.frame.size.height + 5, self.contentView.frame.size.width - 20, 40);
//    self.avatarImageView.frame = CGRectMake(10, self.historyImageView.frame.size.height + 50, 20, 20);
//    self.likesButton.frame = CGRectMake(self.contentView.frame.size.width - 70, self.historyImageView.frame.size.height + 50, 20, 20);
//    self.likesCountLabel.frame = CGRectMake(self.contentView.frame.size.width - 50, self.historyImageView.frame.size.height + 50, 40, 20);
//    self.nameLabel.frame = CGRectMake(35, self.historyImageView.frame.size.height + 50, 70, 20);

    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor colorWithRed:184/255.0 green:154/255.0 blue:116/255.0 alpha:1.0];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.likesCountLabel.font = [UIFont systemFontOfSize:12];
    self.likesCountLabel.textColor = [UIColor lightGrayColor];
    
    self.avatarImageView.layer.cornerRadius = 10;
    self.avatarImageView.layer.masksToBounds = YES;
    
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = YES;
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.historyImageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 80);
    self.titleLabel.frame = CGRectMake(10, self.historyImageView.frame.size.height + 5, self.contentView.frame.size.width - 20, 40);
    self.avatarImageView.frame = CGRectMake(10, self.historyImageView.frame.size.height + 50, 20, 20);
    self.likesButton.frame = CGRectMake(self.contentView.frame.size.width - 70, self.historyImageView.frame.size.height + 50, 20, 20);
    self.likesCountLabel.frame = CGRectMake(self.contentView.frame.size.width - 50, self.historyImageView.frame.size.height + 50, 40, 20);
    self.nameLabel.frame = CGRectMake(35, self.historyImageView.frame.size.height + 50, 70, 20);
}

@end
