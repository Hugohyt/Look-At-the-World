//
//  ScrollTableViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/5.
//

#import "ScrollTableViewCell.h"

static const int width = 394;

@implementation ScrollTableViewCell

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
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.9 blue:0.8 alpha:1.0];
    
    self.sightsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 400)];
    self.sightsScrollView.contentSize = CGSizeMake(width * 10, 400);
    
    self.sightsScrollView.pagingEnabled = YES;
    self.sightsScrollView.bounces = YES;
    self.sightsScrollView.alwaysBounceHorizontal = YES;
    self.sightsScrollView.scrollEnabled = YES;
    self.sightsScrollView.showsHorizontalScrollIndicator = NO;
    self.sightsScrollView.delegate = self;
    
    [self.sightsScrollView setContentOffset:CGPointMake(width, 0)];
    
    [self.contentView addSubview:self.sightsScrollView];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    }
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    return self;
}

- (void)scrollToNext {
    CGFloat contentOffsetX = self.sightsScrollView.contentOffset.x;
    [self.sightsScrollView setContentOffset:CGPointMake(contentOffsetX + width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat screenWidth = CGRectGetWidth(scrollView.frame);
    CGFloat contentWidth = scrollView.contentSize.width;
    
    if (contentOffsetX >= contentWidth - screenWidth) {
        [scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    } else if (contentOffsetX < screenWidth - scrollView.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(contentWidth - 2 * screenWidth, 0) animated:NO];
        return;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
        [self.timer invalidate];
        self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}


@end
