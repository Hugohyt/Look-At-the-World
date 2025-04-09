//
//  FindPasswordController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/21.
//

#import <UIKit/UIKit.h>
#import "FindPasswordView.h"
#import "LoginViewModel.h"
#import "LoginModel.h"
#import "NoticeModel.h"
typedef void (^CheckNameAndEmailCompletion)(BOOL isValid);
NS_ASSUME_NONNULL_BEGIN

@interface FindPasswordController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) FindPasswordView* findPasswordView;
@property (nonatomic, strong) LoginViewModel* viewModel;
@end

NS_ASSUME_NONNULL_END
