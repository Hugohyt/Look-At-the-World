//
//  AudioPlayViewController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/18.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <YYModel/YYModel.h>
#import "AudioPlayView.h"
#import "AudioDetailsView.h"
#import "AudioDetailDataModel.h"
#import "AudioPlayerManager.h"

typedef NS_ENUM(NSInteger, ButtonState) {
    ButtonStateInitial = 0,  // 初始状态
    ButtonStateSecond,       // 第二状态
    ButtonStateThird,        // 第三状态
    ButtonStateFourth,        // 第四状态
    ButtonStateFifth
};

@interface AudioPlayViewController : UIViewController

@property (nonatomic, strong) AudioPlayView* audioPlayView;
@property (nonatomic, strong) AVPlayer* audioPlayer;
@property (nonatomic, strong) AVPlayerItem* audioPlayerItem;
@property (nonatomic, strong) NSTimer* playTime;
//@property (nonatomic, strong) AudioDetailsView *previousViewControllerView; // 用于存储上个视图控制器的视图
@property (nonatomic, strong) AudioDetailDataModel* dataModel;
@property (nonatomic, strong) UIImageView* bookImage;
@property (nonatomic, strong) NSArray* chapterArr;
@property (nonatomic, assign) NSInteger indexpath;
@property (assign, nonatomic) ButtonState currentButtonState;

@end


