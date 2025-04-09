//
//  AudioDetailsProfileCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/25.
//

#import "AudioDetailsProfileCell.h"

@implementation AudioDetailsProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.profileLabel = [[UILabel alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:24];
    self.profileLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.profileLabel];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameLabel.frame = CGRectMake(15, 10, 100, 30);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    [self.profileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        make.left.mas_offset(15);
        make.width.mas_offset(360);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    self.profileLabel.numberOfLines = 0;
    
    self.nameLabel.text = @"简介";
    self.profileLabel.font = [UIFont systemFontOfSize:18];
    return self;
}
@end
