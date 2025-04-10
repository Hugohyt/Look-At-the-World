//
//  VideoTableViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/18.
//

#import <UIKit/UIKit.h>
#import "VideoView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnPlayerReady)(void);

@interface VideoTableViewCell : UITableViewCell <AVPlayerUpdateDelegate>

@property (strong, nonatomic, readwrite)VideoView* videoView;
@property (copy, nonatomic, readwrite)OnPlayerReady onPlayerReady;
@property (strong, nonatomic, readwrite)NSIndexPath* indexPath;

@end

NS_ASSUME_NONNULL_END
