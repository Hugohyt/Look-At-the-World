//
//  ReplyTableViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/8.
//

#import "ReplyTableViewCell.h"
#import "Masonry/Masonry.h"

@implementation ReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.commentTextView = [[UITextView alloc] init];
    [self.commentTextView setFont:[UIFont systemFontOfSize:17]];
    self.commentTextView.textColor = [UIColor darkGrayColor];
//    self.commentTextView.delegate = self;
    self.commentTextView.scrollEnabled = NO;
    self.commentTextView.selectable = NO;
//    self.replyTextView.selectable = NO;
    self.commentTextView.editable = NO;
    [self.contentView addSubview:self.commentTextView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.nameIcon];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel setFont:[UIFont systemFontOfSize:16]];
    [self.timeLabel setTextColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.timeLabel];
    
//    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.contentView addSubview:self.likeButton];
//    [self.likeButton setImage:[UIImage imageNamed:@"评论点赞.jpg"] forState:UIControlStateNormal];
//    self.likeButton.tag = 101;
//    [self.likeButton addTarget:self action:@selector(likes:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.likes = [[UILabel alloc] init];
//    [self.contentView addSubview:self.likes];
    
    [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameIcon).offset(30);
        make.left.mas_equalTo(138);
        make.width.mas_equalTo(300);
    }];
    [self.nameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(80);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    self.nameIcon.layer.cornerRadius = 20;
    self.nameIcon.layer.masksToBounds = YES;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(140);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentTextView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(140);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-20);
    }];
//    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.commentTextView.mas_bottom).mas_offset(20);
//        make.left.mas_equalTo(300);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(20);
//    }];
//    [self.likes mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.commentTextView.mas_bottom).mas_offset(20);
//        make.left.mas_equalTo(280);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(20);
//    }];
    
    return self;
}


@end
