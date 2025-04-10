//
//  VideoViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import "VideoViewController.h"
#import "VideoView.h"
#import "VideoTableViewCell.h"
#import "AVPlayerManager.h"
#import "AFNetworking/AFNetworking.h"
#import "YYModel/YYModel.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
#import "VideoCommentViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.videoArray = [NSMutableArray array];
    [self.videoArray addObject:self.articleModelDicitionary];
    self.videoID = self.articleModelDicitionary[@"videoid"];
    
    self.videoTableView = [[UITableView alloc] init];
    self.videoTableView.frame = CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height * 3);
    
    self.videoTableView.contentInset = UIEdgeInsetsMake(self.view.frame.size.height, 0, self.view.frame.size.height, 0);
    self.videoTableView.delegate = self;
    self.videoTableView.dataSource = self;
    
    self.videoTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self.videoTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"VideoTableViewCell"];
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"返回.jpg"] forState:UIControlStateNormal];
    exitButton.frame = CGRectMake(0, 60, 20, 20);
    [exitButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.videoTableView];
    [self.videoTableView reloadData];
    [self.view addSubview:exitButton];
    
//    NSIndexPath* curIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
//    [self.videoTableView scrollToRowAtIndexPath:curIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld %d", indexPath.row, self.videoArray.count);
    if ((int)indexPath.row == self.videoArray.count - 1) {
        [self loadMoreVideos];
    }
}

- (void)loadMoreVideos {
    NSLog(@"刷新");
    NSString *urlString = @"https://travel.knoci.cn/articles/video";
        [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"id":[self updateVideoID]} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            VideoModel *videoModel = [VideoModel yy_modelWithJSON:responseObject];
            NSDictionary* ModelDictionary = [videoModel yy_modelToJSONObject];
                [self.videoArray addObject:ModelDictionary[@"data"]];
            NSLog(@"预加载后：%@",self.videoArray);
                self.videoID = ModelDictionary[@"data"][@"videoid"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.videoTableView beginUpdates];
                NSInteger newIndex = self.videoArray.count - 1;
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newIndex inSection:0];
                    [self.videoTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.videoTableView endUpdates];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"刷新error: %@", error);
        }];
}

- (NSString*)updateVideoID{
    int i = [self.videoID intValue];
    i++;
    i = (i % 8);
    if (i == 0) {
        i = 1;
    }
    return [NSString stringWithFormat:@"%d",i];
}

- (void)back {
    [[AVPlayerManager shareManager] pauseAll];
    [[AVPlayerManager shareManager] removeAllPlayers];
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"执行获取cell方法");
    VideoTableViewCell* videoTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"VideoTableViewCell"];
        [videoTableViewCell.videoView startDownloadBackgroundTaskWithString:self.videoArray[indexPath.item][@"view"][1]];
    [videoTableViewCell.videoView.nameLabel setText:self.videoArray[indexPath.item][@"name"]];
    [videoTableViewCell.videoView.detailLabel setText:self.videoArray[indexPath.item][@"content"]];
    [videoTableViewCell.videoView.likesLabel setText:[NSString stringWithFormat:@"%@", self.videoArray[indexPath.item][@"likes"]]];
    [videoTableViewCell.videoView.commentsLabel setText:[NSString stringWithFormat:@"%@", self.videoArray[indexPath.item][@"comments"]]];
    [videoTableViewCell.videoView.starsLabel setText:[NSString stringWithFormat:@"%@", self.videoArray[indexPath.item][@"comments"]]];
    [videoTableViewCell.videoView.avatarImageView sd_setImageWithURL:self.videoArray[indexPath.item][@"avatar"]];
    videoTableViewCell.videoView.commentButton.tag = indexPath.row;
    [videoTableViewCell.videoView.commentButton addTarget:self action:@selector(pushCommentViewController:) forControlEvents:UIControlEventTouchUpInside];
    if (videoTableViewCell.indexPath != indexPath && indexPath.row != 0) {
        NSLog(@"indexPath.row:%ld, 回调不符", (long)indexPath.row);
        __weak typeof(videoTableViewCell) wcell = videoTableViewCell;
        __weak typeof(self)wself = self;
        videoTableViewCell.onPlayerReady = ^{
            NSIndexPath *indexPath = [wself.videoTableView indexPathForCell:wcell];
            if (indexPath && indexPath.row == wself.currentIndex) {
                [wcell.videoView playVideo];
                NSLog(@"player:%@", wcell.videoView.playerItem);
                NSLog(@"回调开播");
                wcell.indexPath = indexPath;
            }
        };
   }
    return videoTableViewCell;
}

- (void)pushCommentViewController:(UIButton*)button {
    VideoCommentViewController* videoCommentViewController = [[VideoCommentViewController alloc] init];
    videoCommentViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            
            // 2. 获取 sheet 控制器
            UISheetPresentationController *sheet = videoCommentViewController.sheetPresentationController;
    if (sheet) {
        // 3. 设置高度模式（.medium 是半屏，.large 是全屏）
        sheet.detents = @[[UISheetPresentationControllerDetent mediumDetent]];
        
        // 4. 显示顶部拖拽指示器（可选）
        sheet.prefersGrabberVisible = YES;
    }
    videoCommentViewController.articleModelDictionary = self.articleModelDicitionary;
    [self presentViewController:videoCommentViewController animated:YES completion:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGPoint translatePoint = [scrollView.panGestureRecognizer translationInView:scrollView];
        scrollView.panGestureRecognizer.enabled = NO;
        
        if (translatePoint.y < -50 && self.currentIndex < self.videoArray.count) {
            self.currentIndex ++;
        }
        if (translatePoint.y > 50 && self.currentIndex > 0) {
            self.currentIndex --;
        }
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.videoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        } completion:^(BOOL finished) {
            scrollView.panGestureRecognizer.enabled = YES;
        }];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"currentIndex"]) {
        VideoTableViewCell *videoTableViewCell = [self.videoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
        if (!videoTableViewCell) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __weak typeof(videoTableViewCell) retryCell = [self.videoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
                    if (retryCell && retryCell.videoView.playerItem.status == AVPlayerItemStatusReadyToPlay) {
                        [retryCell.videoView playVideo];
                    } else {
                        retryCell.onPlayerReady = ^{
                            [retryCell.videoView playVideo];
                        };
                    }
                });
                return;
        }
//        [videoTableViewCell.videoView startDownloadBackgroundTaskWithString:self.videoArray[_currentIndex][@"view"][0]];
        NSLog(@"%@ %ld", self.videoArray[_currentIndex], (long)_currentIndex);
        __weak typeof(videoTableViewCell) wcell = videoTableViewCell;
        __weak typeof(self)wself = self;
        if (videoTableViewCell.videoView.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
            [videoTableViewCell.videoView playVideo];
            NSLog(@"%@ %ld", self.videoArray[_currentIndex], (long)_currentIndex);
            NSLog(@"player:%@", videoTableViewCell.videoView.playerItem);
            NSLog(@"这里开播");
            return;
        } else {
            videoTableViewCell.onPlayerReady = ^{
                NSIndexPath *indexPath = [wself.videoTableView indexPathForCell:wcell];
                if (indexPath && indexPath.row == wself.currentIndex) {
                    [wcell.videoView playVideo];
                    NSLog(@"player:%@", wcell.videoView.playerItem);
                    NSLog(@"回调开播");
                    wcell.indexPath = indexPath;
                }
            };
        }
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
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
