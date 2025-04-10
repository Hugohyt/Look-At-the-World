//
//  SightsView.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "SightsView.h"
#import "ScrollTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "ListTableViewCell.h"

static const CGFloat width = 394;

@implementation SightsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.sightsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, width - 20, 660) style:UITableViewStylePlain];
    self.sightsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sightsTableView.estimatedRowHeight = 240;
    self.sightsTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.sightsTableView registerClass:[ScrollTableViewCell class] forCellReuseIdentifier:@"ScrollTableViewCell"];
    [self.sightsTableView registerClass:[ButtonTableViewCell class] forCellReuseIdentifier:@"ButtonTableViewCell"];
    [self.sightsTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:@"ListTableViewCell"];
    [self addSubview:self.sightsTableView];
    return self;
}


@end
