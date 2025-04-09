//
//  AudioBooksButton.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/15.
//

#import "AudioBooksButton.h"


@implementation AudioBooksButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews {
    // 创建图片视图
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.myImageView];
        
    // 创建主标题标签
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.mainLabel.font = [UIFont systemFontOfSize:16];
    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.mainLabel];
        
    // 创建副标题标签
    self.subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subLabel.font = [UIFont systemFontOfSize:12];
    self.subLabel.textAlignment = NSTextAlignmentCenter;
    self.subLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.subLabel];
}

- (void)setImage:(UIImageView *)btnImage mainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle {
    self.myImageView.image = btnImage.image;
    self.mainLabel.text = mainTitle;
    self.subLabel.text = subTitle;
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    CGFloat imageViewHeight = self.bounds.size.height * 0.7;
    self.myImageView.frame = CGRectMake(10, 0, 84, imageViewHeight);
    
    CGFloat labelHeight = (self.bounds.size.height - imageViewHeight) / 3;
    self.mainLabel.frame = CGRectMake(0, imageViewHeight, self.bounds.size.width, labelHeight);
    self.subLabel.frame = CGRectMake(0, imageViewHeight + labelHeight, self.bounds.size.width, labelHeight * 2);
}

@end
