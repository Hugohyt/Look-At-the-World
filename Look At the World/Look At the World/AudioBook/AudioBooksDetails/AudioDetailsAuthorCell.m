//
//  AudioDetailsAuthorCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/25.
//

#import "AudioDetailsAuthorCell.h"

@implementation AudioDetailsAuthorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.bookImage = [[UIImageView alloc] init];
    self.bookName = [[UILabel alloc] init];
    self.authorName = [[UILabel alloc] init];
    self.scoreLabel = [[UILabel alloc] init];
    self.numberLabel = [[UILabel alloc] init];
    self.chaoterLabel = [[UILabel alloc] init];
    self.renewLabel = [[UILabel alloc] init];
    self.scoreSubLabel = [[UILabel alloc] init];
    self.numberSubLabel = [[UILabel alloc] init];
    self.chaoterSubLabel = [[UILabel alloc] init];
    self.renewSubLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.bookImage];
    [self.contentView addSubview:self.bookName];
    [self.contentView addSubview:self.authorName];
    [self.contentView addSubview:self.scoreLabel];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.chaoterLabel];
    [self.contentView addSubview:self.renewLabel];
    [self.contentView addSubview:self.scoreSubLabel];
    [self.contentView addSubview:self.numberSubLabel];
    [self.contentView addSubview:self.chaoterSubLabel];
    [self.contentView addSubview:self.renewSubLabel];
    
    self.scoreLabel.numberOfLines = 1;
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.font = [UIFont systemFontOfSize:18];
    self.scoreSubLabel.numberOfLines = 1;
    self.scoreSubLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreSubLabel.font = [UIFont systemFontOfSize:12];
    self.scoreSubLabel.textColor = [UIColor grayColor];
    
    self.numberLabel.numberOfLines = 1;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = [UIFont systemFontOfSize:18];
    self.numberSubLabel.numberOfLines = 1;
    self.numberSubLabel.textAlignment = NSTextAlignmentCenter;
    self.numberSubLabel.font = [UIFont systemFontOfSize:12];
    self.numberSubLabel.textColor = [UIColor grayColor];
    
    self.chaoterLabel.numberOfLines = 1;
    self.chaoterLabel.textAlignment = NSTextAlignmentCenter;
    self.chaoterLabel.font = [UIFont systemFontOfSize:18];
    self.chaoterSubLabel.numberOfLines = 1;
    self.chaoterSubLabel.textAlignment = NSTextAlignmentCenter;
    self.chaoterSubLabel.font = [UIFont systemFontOfSize:12];
    self.chaoterSubLabel.textColor = [UIColor grayColor];
    
    self.renewLabel.numberOfLines = 1;
    self.renewLabel.textAlignment = NSTextAlignmentCenter;
    self.renewLabel.font = [UIFont systemFontOfSize:18];
    self.renewSubLabel.numberOfLines = 1;
    self.renewSubLabel.textAlignment = NSTextAlignmentCenter;
    self.renewSubLabel.font = [UIFont systemFontOfSize:12];
    self.renewSubLabel.textColor = [UIColor grayColor];
    
    self.bookName.numberOfLines = 0;
    
    [self SettingSublabel];
    // 为 self.bookImage 设置约束
    [self.bookImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(100);
    }];

    // 为 self.bookName 设置约束
    [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.bookImage.mas_right).offset(20);
        make.right.lessThanOrEqualTo(self.contentView).offset(-20);
    }];
    self.bookName.font = [UIFont systemFontOfSize:24];

    // 为 self.authorName 设置约束
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookName.mas_bottom).offset(20);
        make.left.equalTo(self.bookImage.mas_right).offset(20);
        make.right.lessThanOrEqualTo(self.contentView).offset(-20);
        make.height.equalTo(@50);
    }];

    // 为 self.scoreLabel 设置约束
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookImage.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.height.equalTo(@40);
    }];

    // 为 self.scoreSubLabel 设置约束
    [self.scoreSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];

    // 为 self.numberLabel 设置约束
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookImage.mas_bottom).offset(10);
        make.left.equalTo(self.scoreLabel.mas_right).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.height.equalTo(@40);
    }];

    // 为 self.numberSubLabel 设置约束
    [self.numberSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_bottom).offset(10);
        make.left.equalTo(self.scoreLabel.mas_right).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];

    // 为 self.chaoterLabel 设置约束
    [self.chaoterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookImage.mas_bottom).offset(10);
        make.left.equalTo(self.numberLabel.mas_right).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.height.equalTo(@40);
    }];

    // 为 self.chaoterSubLabel 设置约束
    [self.chaoterSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chaoterLabel.mas_bottom).offset(10);
        make.left.equalTo(self.numberLabel.mas_right).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];

    // 为 self.renewLabel 设置约束
    [self.renewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookImage.mas_bottom).offset(10);
        make.left.equalTo(self.chaoterLabel.mas_right).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.height.equalTo(@40);
    }];

    // 为 self.renewSubLabel 设置约束
    [self.renewSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.renewLabel.mas_bottom).offset(10);
        make.left.equalTo(self.chaoterLabel.mas_right).offset(10);
        make.width.greaterThanOrEqualTo(@80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    return self;
}


-(void) SettingSublabel {
    self.scoreSubLabel.text = @"评分";
    self.numberSubLabel.text = @"在听人数";
    self.chaoterSubLabel.text = @"章节数";
    self.renewSubLabel.text = @"更新状态";
    
}

@end
