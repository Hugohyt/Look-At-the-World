//
//  PersonalView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "StarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton* avatarImageBtn;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSMutableArray<StarModel*> *leftData;
@property (nonatomic, strong) NSMutableArray<StarModel*> *rightData;

@end

NS_ASSUME_NONNULL_END
