//
//  WaterFallLayout.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import "WaterFallLayout.h"

@implementation WaterFallLayout {
    NSMutableArray * attributeArray; 
    NSInteger _collectViewRowCount;
    NSMutableArray * _originYAry;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        attributeArray = [NSMutableArray array];
        _originYAry = [NSMutableArray array];
        _collectViewRowCount = 2;
    }
    return self;
}


- (void)prepareLayout{
    
    [attributeArray removeAllObjects];
    [_originYAry removeAllObjects];
    
    for (int i =0; i <_collectViewRowCount; i++) {
        [_originYAry addObject:@(0)];
    }
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
        
    for (int i = 0; i < cellCount; i ++ ) {
            
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes *attrib = [self layoutAttributesForItemAtIndexPath:indexPath];
            
        [attributeArray addObject:attrib];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 15) /_collectViewRowCount;
    CGFloat height = 240 + arc4random_uniform(60);
    int flag;
    
    if ([_originYAry[0] floatValue]> [_originYAry[1] floatValue]) {
        flag = 1;
    } else {
        flag = 0;
    }
    
    CGFloat x = (width + 5) * flag;
    CGFloat y = [_originYAry[flag] floatValue];
    _originYAry[flag] = @(height + y +10);
    layoutAttr.frame =CGRectMake(x, y, width, height);
    
    return layoutAttr;
}

-(CGSize)collectionViewContentSize{
    CGFloat maxY =[[_originYAry valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, maxY);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return attributeArray;
}

@end
