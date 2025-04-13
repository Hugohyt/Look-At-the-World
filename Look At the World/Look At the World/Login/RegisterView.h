//
//  RegisterView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "MyTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface RegisterView : UIView
@property (nonatomic, strong) MyTextField* emailText;
@property (nonatomic, strong) MyTextField* passwordText;
@property (nonatomic, strong) MyTextField* nameText;
@property (nonatomic, strong) MyTextField* codeText;
@property (nonatomic, strong) UIButton* codeBtn;
@property (nonatomic, strong) UIButton* registerBtn;
@property (nonatomic, strong) UIButton* exitBtn;

-(void) RegisterViewSetting;

@end

NS_ASSUME_NONNULL_END
