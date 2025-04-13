//
//  CollectionController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/10.
//

#import "CollectionController.h"
#import "StarTableViewCell.h"
@interface CollectionController ()

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UILabel* label = [[UILabel alloc] init];
    label.text = @"已经到底啦～";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = label;
    [self.tableView registerClass:[StarTableViewCell class] forCellReuseIdentifier:@"StarTableViewCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StarTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"StarTableViewCell"];
    [cell configureWithModel:self.leftData[indexPath.row]];
    //        @property (strong, nonatomic)UIImageView *iconImageView;
    //        @property (strong, nonatomic)UILabel *nameLabel;
    
    return cell;
}


@end
