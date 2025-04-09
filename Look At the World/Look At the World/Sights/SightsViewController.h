//
//  SightsViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import <UIKit/UIKit.h>
#import "SightsModel.h"

#import "SightsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SightsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic, readwrite)SightsView *sightsView;
@property(strong, nonatomic, readwrite)SightsModel *sightsModel;

@end

NS_ASSUME_NONNULL_END
