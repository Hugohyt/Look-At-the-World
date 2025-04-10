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

typedef NS_ENUM(NSUInteger, TableViewLoadState) {
    TableViewLoadStateIdle,      // 空闲状态
    TableViewLoadStateLoading,   // 加载中
    TableViewLoadStateInit     // 初始化数据
};

@interface SightsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic, readwrite)SightsView *sightsView;
@property(strong, nonatomic, readwrite)SightsModel *sightsModel;
@property(strong, nonatomic, readwrite)NSMutableArray* sightsModelArray;
@property(assign, nonatomic, readwrite)TableViewLoadState* loadState;

@end

NS_ASSUME_NONNULL_END
