//
//  VideoTableViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/18.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.videoView.player.currentItem];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.videoView = [[VideoView alloc] initWithFrame:CGRectMake(0, 0, 393, 852)];
    self.videoView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.videoView];
    self.videoView.delegate = self;
    self.indexPath = [[NSIndexPath alloc] init];
    
    return self;
}

- (void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status {
    NSLog(@"执行协议");
    NSLog(@"cell层：%ld",(long)status);
    switch (status) {
        case AVPlayerItemStatusUnknown:
            NSLog(@"1");
            break;
        case AVPlayerItemStatusReadyToPlay:
            if (!self.onPlayerReady) {
                NSLog(@"空的！");
            }
            NSLog(@"%@",self.onPlayerReady);
            if (self.onPlayerReady) {
                self.onPlayerReady();
                NSLog(@"执行");
            }
            break;
        case AVPlayerItemStatusFailed:
            NSLog(@"播放状态异常");
            break;
        default:
            NSLog(@"2");
            break;
    }
}

@end
