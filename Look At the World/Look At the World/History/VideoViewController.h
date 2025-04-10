//
//  VideoViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/11.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, readwrite)UITableView* videoTableView;
@property (assign, nonatomic, readwrite)NSInteger currentIndex;
@property (strong, nonatomic)NSDictionary* articleModelDicitionary;
@property (strong, nonatomic) NSMutableArray* videoArray;
@property (strong, nonatomic)NSString* videoID;

@end

NS_ASSUME_NONNULL_END
