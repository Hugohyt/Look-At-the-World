//
//  AudioDetailsSubListCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/25.
//

#import "AudioDetailsSubListCell.h"

@implementation AudioDetailsSubListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.numberLabel = [[UILabel alloc] init];
    self.title = [[UILabel alloc] init];
    self.downloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playTime = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.downloadBtn];
    [self.contentView addSubview:self.playTime];
    //设置控件的一些简单属性
    self.numberLabel.font = [UIFont systemFontOfSize:32];
    self.title.numberOfLines = 2;
    self.title.font = [UIFont systemFontOfSize:18];
    self.playTime.textColor = [UIColor grayColor];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(15);
        make.width.and.height.offset(40);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_top);
        make.left.equalTo(self.numberLabel.mas_right).offset(20);
        make.height.offset(30);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.6);
    }];
    
    [self.playTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(self.numberLabel.mas_right).offset(20);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.6);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    return self;
}

@end
