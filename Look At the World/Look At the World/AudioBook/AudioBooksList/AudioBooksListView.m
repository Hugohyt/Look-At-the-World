//
//  AudioBooksListView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/4.
//

#import "AudioBooksListView.h"

@implementation AudioBooksListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.frame = self.frame;
        [self addSubview:self.tableView];
        [self.tableView registerClass:[AudioBooksListCell class] forCellReuseIdentifier:@"AudioBooksListCell"];
    }
    return self;
}

@end
