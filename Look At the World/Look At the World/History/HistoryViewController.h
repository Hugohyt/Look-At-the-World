//
//  HistoryViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import <UIKit/UIKit.h>
#import "HistoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic, readwrite)HistoryView* historyView;

@end

NS_ASSUME_NONNULL_END
