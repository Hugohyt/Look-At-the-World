//
//  LoginView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loginBtn = [[UIButton alloc] init];
        self.registerBtn = [[UIButton alloc] init];
        self.findPasswordBtn = [[UIButton alloc] init];
        self.emailText = [[MyTextField alloc] init];
        self.passwordText = [[MyTextField alloc] init];
        [self SettingWidget];
    }
    return self;
}

-(void) SettingWidget {
    [self addSubview:self.emailText];
    [self addSubview:self.passwordText];
    [self addSubview:self.loginBtn];
    [self addSubview:self.registerBtn];
    [self addSubview:self.findPasswordBtn];
    
    [self.emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(160);
        make.left.mas_offset(60);
        make.right.mas_offset(-60);
        make.height.mas_offset(35);
    }];
    self.emailText.tag = 101;
    [self.emailText updateLeftViewImage:[UIImage imageNamed:@"邮箱.png"]];

    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailText.mas_bottom).mas_offset(40);
        make.left.mas_offset(60);
        make.right.mas_offset(-60);
        make.height.mas_offset(35);
    }];
    self.passwordText.tag = 102;
    self.passwordText.secureTextEntry = YES;
    [self.passwordText updateLeftViewImage:[UIImage imageNamed:@"密码.png"]];

    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordText.mas_bottom).mas_offset(40);
        make.left.mas_offset(80);
        make.right.mas_offset(-80);
        make.height.mas_offset(50);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(self.loginBtn.mas_right);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    
    [self.findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.loginBtn.mas_left);
        make.height.mas_offset(20);
        make.width.mas_offset(80);
    }];
    
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [self.loginBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    self.loginBtn.enabled = NO;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 15;
    
    
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.findPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.findPasswordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.findPasswordBtn setBackgroundColor:[UIColor whiteColor]];
}

@end
