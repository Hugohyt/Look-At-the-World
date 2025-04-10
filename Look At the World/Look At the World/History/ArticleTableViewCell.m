//
//  ArticleTableViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/25.
//

#import "ArticleTableViewCell.h"
#import "Masonry/Masonry.h"

@implementation ArticleTableViewCell

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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.titleLabel setTextColor:[UIColor colorWithRed:50/255 green:50/255 blue:50/255 alpha:1.0]];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).inset(10);
        make.leading.trailing.equalTo(self.contentView).inset(10);
    }];
    
    self.articleLabel = [[UILabel alloc] init];
    self.articleLabel.font = [UIFont systemFontOfSize:16];
    [self.articleLabel setTextColor:[UIColor colorWithRed:54/255 green:54/255 blue:54/255 alpha:1.0]];
    self.articleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.articleLabel];
    [self.articleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).inset(10);
        make.leading.trailing.equalTo(self.contentView).inset(10);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.timeLabel setTextColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.articleLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).inset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
    }];
    return self;
}

@end
