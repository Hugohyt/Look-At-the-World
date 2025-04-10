//
//  ArticleViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/25.
//

#import "ArticleViewController.h"
#import "ArticleScrollTableViewCell.h"
#import "ArticleTableViewCell.h"
#import "Masonry/Masonry.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking/AFNetworking.h"
#import "CommentModel.h"
#import "YYModel/YYModel.h"
#import "CommentCell.h"
#import "CommentNetworkManager.h"
#import "ReplyTableViewCell.h"
#import "Comment.h"
#import "NewCommentModel.h"
#import "DeleteModel.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.articleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.top.equalTo(self.view.mas_top);
//        make.left.width.equalTo(self.view);
//    }];
    self.commentArray = [NSMutableArray array];
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(globalQueue, ^{
//        NSLog(@"%@", self.articleModelDictionary[@"aid"]);
//        NSString* urlString = @"https://travel.knoci.cn/comments/list";
//        [[AFHTTPSessionManager manager] GET:urlString parameters:@{@"aid":self.articleModelDictionary[@"aid"]} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            CommentModel* commentModel = [CommentModel yy_modelWithJSON:responseObject];
//            NSDictionary* dicitionary = [commentModel yy_modelToJSONObject];
//            NSLog(@"评论:%@", dicitionary);
//            [self.commentArray addObjectsFromArray:dicitionary[@"data"]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self setTableView];
//                [self loadNavgationBar];
//            });
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error");
//        }];
//    });
    self.authorization = @"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiIzYTg2ZTE4Yi04MmE0LTQzOTMtOTdhMC05MmEzN2UxMjIzMTEiLCJuYW1lIjoiSHVnbyIsImF2YXRhciI6Imh0dHBzOi8vYXZhdGFycy5naXRodWJ1c2VyY29udGVudC5jb20vdS8xMjkwNzgxOTQiLCJleHAiOjE3NDQ0NjAzMDksIm5iZiI6MTc0NDAyODMwOSwiaWF0IjoxNzQ0MDI4MzA5fQ.aKjUPycV4GoP0mJbiwqHuYgWD4e9DcWDi_zmQ7eoAT0";
    [[CommentNetworkManager sharedManager] fetchTopLevelCommentsForTarget:self.articleModelDictionary[@"aid"] completion:^(NSArray<Comment *> * _Nonnull comments, NSError * _Nonnull error) {
        self.commentArray = [NSMutableArray arrayWithArray:comments];
        dispatch_group_t group = dispatch_group_create();
        [self.commentArray enumerateObjectsUsingBlock:^(Comment * _Nonnull comment, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_group_enter(group);
            [[CommentNetworkManager sharedManager] fetchAllRepliesForComment:comment.cid completion:^(NSArray<Comment *> * _Nonnull replies, NSError * _Nonnull error) {
                comment.replies = [NSMutableArray arrayWithArray:replies];
                dispatch_group_leave(group);
            }];
        }];
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [self setTableView];
            [self loadNavgationBar];
            [self loadTextView];
        });
    }];
}

- (void)loadTextView{
    self.inputBoxView = [[UIView alloc] init];
    [self.inputBoxView setBackgroundColor:[UIColor whiteColor]];
    
    self.inputTextView = [[UITextView alloc] init];
    _inputTextView = [[UITextView alloc] init];
    _inputTextView.layer.cornerRadius = 16;
    _inputTextView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    _inputTextView.font = [UIFont systemFontOfSize:18];
    [_inputTextView setTextColor:[UIColor lightGrayColor]];
    
    
    // 发送按钮
    _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    _sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _sendButton.tag = 01;
    [_sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_inputBoxView];
    [self.inputBoxView addSubview:_inputTextView];
    [self.inputBoxView addSubview:_sendButton];
    
    [self.inputBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(self.view);
    }];
    
    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBoxView).offset(20);
        make.bottom.equalTo(self.inputBoxView).offset(-20);
        make.height.mas_equalTo(40);
        make.right.equalTo(_sendButton.mas_left).offset(-10);
    }];
    
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.inputBoxView).offset(-10);
        make.centerY.equalTo(self.inputTextView);
        make.width.mas_equalTo(60);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    [self.articleTableView addGestureRecognizer:tap];
}

