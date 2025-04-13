//
//  AudioBooksListCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/4.
//

#import "AudioBooksListCell.h"

@implementation AudioBooksListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.coverIamge = [[UIImageView alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.authorLabel = [[UILabel alloc] init];
    self.playCount = [[UILabel alloc] init];
    self.playImage = [[UIImageView alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.authorLabel.textAlignment = NSTextAlignmentLeft;
    self.playCount.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.coverIamge];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.playCount];
    [self.contentView addSubview:self.playImage];
    [self.coverIamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).multipliedBy(0.05);
        make.top.offset(20);
        make.width.and.height.equalTo(self.contentView.mas_width).multipliedBy(0.2);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverIamge.mas_right).offset(10);
        make.top.offset(20);
        make.right.equalTo(self.contentView.mas_right).multipliedBy(0.9);
    }];
    
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverIamge.mas_right).offset(10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).multipliedBy(0.9);
    }];
//    
//    [self.playImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.coverIamge.mas_right).offset(10);
//        make.top.equalTo(self.authorLabel.mas_bottom).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//        make.width.equalTo(self.playImage.mas_width);
//    }];
    
    [self.playCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverIamge.mas_right).offset(10);
        make.top.equalTo(self.authorLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).multipliedBy(0.9);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
    self.playImage.image = [UIImage imageNamed:@"playConut.png"];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    self.authorLabel.font = [UIFont systemFontOfSize:14];
    self.authorLabel.textColor = [UIColor darkGrayColor];
    self.playCount.font = [UIFont systemFontOfSize:12];
    return self;
}



@end
