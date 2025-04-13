//
//  BooksViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import <UIKit/UIKit.h>
#import "AudioBookView.h"
#import "AudioPlayViewController.h"
#import "AudioDetailsController.h"
#import "AudioBooksListController.h"
#import "ManagerGet.h"
#import "AudioDetailModel.h"
#import <YYModel/YYModel.h>
#import <Masonry/Masonry.h>
#import "NoticeModel.h"
#import "PersonalController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BooksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AudioBookView* audiobooksView;
@property (nonatomic, strong) AudioDetailModel* detailModel;

@end

NS_ASSUME_NONNULL_END
