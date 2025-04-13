//
//  HistoryView.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import <UIKit/UIKit.h>
#import "WaterFallLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryView : UIView

@property (strong, nonatomic, readwrite)UICollectionView* historyCollectionView;
@property (strong, nonatomic, readwrite)UIButton* releaseButton;
@property (strong, nonatomic, readwrite)WaterFallLayout* waterFallLayout;

@end

NS_ASSUME_NONNULL_END
