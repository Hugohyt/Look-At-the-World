//
//  VideoCommentViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/10.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoCommentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, readwrite)UITableView* commentTableView;
@property (strong, nonatomic, readwrite)NSDictionary* articleModelDictionary;
@property (strong, nonatomic, readwrite)NSMutableArray<Comment*>* commentArray;
@property (strong, nonatomic, readwrite)UITextView* inputTextView;
@property (strong, nonatomic, readwrite)UIButton* sendButton;
@property (strong, nonatomic, readwrite)NSString* authorization;
@property (strong, nonatomic, readwrite)UIView* inputBoxView;
@property (strong, nonatomic, readwrite)Comment* replyedComment;
@property (assign, nonatomic, readwrite)NSInteger replyedSection;

@end

NS_ASSUME_NONNULL_END
