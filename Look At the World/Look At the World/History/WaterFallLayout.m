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
    NSIndexPath *footerIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        UICollectionViewLayoutAttributes *footerAttributes =
            [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                 atIndexPath:footerIndexPath];

        if (footerAttributes) {
            [attributeArray addObject:footerAttributes];
        }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind
                                                                     atIndexPath:(NSIndexPath *)indexPath {
    if (![kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return nil;
    }

    UICollectionViewLayoutAttributes *attributes =
        [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind
                                                                       withIndexPath:indexPath];
    
    CGFloat footerHeight =  50;
    CGFloat yPosition = [[_originYAry valueForKeyPath:@"@max.floatValue"] floatValue] + 10; // 放在底部

    attributes.frame = CGRectMake(0, yPosition, self.collectionView.frame.size.width, footerHeight);
    attributes.zIndex = 1000; // 让 footer 不被遮挡

    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 15) /_collectViewRowCount;
    CGFloat height = 200;
    if (self.imageArray[indexPath.item]) {
        height = [self getHeightForImage:self.imageArray[indexPath.item] withWidth:width];
        height = height + 80;
    }
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

- (CGFloat)getHeightForImage:(UIImage*)image withWidth:(CGFloat)width {
    NSLog(@"width:%lf",width);
    CGFloat height = image.size.height / image.size.width * width;
    return height;
}

-(CGSize)collectionViewContentSize{
    CGFloat maxY =[[_originYAry valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, maxY + 60);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *visibleAttributes = [[NSMutableArray alloc] init];

    for (UICollectionViewLayoutAttributes *attributes in attributeArray) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [visibleAttributes addObject:attributes];
        }
    }

    return visibleAttributes;
}

@end
