//
//  AudioBooksListController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/4.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "AudioDetailsController.h"
#import "AudioBooksListView.h"
#import <SDWebImage/SDWebImage.h>
#import <UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioBooksListController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AudioBooksListView* listView;
@property (nonatomic, strong) NSArray* booksDetailArr;
@property (nonatomic, strong) NSMutableArray* ImageArr;

@end

NS_ASSUME_NONNULL_END
