//
//  HistoryViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "HistoryViewController.h"
#import "HistoryCollectionViewCell.h"
#import "VideoViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.historyView = [[HistoryView alloc] initWithFrame:self.view.frame];
    self.historyView.historyCollectionView.delegate = self;
    self.historyView.historyCollectionView.dataSource = self;
    [self.historyView.historyCollectionView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [self.view addSubview:self.historyView];
    
    UIImageView *layerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 758, 394, 100)];
    [layerImageView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.9 blue:0.8 alpha:1.0]];
    [self.historyView addSubview:layerImageView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 14;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*) collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HistoryCollectionViewCell* historyCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HistoryCollectionViewCell" forIndexPath:indexPath];
    historyCollectionViewCell.historyImageView.image = [UIImage imageNamed:@"历史封面.jpg"];
    historyCollectionViewCell.avatarImageView.image = [UIImage imageNamed:@"头像.jpg"];
    [historyCollectionViewCell.likesCountLabel setText:@"6440"];
    [historyCollectionViewCell.titleLabel setText:@"苏轼诗中的”天上宫阙“此刻具像化了!"];
    [historyCollectionViewCell.nameLabel setText:@"意梦"];
    historyCollectionViewCell.backgroundColor = [UIColor whiteColor];
    historyCollectionViewCell.layer.cornerRadius = 5;
    historyCollectionViewCell.layer.masksToBounds = YES;
    return historyCollectionViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        VideoViewController* videoViewController = [[VideoViewController alloc] init];
        videoViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:videoViewController animated:YES];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
