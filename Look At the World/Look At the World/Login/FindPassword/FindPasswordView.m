//
//  FindPasswordView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/21.
//

#import "FindPasswordView.h"

@interface FindPasswordView ()

@end

@implementation FindPasswordView

//@property (nonatomic, strong) MyTextField* nameTextField;
//@property (nonatomic, strong) MyTextField* emailTextField;
//@property (nonatomic, strong) MyTextField* codeTextField;
//@property (nonatomic, strong) MyTextField* passwordTextField;
//@property (nonatomic, strong) MyTextField* rightPassTextField;
//@property (nonatomic, strong) UIButton* codeBtn;
//@property (nonatomic, strong) UIButton* confirmBtn;
//@property (nonatomic, strong) UILabel* appNameLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameTextField = [[MyTextField alloc] init];
        self.emailTextField = [[MyTextField alloc] init];
        self.codeTextField = [[MyTextField alloc] init];
        self.passwordTextField = [[MyTextField alloc] init];
        self.rightPassTextField = [[MyTextField alloc] init];
        self.appNameLabel = [[UILabel alloc] init];
        self.codeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self addSubview:self.nameTextField];
        [self addSubview:self.emailTextField];
        [self addSubview:self.codeTextField];
        [self addSubview:self.passwordTextField];
        [self addSubview:self.rightPassTextField];
        [self addSubview:self.appNameLabel];
        [self addSubview:self.codeBtn];
        [self addSubview:self.confirmBtn];
        
        [self SettingWidget];
    }
    return self;
}

-(void) SettingWidget {
    [self.confirmBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    self.confirmBtn.enabled = NO;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 15.0;
    
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeBtn setBackgroundColor:[UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0]];
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 5.0;
    
    [self.nameTextField updateLeftViewImage:[UIImage imageNamed:@"姓名.png"]];
    [self.emailTextField updateLeftViewImage:[UIImage imageNamed:@"邮箱.png"]];
    [self.codeTextField updateLeftViewImage:[UIImage imageNamed:@"验证码.png"]];
    [self.passwordTextField updateLeftViewImage:[UIImage imageNamed:@"密码.png"]];
    [self.rightPassTextField updateLeftViewImage:[UIImage imageNamed:@"密码.png"]];
    
    self.nameTextField.tag = 101;
    self.emailTextField.tag = 102;
    self.codeTextField.tag = 103;
    self.passwordTextField.tag = 104;
    self.rightPassTextField.tag = 105;
    
    self.passwordTextField.secureTextEntry = YES;
    self.rightPassTextField.secureTextEntry = YES;
}

- (void)layoutSubviews {
    // 使用 Masonry 进行布局
//    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(60);
//        make.top.equalTo(self).offset(300);
//        make.right.mas_offset(-60);
//        make.height.mas_equalTo(35);
//    }];
//       
//    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(60);
//        make.top.equalTo(self.nameTextField.mas_bottom).offset(15);
//        make.right.mas_offset(-60);
//        make.height.mas_equalTo(35);
//    }];
//       
//    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(60);
//        make.top.equalTo(self.emailTextField.mas_bottom).offset(15);
//        make.right.mas_offset(-180);
//        make.height.mas_equalTo(35);
//    }];
//    
//    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.codeTextField.mas_right).offset(10);
//        make.top.equalTo(self.emailTextField.mas_bottom).offset(15);
//        make.right.mas_offset(-60);
//        make.height.mas_equalTo(35);
//    }];
//       
//    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(60);
//        make.top.equalTo(self.codeTextField.mas_bottom).offset(15);
//        make.right.mas_offset(-60);
//        make.height.mas_equalTo(35);
//    }];
//       
//    [self.rightPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(60);
//        make.top.equalTo(self.passwordTextField.mas_bottom).offset(15);
//        make.right.mas_offset(-60);
//        make.height.mas_equalTo(35);
//    }];
//       
//    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(50);
//        make.top.equalTo(self).offset(170);
//        make.width.mas_equalTo(293);
//        make.height.mas_equalTo(70);
//    }];
//       
//    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.rightPassTextField.mas_bottom).offset(15);
//        make.left.mas_offset(80);
//        make.right.mas_offset(-80);
//        make.height.mas_offset(50);
//    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(60);
        make.top.equalTo(self).offset(200);
        make.right.mas_offset(-60);
        make.height.mas_equalTo(35);
    }];
       
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(60);
        make.top.equalTo(self.nameTextField.mas_bottom).offset(30);
        make.right.mas_offset(-60);
        make.height.mas_equalTo(35);
    }];
       
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(60);
        make.top.equalTo(self.emailTextField.mas_bottom).offset(30);
        make.right.mas_offset(-180);
        make.height.mas_equalTo(35);
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeTextField.mas_right).offset(10);
        make.top.equalTo(self.emailTextField.mas_bottom).offset(30);
        make.right.mas_offset(-60);
        make.height.mas_equalTo(35);
    }];
       
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(60);
        make.top.equalTo(self.codeTextField.mas_bottom).offset(30);
        make.right.mas_offset(-60);
        make.height.mas_equalTo(35);
    }];
       
    [self.rightPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(60);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(30);
        make.right.mas_offset(-60);
        make.height.mas_equalTo(35);
    }];
       
    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(50);
        make.top.equalTo(self).offset(170);
        make.width.mas_equalTo(293);
        make.height.mas_equalTo(70);
    }];
       
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightPassTextField.mas_bottom).offset(30);
        make.left.mas_offset(80);
        make.right.mas_offset(-80);
        make.height.mas_offset(50);
    }];
}



@end
