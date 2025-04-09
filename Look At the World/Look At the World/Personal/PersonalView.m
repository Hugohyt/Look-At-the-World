//
//  PersonalView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import "PersonalView.h"
#import "StarTableViewCell.h"
#import "StarModel.h"

@implementation PersonalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setIconAndName];
        [self SettingView];
    }
    return self;
}

- (void)setIconAndName {
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 100, 60)];
    [self.nameLabel setText:@"你好"];
    self.avatarImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//                           WithImage:[UIImage imageNamed:@"美食3.jpg"]];
    [self.avatarImageBtn setImage:[UIImage imageNamed:@"美食3.jpg"] forState:UIControlStateNormal];
    self.avatarImageBtn.frame = CGRectMake(100, 160, 80, 80);
    self.avatarImageBtn.layer.cornerRadius = self.avatarImageBtn.frame.size.width / 2;
    self.avatarImageBtn.layer.masksToBounds = YES;
    [self addSubview:self.nameLabel];
    [self addSubview:self.avatarImageBtn];
}

-(void) SettingView {
    self.leftData = [NSMutableArray arrayWithObjects:[[StarModel alloc] initWithData:@{@"name":@"美食1", @"image":[UIImage imageNamed:@"美食1.jpg"]}],[[StarModel alloc] initWithData:@{@"name":@"美食2", @"image":[UIImage imageNamed:@"美食2.jpg"]}], [[StarModel alloc] initWithData:@{@"name":@"美食3", @"image":[UIImage imageNamed:@"美食3.jpg"]}] ,nil];
    self.rightData = [NSMutableArray arrayWithObjects:[[StarModel alloc] initWithData:@{@"name":@"美食1", @"image":[UIImage imageNamed:@"美食1.jpg"]}],[[StarModel alloc] initWithData:@{@"name":@"美食2", @"image":[UIImage imageNamed:@"美食2.jpg"]}], [[StarModel alloc] initWithData:@{@"name":@"美食3", @"image":[UIImage imageNamed:@"美食3.jpg"]}] ,nil];
    
    // 创建分栏控件
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Left", @"Right"]];
    self.segmentedControl.frame = CGRectMake(2, 240, self.frame.size.width - 4, 60);
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentTintColor = [UIColor lightGrayColor];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentedControl];
    
    // 创建左边的 UITableView
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, self.bounds.size.width, self.bounds.size.height - 100) style:UITableViewStylePlain];
    self.leftTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.leftTableView.estimatedRowHeight = 120;
    self.leftTableView.dataSource = self;
    self.leftTableView.delegate = self;
    [self addSubview:self.leftTableView];
    
    // 创建右边的 UITableView
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, self.bounds.size.width, self .bounds.size.height - 100) style:UITableViewStylePlain];
    self.rightTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.rightTableView.estimatedRowHeight = 120;
    self.rightTableView.dataSource = self;
    self.rightTableView.delegate = self;
    self.rightTableView.hidden = YES; // 初始时隐藏右边的表格视图
    [self addSubview:self.rightTableView];
    
    [self.leftTableView registerClass:[StarTableViewCell class] forCellReuseIdentifier:@"StarTableViewCell"];
    [self.rightTableView registerClass:[StarTableViewCell class] forCellReuseIdentifier:@"StarTableViewCell"];
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.leftTableView.hidden = NO;
        self.rightTableView.hidden = YES;
    } else {
        self.leftTableView.hidden = YES;
        self.rightTableView.hidden = NO;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftData.count;
    } else {
        return self.rightData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarTableViewCell"];
    [cell.contentView addSubview:cell.iconImageView];
    [cell.contentView addSubview:cell.nameLabel];
    [cell.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(20);
        make.top.equalTo(cell.contentView).offset(20);
        make.height.width.mas_equalTo(120);
    }];
    [cell.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.iconImageView.mas_right).offset(20);
        make.top.equalTo(cell.contentView).offset(20);
        make.bottom.equalTo(cell.contentView).offset(-100);
    }];
    if (tableView == self.leftTableView) {
        [cell configureWithModel:self.leftData[indexPath.row]];
    } else {
        [cell configureWithModel:self.rightData[indexPath.row]];
    }
    
    return cell;
}

@end
