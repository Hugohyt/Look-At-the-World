//
//  HistoryView.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import "HistoryView.h"
#import "HistoryCollectionViewCell.h"
#import "WaterFallLayout.h"
#import "WaterFallLayout.h"

static const CGFloat width = 394;

@implementation HistoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    
    WaterFallLayout* waterFallLayout = [[WaterFallLayout alloc] init];
    waterFallLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    self.historyCollectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, width, 760) collectionViewLayout:waterFallLayout];
    [self.historyCollectionView registerClass:[HistoryCollectionViewCell class] forCellWithReuseIdentifier:@"HistoryCollectionViewCell"];
    self.historyCollectionView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.historyCollectionView];
    return self;
}

@end
