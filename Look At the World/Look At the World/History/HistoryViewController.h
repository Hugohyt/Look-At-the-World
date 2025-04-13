//
//  HistoryViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import <UIKit/UIKit.h>
#import "HistoryView.h"
#import "PersonalController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CollectionViewLoadState) {
    CollectionViewLoadStateIdle,      // 空闲状态
    CollectionViewLoadStateLoading,   // 加载中
    CollectionViewLoadStateInit     // 初始化数据
};

@interface HistoryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic, readwrite)HistoryView* historyView;
@property (strong, nonatomic, readwrite)NSMutableArray* imageArray;
@property (strong, nonatomic, readwrite)NSArray* titleArray;
@property (strong, nonatomic, readwrite)UIImagePickerController* pickerView;
@property (strong, nonatomic, readwrite)NSMutableArray* modelArray;
@property (strong, nonatomic, readwrite)UIActivityIndicatorView* fullscreenIndicator;
@property (assign, nonatomic, readwrite)CollectionViewLoadState* loadState;
@property (assign, nonatomic, readwrite)int page;
@property (strong, nonatomic, readwrite)UIActivityIndicatorView* footerIndicator;
@property (strong, nonatomic, readwrite)NSMutableArray* heightArray;

@end

NS_ASSUME_NONNULL_END
