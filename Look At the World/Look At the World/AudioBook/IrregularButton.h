//
//  IrregularButton.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IrregularButton : UIButton

@property (nonatomic, strong) NSArray<NSValue *> *shapePoints;
@property (nonatomic, strong) NSArray<UIColor *> *gradientColors;
@property (nonatomic, assign) CGPoint gradientStartPoint;
@property (nonatomic, assign) CGPoint gradientEndPoint;

- (void)setIrregularShapeWithPoints:(NSArray<NSValue *> *)points;
- (void)setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
