//
//  MyTextField.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import "MyTextField.h"

@implementation MyTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetupAppearance];
    }
    return self;
}

-(void) SetupAppearance {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 17.5;
    
    // 添加细灰边
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    // 模拟镶嵌效果：添加阴影
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 2;
//    self.layer.masksToBounds = NO;
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    UIImageView* leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultImage"]];
    [leftView addSubview:leftImage];
    leftImage.frame = CGRectMake(15, 2, 32, 32);
    leftImage.tag = 101;
    
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(55, 3, 1, 29)];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [leftView addSubview:verticalLine];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.leftView) {
        CGRect leftViewFrame = self.leftView.frame;
        leftViewFrame.origin.x = 0;
        self.leftView.frame = leftViewFrame;
    }
}

- (void)updateLeftViewImage:(UIImage *)image {
    // 通过 tag 查找图片视图
    UIImageView *imageView = (UIImageView *)[self.leftView viewWithTag:101];
    if (imageView) {
        imageView.image = image;
    }
}


@end

