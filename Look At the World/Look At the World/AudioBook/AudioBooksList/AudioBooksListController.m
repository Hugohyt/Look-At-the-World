//
//  AudioBooksListController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/4.
//

#import "AudioBooksListController.h"

@interface AudioBooksListController ()

@end

@implementation AudioBooksListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listView = [[AudioBooksListView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.listView];
    self.listView.tableView.delegate = self;
    self.listView.tableView.dataSource = self;
    self.listView.tableView.estimatedRowHeight = 50;
    self.listView.tableView.rowHeight = UITableViewAutomaticDimension;
    self.ImageArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel* footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 25)];
    footLabel.text = @"已经到底啦～";
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.textColor = [UIColor darkGrayColor];
    NSLog(@"%@", self.booksDetailArr);
    self.listView.tableView.tableFooterView = footLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioBooksListCell* list = [self.listView.tableView dequeueReusableCellWithIdentifier:@"AudioBooksListCell"];
    if(!list) {
        list = [[AudioBooksListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AudioBooksListCell"];
    }
//    dispatch_group_t imageLoadGroup = dispatch_group_create();
//    dispatch_group_enter(imageLoadGroup);
    NSURL *imageURL = [NSURL URLWithString:self.booksDetailArr[indexPath.row][@"view"]];
    [list.coverIamge sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"图片加载失败%@", self.booksDetailArr[indexPath.row][@"name"]);
        } else {
            NSLog(@"图片加载成功%@", self.booksDetailArr[indexPath.row][@"name"]);
        }
//        dispatch_group_leave(imageLoadGroup);
    }];
//    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
//        [self.ImageArr addObject:list.coverIamge.image];
//    });
    
    list.nameLabel.text = self.booksDetailArr[indexPath.row][@"name"];
    list.authorLabel.text = self.booksDetailArr[indexPath.row][@"author"];
    list.playCount.text = [NSString stringWithFormat:@"%@万", self.booksDetailArr[indexPath.row][@"playcount"]];
    return list;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioDetailsController* detailsController = [[AudioDetailsController alloc] init];
    NSDictionary* dic = self.booksDetailArr[indexPath.row];
    detailsController.dataModel = [AudioListDataModel yy_modelWithDictionary:dic];
    NSLog(@"%@", detailsController.dataModel.bid);
    [self.navigationController pushViewController:detailsController animated:YES];
}


@end
