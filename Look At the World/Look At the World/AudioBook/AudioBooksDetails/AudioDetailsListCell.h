//
//  AudioDetailsListCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/25.
//

#import <UIKit/UIKit.h>
#import "AudioDetailsSubListCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailsListCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
 
@property (nonatomic, strong) UITableView* listTableView;
@property (nonatomic, strong) NSMutableArray* arrBooks;

@end

NS_ASSUME_NONNULL_END
