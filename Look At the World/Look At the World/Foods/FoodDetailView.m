//
//  FoodDetailView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/31.
//

#import "FoodDetailView.h"

@implementation FoodDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
        [self SettingWidget];
        [self SettingImageScrollView];
    }
    return self;
}

-(void) SettingWidget {
    self.imageScrollView = [[UIScrollView alloc] init];
    self.name = [[UILabel alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.placeLabel = [[UILabel alloc] init];
    self.place = [[UILabel alloc] init];
    self.details = [[UILabel alloc] init];
    self.detailsLabel = [[UILabel alloc] init];
    self.cookBook = [[UILabel alloc] init];
    self.cookBookLabel = [[UILabel alloc] init];
    
    [self.scrollView addSubview:self.imageScrollView];
    [self.scrollView addSubview:self.name];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.place];
    [self.scrollView addSubview:self.placeLabel];
    [self.scrollView addSubview:self.detailsLabel];
    [self.scrollView addSubview:self.details];
    [self.scrollView addSubview:self.cookBook];
    [self.scrollView addSubview:self.cookBookLabel];
    
    self.imageScrollView.bounces = NO;
    self.detailsLabel.numberOfLines = 0;
    self.cookBookLabel.numberOfLines = 0;
    self.detailsLabel.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:22];
    self.cookBookLabel.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:22];
    self.detailsLabel.textColor = [UIColor darkGrayColor];
    self.cookBookLabel.textColor = [UIColor darkGrayColor];
    
    self.name.text = @"名称:";
    self.place.text = @"地点:";
    self.details.text = @"介绍:";
    self.cookBook.text = @"制作步骤:";
    self.name.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:28];
    self.place.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:28];
    self.details.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:28];
    self.cookBook.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:28];
    self.nameLabel.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:28];
    self.placeLabel.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:28];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.placeLabel.textAlignment = NSTextAlignmentLeft;
    
    CGFloat leftLocation = [UIScreen mainScreen].bounds.size.width * 0.15 / 2;
    // 基于屏幕中心适配的布局
    [self.imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.equalTo(self);
        make.top.offset(0);
        make.height.equalTo(self.mas_width).multipliedBy(260.0/333.0);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(leftLocation);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.imageScrollView.mas_bottom).offset(30);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.name.mas_top);
    }];

    [self.place mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(leftLocation);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.name.mas_bottom).offset(5);
    }];

    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.place.mas_right).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.place.mas_top);
    }];

    [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(leftLocation);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.place.mas_bottom).offset(10);
    }];

    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self.scrollView).multipliedBy(0.85);
        make.top.equalTo(self.details.mas_bottom).offset(20);
    }];

    [self.cookBook mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(leftLocation);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.detailsLabel.mas_bottom).offset(20);
    }];

    [self.cookBookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self.scrollView).multipliedBy(0.85);
        make.top.equalTo(self.cookBook.mas_bottom).offset(20);
    }];
}

-(void) SettingImageScrollView {
    self.imageScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, self.imageScrollView.frame.size.height);
    self.imageScrollView.pagingEnabled = YES;
}

@end
