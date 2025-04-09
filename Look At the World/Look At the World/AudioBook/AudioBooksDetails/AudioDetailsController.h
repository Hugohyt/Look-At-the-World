//
//  AudioDetailsController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/19.
//

#import <UIKit/UIKit.h>
#import "AudioDetailsView.h"
#import "AudioPlayViewController.h"
#import "AudioDetailModel.h"
#import "AudioListDataModel.h"
#import "ManagerGet.h"
#import "NoticeModel.h"
#import <SDWebImage/SDWebImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailsController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AudioDetailsView* audioDetailsView;
@property (nonatomic, strong) AudioDetailModel* listModel;
@property (nonatomic, strong) AudioListDataModel* dataModel;
@property (nonatomic, strong) NSArray* chapterArr;

@end

NS_ASSUME_NONNULL_END
