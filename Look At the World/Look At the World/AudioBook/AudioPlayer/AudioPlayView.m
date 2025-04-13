//
//  AudioPlayView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/18.
//

#import "AudioPlayView.h"

@implementation AudioPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1.0];
        [self BuildView];
    }
    return self;
}

-(void) BuildView {
    self.coverImage = [[UIImageView alloc] init];
    self.downloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.multipleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.goodBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.slider = [[UIProgressView alloc] init];
    self.priorBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.totalTimeLabel = [[UILabel alloc] init];
    self.currentTimeLabel = [[UILabel alloc] init];
    self.authorLabel = [[UILabel alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:22];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleScrollView = [[UIScrollView alloc] init];
    
    [self addSubview:self.authorLabel];
    [self addSubview:self.titleScrollView];
    [self addSubview:self.coverImage];
    [self addSubview:self.downloadBtn];
    [self addSubview:self.multipleBtn];
    [self addSubview:self.goodBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.slider];
    [self addSubview:self.priorBtn];
    [self addSubview:self.playBtn];
    [self addSubview:self.nextBtn];
    [self addSubview:self.currentTimeLabel];
    [self addSubview:self.totalTimeLabel];
    
    [self layoutView];
    
    self.titleScrollView.showsHorizontalScrollIndicator = YES;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    
    self.currentTimeLabel.font = [UIFont systemFontOfSize:8];
    self.totalTimeLabel.font = [UIFont systemFontOfSize:8];
    
    UIImage *originalImage = [UIImage imageNamed:@"下载.png"];
    UIImage *imageWithOriginalRenderingMode = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.downloadBtn setImage:imageWithOriginalRenderingMode forState:UIControlStateNormal];
    [self.multipleBtn setImage:[[UIImage imageNamed:@"倍速.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.goodBtn setImage:[[UIImage imageNamed:@"点赞.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.commentBtn setImage:[[UIImage imageNamed:@"评论.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.goodBtn.selected = NO;
    [self.goodBtn setImage:[[UIImage imageNamed:@"点赞_块.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    
    
    [self.priorBtn setImage:[[UIImage imageNamed:@"播放-上一章.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.playBtn setImage:[[UIImage imageNamed:@"播放.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.nextBtn setImage:[[UIImage imageNamed:@"播放-下一章.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.playBtn setImage:[[UIImage imageNamed:@"暂停1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    self.slider.progress = 0;
}

-(void) layoutView {
    
    CGFloat left = (393 - 240)/ 2;
    
    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(180);
        make.left.mas_offset(left);
        make.width.and.height.mas_offset(240);
    }];
    
    // 获取屏幕宽度
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    // 计算总宽度
    CGFloat totalButtonWidth = 60 * 4 + 30 * 3;
    CGFloat totalControlWidth = 60 * 2 + 30 * 2 + 80;

    // 计算起始偏移量
    CGFloat buttonStartX = (screenWidth - totalButtonWidth) / 2;
    CGFloat controlStartX = (screenWidth - totalControlWidth) / 2;

    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(450);
        make.left.mas_offset(buttonStartX);
        make.width.mas_offset(360 - buttonStartX);
        make.height.mas_offset(30);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleScrollView.mas_bottom).mas_offset(20);
        make.left.mas_offset(buttonStartX);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImage.mas_bottom).mas_offset(200);
        make.left.mas_offset(buttonStartX);
        make.width.and.height.mas_offset(60);
    }];

    [self.multipleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImage.mas_bottom).mas_offset(200);
        make.left.mas_equalTo(self.downloadBtn.mas_right).mas_offset(30);
        make.width.and.height.mas_offset(60);
    }];

    [self.goodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImage.mas_bottom).mas_offset(200);
        make.left.mas_equalTo(self.multipleBtn.mas_right).mas_offset(30);
        make.width.and.height.mas_offset(60);
    }];

    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImage.mas_bottom).mas_offset(200);
        make.left.mas_equalTo(self.goodBtn.mas_right).mas_offset(30);
        make.width.and.height.mas_offset(60);
    }];

    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.multipleBtn.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self); // 让滑块居中
        make.width.mas_offset(300);
        make.bottom.mas_equalTo(self.multipleBtn.mas_bottom).mas_offset(45);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(720);
        make.right.mas_equalTo(self.slider.mas_left).mas_offset(-5);
        make.width.mas_offset(30);
        make.height.mas_offset(10);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(720);
        make.left.mas_equalTo(self.slider.mas_right).mas_offset(5);
        make.width.mas_offset(30);
        make.height.mas_offset(10);
    }];

    [self.priorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slider.mas_bottom).mas_offset(20);
        make.left.mas_offset(controlStartX);
        make.width.and.height.mas_offset(60);
    }];

    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slider.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.priorBtn.mas_right).mas_offset(30);
        make.width.and.height.mas_offset(80);
    }];

    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slider.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.playBtn.mas_right).mas_offset(30);
        make.width.and.height.mas_offset(60);
    }];
}


@end
