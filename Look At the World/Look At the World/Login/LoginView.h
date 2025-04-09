//
//  LoginView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "MyTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView
@property (nonatomic, strong) MyTextField* emailText;
@property (nonatomic, strong) MyTextField* passwordText;
@property (nonatomic, strong) UIButton* loginBtn;
@property (nonatomic, strong) UIButton* registerBtn;
@property (nonatomic, strong) UIButton* findPasswordBtn;

@end

NS_ASSUME_NONNULL_END
