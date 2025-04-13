//
//  AudioDetailsListCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/25.
//

#import "AudioDetailsListCell.h"

@implementation AudioDetailsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 393, 724.333) style:UITableViewStylePlain];
    self.listTableView.tag = 102;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.arrBooks = [NSMutableArray array];
    [self.contentView addSubview:self.listTableView];
    [self.listTableView registerClass:[AudioDetailsSubListCell class] forCellReuseIdentifier:@"AudioDetailsSubListCell"];
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.arrBooks.count;
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioDetailsSubListCell* cell = [self.listTableView dequeueReusableCellWithIdentifier:@"AudioDetailsSubListCell"];
    if(!cell) {
        cell = [[AudioDetailsSubListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AudioDetailsSubListCell"];
    }
    return cell;
}

@end
