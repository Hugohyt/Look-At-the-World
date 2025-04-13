//
//  FindPasswordView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/21.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface FindPasswordView : UIView
@property (nonatomic, strong) MyTextField* nameTextField;
@property (nonatomic, strong) MyTextField* emailTextField;
@property (nonatomic, strong) MyTextField* codeTextField;
@property (nonatomic, strong) MyTextField* passwordTextField;
@property (nonatomic, strong) MyTextField* rightPassTextField;
@property (nonatomic, strong) UIButton* codeBtn;
@property (nonatomic, strong) UIButton* confirmBtn;
@property (nonatomic, strong) UILabel* appNameLabel;
@end

NS_ASSUME_NONNULL_END
