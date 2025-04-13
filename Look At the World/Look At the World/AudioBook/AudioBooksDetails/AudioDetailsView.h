//
//  AudioDetailsView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/19.
//

#import <UIKit/UIKit.h>
#import "AudioDetailsAuthorCell.h"
#import "AudioDetailsProfileCell.h"
#import "AudioDetailsListCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailsView : UIView
@property (nonatomic, strong) UITableView* tableView;
@end

NS_ASSUME_NONNULL_END