//- (void)hideKeyboard {
//    [self.inputTextView resignFirstResponder];
//}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    CGFloat offset = keyboardHeight;

    [_inputBoxView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
    
    [_inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight - 20);
    }];
    
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16)
                     animations:^{
        [self.articleTableView setContentOffset:CGPointMake(0, self.articleTableView.contentOffset.y + offset)];
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    // 计算偏移量
    CGFloat offset = keyboardHeight;
    
    // 恢复初始底部约束
    [_inputBoxView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    
    [_inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
    }];
    
    // 同步动画
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16)
                     animations:^{
        [self.articleTableView setContentOffset:CGPointMake(0, self.articleTableView.contentOffset.y - offset) animated:YES];
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _sendButton.tag = 01;
    // 全局结束编辑状态（自动识别当前第一响应者）
    [self.view endEditing:YES];
}

- (void)dealloc {
    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)send:(UIButton*)button {
    NSString *content = [_inputTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (content.length == 0) {
            NSLog(@"评论不能为空");
            return;
        }
    if (button.tag == 01) {
        NSLog(@"发送评论");
        [self sendComment];
    } else if (button.tag == 02 || button.tag == 03) {
        NSLog(@"发送回复");
        [self sendReplyWithFlag:button.tag];
    } else {
        return;
    }
}

- (void)sendReplyWithFlag:(NSInteger)flag {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求序列化器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置相应序列化器为 AFJSONResponseSerializer，用于将服务器返回的 JSON 数据转换为 NSDictionary 或 NSArray
    NSString* replyedId = [NSString string];
    if(flag == 02) {
        replyedId = self.replyedComment.cid;
    } else {
        replyedId = self.replyedComment.replycid;
    }
    NSLog(@"replyedId:%@ %d", replyedId, flag);
    NSDictionary *parameters = @{@"target":self.articleModelDictionary[@"aid"],@"content":self.inputTextView.text, @"replycid":replyedId, @"replyname":self.replyedComment.name};
    NSLog(@"zheli:%@ %@ %@ %@",self.replyedComment, self.replyedComment.content, self.replyedComment.cid, self.replyedComment.name);
    [manager.requestSerializer setValue:self.authorization forHTTPHeaderField:@"Authorization"];
    [manager POST:@"https://travel.knoci.cn/comment/commit" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NewCommentModel* newCommentModel = [NewCommentModel yy_modelWithJSON:responseObject];
        SubNewCommentModel* subNewCommentModel = newCommentModel.data;
        NSLog(@"sub:%@", subNewCommentModel.content);
        NSDictionary* dictionary = [subNewCommentModel yy_modelToJSONObject];
        NSLog(@"dict:%@",dictionary);
                Comment* newComment = [[Comment alloc] initWithDictionary:dictionary];
        NSLog(@"%@", newComment.content);
        [self.commentArray[self.replyedSection].replies insertObject:newComment atIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
                    [self.articleTableView beginUpdates];
            [self.articleTableView reloadSections:[NSIndexSet indexSetWithIndex:self.replyedSection + 2] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self.articleTableView endUpdates];
            self.inputTextView.text = @"";
            self.sendButton.tag = 01;
                });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

- (void)sendComment {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求序列化器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置相应序列化器为 AFJSONResponseSerializer，用于将服务器返回的 JSON 数据转换为 NSDictionary 或 NSArray
    NSDictionary *parameters = @{@"target":self.articleModelDictionary[@"aid"],@"content":self.inputTextView.text, @"replycid":@"", @"replyname":@""};
    [manager.requestSerializer setValue:self.authorization forHTTPHeaderField:@"Authorization"];
    [manager POST:@"https://travel.knoci.cn/comment/commit" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NewCommentModel* newCommentModel = [NewCommentModel yy_modelWithJSON:responseObject];
        SubNewCommentModel* subNewCommentModel = newCommentModel.data;
        NSLog(@"sub:%@", subNewCommentModel.content);
        NSDictionary* dictionary = [subNewCommentModel yy_modelToJSONObject];
        NSLog(@"dict:%@",dictionary);
                Comment* newComment = [[Comment alloc] initWithDictionary:dictionary];
        NSLog(@"%@", newComment.content);
                [self.commentArray insertObject:newComment atIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
                    [self.articleTableView beginUpdates];
            NSLog(@"%@",self.commentArray);
                    // 插入新增的 Section（索引从 0 开始）
                    NSIndexSet *newSectionIndex = [NSIndexSet indexSetWithIndex:2];
                    [self.articleTableView insertSections:newSectionIndex
                                  withRowAnimation:UITableViewRowAnimationAutomatic]; // 选择动画类型
        
                    [self.articleTableView endUpdates];
            self.inputTextView.text = @"";
                });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1 && indexPath.row == 0) {
        [self replyComment:self.commentArray[indexPath.section - 2] AtSection:indexPath.section - 2];
    } else if (indexPath.section > 1 && indexPath.row != 0) {
        [self replyReply:self.commentArray[indexPath.section - 2].replies[indexPath.row - 1] AtSection:indexPath.section - 2];
    } else {
        [self.inputTextView resignFirstResponder];
    }
}

- (void)replyReply:(Comment*)comment AtSection:(NSInteger)section{
    self.replyedSection = section;
    self.replyedComment = [[Comment alloc] init];
    self.replyedComment = comment;
    NSLog(@"comment:%@ , %@", self.replyedComment, comment);
    [self.inputTextView becomeFirstResponder];
    self.sendButton.tag = 03;
}

- (void)replyComment:(Comment*)comment AtSection:(NSInteger)section{
    self.replyedSection = section;
    self.replyedComment = [[Comment alloc] init];
    self.replyedComment = comment;
    NSLog(@"comment:%@ , %@", self.replyedComment, comment);
    [self.inputTextView becomeFirstResponder];
    self.sendButton.tag = 02;
}

- (void)setTableView {
    self.articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 394, 900) style:UITableViewStyleGrouped];
    self.articleTableView.delegate = self;
    self.articleTableView.dataSource = self;
    self.articleTableView.rowHeight = UITableViewAutomaticDimension;
    self.articleTableView.estimatedRowHeight = 800;
    self.articleTableView.backgroundColor = [UIColor whiteColor];
    self.articleTableView.sectionHeaderHeight = 2;
    self.articleTableView.sectionFooterHeight = 2;
    
    [self.articleTableView registerClass:[ArticleScrollTableViewCell class] forCellReuseIdentifier:@"ArticleScrollTableViewCell"];
    [self.articleTableView registerClass:[ArticleTableViewCell class] forCellReuseIdentifier:@"ArticleTableViewCell"];
    [self.articleTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
    [self.articleTableView registerClass:[ReplyTableViewCell class] forCellReuseIdentifier:@"ReplyTableViewCell"];
    self.articleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.articleTableView];
    [self.articleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 + self.commentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section >= 2) {
        if (self.commentArray[section - 2].replies.count == 0) {
            return 1;
        } else {
            if (self.commentArray[section - 2].isExpand == NO) {
                return MIN(self.commentArray[section - 2].replies.count + 1, 3);
            } else {
                return self.commentArray[section - 2].replies.count + 1;
            }
        }
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section > 1 && self.commentArray[section - 2].replies.count > 2) {
        return 40;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section > 1 && self.commentArray[section - 2].replies.count > 2) {
        UIView* expandView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 394, 40)];
        expandView.tag = section;
        UILabel* expandLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 394, 40)];
        [expandLabel setTextColor:[UIColor lightGrayColor]];
        [expandView addSubview:expandLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expand:)];
        [expandView addGestureRecognizer:tap];
        
        if (self.commentArray[section - 2].isExpand == NO) {
            [expandLabel setText:[NSString stringWithFormat:@"—— 点击展开%ld条评论", self.commentArray[section - 2].replies.count]];
        } else {
            [expandLabel setText:@"—— 点击收起"];
        }
        return expandView;
    }
    return nil;
}

