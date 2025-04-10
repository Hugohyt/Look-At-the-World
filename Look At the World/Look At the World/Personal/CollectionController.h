//
//  CollectionController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@end

NS_ASSUME_NONNULL_END
