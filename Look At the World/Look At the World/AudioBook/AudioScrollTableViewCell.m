//
//  AudioScrollTableViewCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/11.
//

#import "AudioScrollTableViewCell.h"

static const int width = 393;

@implementation AudioScrollTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = [UIColor clearColor];;
    
    self.arrTopImage = [NSMutableArray array];
    
    self.audioScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 300)];
    self.audioScrollView.contentSize = CGSizeMake(1960, 300);
    
    self.audioScrollView.pagingEnabled = NO;
    self.audioScrollView.bounces = YES;
    self.audioScrollView.alwaysBounceHorizontal = YES;
    self.audioScrollView.scrollEnabled = YES;
    self.audioScrollView.showsHorizontalScrollIndicator = NO;
    self.audioScrollView.delegate = self;
    
    [self.audioScrollView setContentOffset:CGPointMake(343.5, 0)];
    
    [self.contentView addSubview:self.audioScrollView];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    }
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    return self;
}

- (void)scrollToNext {
    CGFloat contentOffsetX = self.audioScrollView.contentOffset.x;
    [self.audioScrollView setContentOffset:CGPointMake(contentOffsetX + 220, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self adjustImageSizes];
}
- (void)adjustImageSizes {
    CGFloat scrollCenterX = self.audioScrollView.contentOffset.x + self.audioScrollView.frame.size.width / 2;
    CGFloat imageWidth = 200;
    CGFloat imageSpacing = 20;
    CGFloat maxScale = 1.2; // 最大缩放比例
    CGFloat minScale = 1.0; // 最小缩放比例
    
    for (UIImageView *imageView in self.arrTopImage) {
        CGFloat imageCenterX = imageView.frame.origin.x + imageView.frame.size.width / 2;
        CGFloat distance = fabs(imageCenterX - scrollCenterX);
        CGFloat scale = maxScale - (maxScale - minScale) * (distance / (imageWidth + imageSpacing));
        scale = MAX(minScale, MIN(maxScale, scale)); // 确保缩放比例在有效范围内
        imageView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
        [self.timer invalidate];
        self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat imageWidth = 200;
    CGFloat imageSpacing = 20;
    CGFloat pageWidth = imageWidth + imageSpacing;

    // 考虑滚动速度计算目标偏移量
    CGFloat targetX = scrollView.contentOffset.x;

    // 计算最近的图片索引
    NSInteger nearestIndex = round(targetX / pageWidth);
    // 确保索引在有效范围内（1 到 7）
    nearestIndex = MAX(1, MIN(nearestIndex, 7));

    // 计算 UIScrollView 可见区域的中心位置相对于内容区域的偏移量
    CGFloat scrollViewCenterOffset = (scrollView.frame.size.width - imageWidth) / 2;

    // 计算最终的目标偏移量，使图片居中
    targetContentOffset->x = nearestIndex * pageWidth - scrollViewCenterOffset;

    // 确保目标偏移量在有效范围内
    targetContentOffset->x = MAX(0, MIN(targetContentOffset->x, scrollView.contentSize.width - scrollView.frame.size.width));
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat imageWidth = 200;
    CGFloat imageSpacing = 20;
    CGFloat pageWidth = imageWidth + imageSpacing;

    // 考虑滚动速度计算目标偏移量
    CGFloat targetX = scrollView.contentOffset.x;

    // 计算最近的图片索引
    NSInteger nearestIndex = round(targetX / pageWidth);
    // 确保索引在有效范围内（1 到 7）
    nearestIndex = MAX(1, MIN(nearestIndex, 7));

    // 计算 UIScrollView 可见区域的中心位置相对于内容区域的偏移量
    CGFloat scrollViewCenterOffset = (scrollView.frame.size.width - imageWidth) / 2;

    if (nearestIndex == 7) {
        [scrollView setContentOffset:CGPointMake(pageWidth * 2 - scrollViewCenterOffset, 0) animated:NO];
        NSLog(@"111");
    } else if (nearestIndex == 1) {
        [scrollView setContentOffset:CGPointMake(pageWidth * 6 - scrollViewCenterOffset, 0) animated:NO];
        NSLog(@"222");
        
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat imageWidth = 200;
    CGFloat imageSpacing = 20;
    CGFloat pageWidth = imageWidth + imageSpacing;

    // 考虑滚动速度计算目标偏移量
    CGFloat targetX = scrollView.contentOffset.x;

    // 计算最近的图片索引
    NSInteger nearestIndex = round(targetX / pageWidth);
    // 确保索引在有效范围内（1 到 7）
    nearestIndex = MAX(1, MIN(nearestIndex, 7));

    // 计算 UIScrollView 可见区域的中心位置相对于内容区域的偏移量
    CGFloat scrollViewCenterOffset = (scrollView.frame.size.width - imageWidth) / 2;

    if (nearestIndex == 7) {
        [scrollView setContentOffset:CGPointMake(pageWidth * 2 - scrollViewCenterOffset, 0) animated:NO];
    }
}

@end
