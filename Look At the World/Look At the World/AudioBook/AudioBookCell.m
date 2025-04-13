//
//  AudioBookCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/9.
//

#import "AudioBookCell.h"

@implementation AudioBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.btn1 = [[AudioBooksButton alloc] init];
    self.btn2 = [[AudioBooksButton alloc] init];
    self.btn3 = [[AudioBooksButton alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.btn1];
    [self.contentView addSubview:self.btn2];
    [self.contentView addSubview:self.btn3];
    [self.contentView addSubview:self.titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.mas_offset(15);
        make.height.mas_offset(25);
        make.width.mas_offset(100);
    }];
    
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(35);
        make.width.mas_offset(104);
        make.height.mas_offset(160);
    }];
    
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn1.mas_right).mas_offset(20);
        make.top.mas_offset(35);
        make.width.mas_offset(104);
        make.height.mas_offset(160);
    }];
    
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn2.mas_right).mas_offset(20);
        make.top.mas_offset(35);
        make.width.mas_offset(104);
        make.height.mas_offset(160);
    }];
    
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    
    return self;
}



@end
