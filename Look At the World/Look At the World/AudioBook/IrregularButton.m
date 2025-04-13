//
//  IrregularButton.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/17.
//

#import "IrregularButton.h"

@implementation IrregularButton

- (void)setIrregularShapeWithPoints:(NSArray<NSValue *> *)points {
    self.shapePoints = points;
    [self setNeedsDisplay];
}

- (void)setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    self.gradientColors = colors;
    self.gradientStartPoint = startPoint;
    self.gradientEndPoint = endPoint;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context != NULL) {
        // 绘制不规则形状
        if (self.shapePoints.count > 0) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            // 移动到第一个点
            [path moveToPoint:[self.shapePoints.firstObject CGPointValue]];
            // 添加线段到其他点
            for (NSInteger i = 1; i < self.shapePoints.count; i++) {
                [path addLineToPoint:[self.shapePoints[i] CGPointValue]];
            }
            // 关闭路径
            [path closePath];
            // 设置填充颜色
            [[UIColor blueColor] setFill];
            // 填充路径
            [path fill];
            // 设置按钮的点击区域为不规则形状
            self.layer.mask = [CAShapeLayer layer];
            ((CAShapeLayer *)self.layer.mask).path = path.CGPath;
        }

        // 绘制渐变背景
        if (self.gradientColors.count > 0) {
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.frame = self.bounds;
            NSMutableArray *cgColors = [NSMutableArray array];
            for (UIColor *color in self.gradientColors) {
                [cgColors addObject:(id)color.CGColor];
            }
            gradientLayer.colors = cgColors;
            gradientLayer.startPoint = self.gradientStartPoint;
            gradientLayer.endPoint = self.gradientEndPoint;
            [self.layer insertSublayer:gradientLayer atIndex:0];
        }
    }
}

@end