- (void)expand:(UITapGestureRecognizer*)gesture {
    NSInteger section = gesture.view.tag;
    if (section <= 1) return;
    
    NSInteger index = section - 2;
    self.commentArray[index].isExpand = !self.commentArray[index].isExpand;
    
    
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.articleTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ArticleScrollTableViewCell* articleScrollTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ArticleScrollTableViewCell"];
        [articleScrollTableViewCell configureWithImages:self.articleModelDictionary[@"view"]];
        return articleScrollTableViewCell;
    } else if (indexPath.section == 1) {
        ArticleTableViewCell* articleTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ArticleTableViewCell"];
        [articleTableViewCell.timeLabel setText:[self.articleModelDictionary[@"updated_at"] substringToIndex:10]];
        [articleTableViewCell.titleLabel setText:self.articleModelDictionary[@"title"]];
        [articleTableViewCell.articleLabel setText:self.articleModelDictionary[@"content"]];
        return articleTableViewCell;
    } else {
        if (indexPath.row == 0) {
            CommentCell* commentCell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
            [commentCell.nameLabel setText:self.commentArray[indexPath.section - 2].name];
            [commentCell.timeLabel setText:self.commentArray[indexPath.section - 2].time];
            [commentCell.commentTextView setText:self.commentArray[indexPath.section - 2].content];
            [commentCell.nameIcon sd_setImageWithURL:[NSURL URLWithString:self.commentArray[indexPath.section - 2].avatar]];
            for (UIGestureRecognizer *gesture in commentCell.gestureRecognizers) {
                    if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                        [commentCell removeGestureRecognizer:gesture];
                    }
                }

                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
                [commentCell addGestureRecognizer:longPress];
            //        [commentCell.likes setText:[NSString stringWithFormat:@"%ld", self.commentArray[indexPath.section - 2].likes]];
            return  commentCell;
        } else {
            ReplyTableViewCell* replyTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ReplyTableViewCell"];
            Comment* reply = self.commentArray[indexPath.section - 2].replies[indexPath.row - 1];
            if ([reply.replyname isEqual:self.commentArray[indexPath.section - 2].name]) {
                [replyTableViewCell.nameLabel setText:reply.name];
            } else {
                NSString* string = [NSString stringWithFormat:@"%@ > %@",reply.name, reply.replyname];
                [replyTableViewCell.nameLabel setText:string];
            }
            [replyTableViewCell.timeLabel setText:reply.time];
            [replyTableViewCell.commentTextView setText:reply.content];
            [replyTableViewCell.nameIcon sd_setImageWithURL:[NSURL URLWithString:reply.avatar]];
            //        [commentCell.likes setText:[NSString stringWithFormat:@"%ld", self.commentArray[indexPath.section - 2].likes]];
            for (UIGestureRecognizer *gesture in replyTableViewCell.gestureRecognizers) {
                    if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                        [replyTableViewCell removeGestureRecognizer:gesture];
                    }
                }

                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
                [replyTableViewCell addGestureRecognizer:longPress];
            return  replyTableViewCell;
        }
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gestureRecognizer locationInView:self.articleTableView];
        NSIndexPath *indexPath = [self.articleTableView indexPathForRowAtPoint:point];

        if (indexPath) {
            NSLog(@"长按了第 %ld 行", indexPath.row);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作"
                                                                                       message:nil
                                                                                preferredStyle:UIAlertControllerStyleActionSheet];
                        
                        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除"
                                                                               style:UIAlertActionStyleDestructive
                                                                             handler:^(UIAlertAction * _Nonnull action) {
                            if (indexPath.section > 1 && indexPath.row == 0) {
                                [self deleteTopCommentAtIndex:indexPath];
                            } else if (indexPath.section && indexPath.row > 0) {
                                [self deleteReplyAtIndex:indexPath];
                            }
                        }];
                        
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                               style:UIAlertActionStyleCancel
                                                                             handler:nil];
                        
                        [alert addAction:deleteAction];
                        [alert addAction:cancelAction];

                        [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)deleteTopCommentAtIndex:(NSIndexPath*)indexPath {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *cid = self.commentArray[indexPath.section - 2].cid;
    NSString *urlString = [NSString stringWithFormat:@"https://travel.knoci.cn/comment/delete?cid=%@", cid];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求序列化器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置相应序列化器为 AFJSONResponseSerializer，用于将服务器返回的 JSON 数据转换为 NSDictionary 或 NSArray
    NSLog(@"%@", self.commentArray[indexPath.section - 2].cid);
    [manager.requestSerializer setValue:self.authorization forHTTPHeaderField:@"Authorization"];
    [manager POST:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentArray removeObjectAtIndex:indexPath.section - 2];
            [self.articleTableView beginUpdates];
            [self.articleTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.articleTableView endUpdates];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%d",error.code);
        if (error.code == -1011) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                               message:@"很抱歉，你不能删除该评论"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            while (topVC.presentedViewController) {
                topVC = topVC.presentedViewController;
            }
            [topVC presentViewController:alert animated:YES completion:nil];
            });
        }
    }];
}

