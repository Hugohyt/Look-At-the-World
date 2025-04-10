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
    
    self.waterFallLayout = [[WaterFallLayout alloc] init];
    self.waterFallLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.waterFallLayout.footerReferenceSize = CGSizeMake(394, 100);
    
    
    self.historyCollectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, width, 760) collectionViewLayout:self.waterFallLayout];
    [self.historyCollectionView registerClass:[HistoryCollectionViewCell class] forCellWithReuseIdentifier:@"HistoryCollectionViewCell"];
    self.historyCollectionView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.historyCollectionView];
    
//    self.releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.releaseButton setImage:[UIImage imageNamed:@"发布.jpg"] forState:UIControlStateNormal];
//    self.releaseButton.frame = CGRectMake(343, 30, 40, 40);
//    [self addSubview:self.releaseButton];
    
    return self;
}

@end
