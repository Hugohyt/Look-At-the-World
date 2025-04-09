//
//  IrregularButtonCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/17.
//

#import "IrregularButtonCell.h"

@implementation IrregularButtonCell

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
    self.backgroundColor = [UIColor clearColor];
    //设置不规则按钮
    self.btn1 = [[IrregularButton alloc] initWithFrame:CGRectMake(20, 0, 200, 120)];
    self.btn2 = [[IrregularButton alloc] initWithFrame:CGRectMake(190, 0, 183, 55)];
    self.btn3 = [[IrregularButton alloc] initWithFrame:CGRectMake(210, 65, 163, 55)];
    NSArray<NSValue*> * point1 = @[
        [NSValue valueWithCGPoint:CGPointMake(0, 0)],
        [NSValue valueWithCGPoint:CGPointMake(160, 0)],
        [NSValue valueWithCGPoint:CGPointMake(200, 120)],
        [NSValue valueWithCGPoint:CGPointMake(0, 120)]
    ];
    UIColor* myColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];//淡绿色备选
//    [UIColor colorWithRed:244/255.0 green:182/255.0 blue:172/255.0 alpha:1.0];
    [self.btn1 setGradientBackgroundWithColors:@[myColor, [UIColor whiteColor]] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    [self.btn1 setIrregularShapeWithPoints:point1];
    [self.btn1 setTitle:@"走遍中国" forState:UIControlStateNormal];
    [self.btn1 setFont:[UIFont fontWithName:@"Xiangjiaoquwanlingganti" size:32]];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn1.tag = 101;
    [self.contentView addSubview:self.btn1];
    
    NSArray<NSValue*> * point2 = @[
        [NSValue valueWithCGPoint:CGPointMake(0, 0)],
        [NSValue valueWithCGPoint:CGPointMake(183, 0)],
        [NSValue valueWithCGPoint:CGPointMake(183, 55)],
        [NSValue valueWithCGPoint:CGPointMake(20, 55)]
    ];
    // 调整RGB值，增大每个通道的值使其更接近白色
    CGFloat newRed = 204/255.0 + (1.0 - 204/255.0) * 0.5; // 这里将红色通道的值增加到接近白色的程度，可按需调整
    CGFloat newGreen = 153/255.0 + (1.0 - 153/255.0) * 0.5;
    CGFloat newBlue = 255/255.0 + (1.0 - 255/255.0) * 0.5;

    UIColor* myColor2 = [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
    [self.btn2 setGradientBackgroundWithColors:@[myColor2, [UIColor whiteColor]] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    [self.btn2 setIrregularShapeWithPoints:point2];
    [self.btn2 setTitle:@"围炉品城" forState:UIControlStateNormal];
    [self.btn2 setFont:[UIFont fontWithName:@"Xiangjiaoquwanlingganti" size:32]];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn2.tag = 102;
    [self.contentView addSubview:self.btn2];
    
    NSArray<NSValue*> * point3 = @[
        [NSValue valueWithCGPoint:CGPointMake(0, 0)],
        [NSValue valueWithCGPoint:CGPointMake(163, 0)],
        [NSValue valueWithCGPoint:CGPointMake(163, 55)],
        [NSValue valueWithCGPoint:CGPointMake(20, 55)]
    ];
    UIColor* myColor3 = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [self.btn3 setGradientBackgroundWithColors:@[myColor3, [UIColor whiteColor]] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    [self.btn3 setIrregularShapeWithPoints:point3];
    [self.btn3 setTitle:@"生活美学" forState:UIControlStateNormal];
    [self.btn3 setFont:[UIFont fontWithName:@"Xiangjiaoquwanlingganti" size:32]];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn3.tag = 103;
    [self.contentView addSubview:self.btn3];
    
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.cornerRadius = 10.0;
    self.btn2.layer.masksToBounds = YES;
    self.btn2.layer.cornerRadius = 10.0;
    self.btn3.layer.masksToBounds = YES;
    self.btn3.layer.cornerRadius = 10.0;
    
    return self;
}

@end