- (void)deleteReplyAtIndex:(NSIndexPath*)indexPath {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *cid = self.commentArray[indexPath.section - 2].replies[indexPath.row - 1].cid;
    NSString *urlString = [NSString stringWithFormat:@"https://travel.knoci.cn/comment/delete?cid=%@", cid];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求序列化器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置相应序列化器为 AFJSONResponseSerializer，用于将服务器返回的 JSON 数据转换为 NSDictionary 或 NSArray
    [manager.requestSerializer setValue:self.authorization forHTTPHeaderField:@"Authorization"];
    [manager POST:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentArray[indexPath.section - 2].replies removeObjectAtIndex:indexPath.row - 1];
            [self.articleTableView beginUpdates];
            [self.articleTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.articleTableView endUpdates];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%d",error.code);
        if (error.code == -1011) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                               message:@"很抱歉，你不能删除该评论"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    }];
}

- (void)loadNavgationBar {
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    avatarImageView.layer.cornerRadius = 18;
    avatarImageView.layer.masksToBounds = YES;
    [avatarImageView sd_setImageWithURL:self.articleModelDictionary[@"avatar"]];
    avatarImageView.layer.borderWidth = 1.0;
    avatarImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exitButton setImage:[UIImage imageNamed:@"黑返回.jpg"] forState:UIControlStateNormal];
    
    UIView* exitView = [[UIView alloc] init];
    [exitView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel* nameLabel = [[UILabel alloc] init];
    [nameLabel setText:self.articleModelDictionary[@"name"]];
    nameLabel.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:exitView];
    [exitView addSubview:avatarImageView];
    [exitView addSubview:exitButton];
    [exitView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(exitView.mas_left).offset(+120);
        make.top.mas_equalTo(50);
        make.width.mas_equalTo(200);
    }];
    
    [exitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(86);
        make.top.equalTo(self.view.mas_top);
    }];
    
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(exitView.mas_left).offset(+60);
        make.width.top.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(exitView.mas_left).offset(+5);
        make.width.top.mas_equalTo(40);
    }];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
