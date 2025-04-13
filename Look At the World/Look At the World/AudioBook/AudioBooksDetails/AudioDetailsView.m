//
//  AudioDetailsView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/19.
//

#import "AudioDetailsView.h"

@implementation AudioDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 393, 754.333) style:UITableViewStyleGrouped];
//        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerClass:[AudioDetailsAuthorCell class] forCellReuseIdentifier:@"AudioDetailsAuthorCell"];
        [self.tableView registerClass:[AudioDetailsProfileCell class] forCellReuseIdentifier:@"AudioDetailsProfileCell"];
        [self.tableView registerClass:[AudioDetailsListCell class] forCellReuseIdentifier:@"AudioDetailsListCell"];
        [self.tableView registerClass:[AudioDetailsSubListCell class] forCellReuseIdentifier:@"AudioDetailsSubListCell"];
        
        [self addSubview:self.tableView];
        return self;
    }
    return self;
}


@end
