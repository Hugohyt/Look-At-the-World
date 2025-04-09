//
//  RegisterView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import "RegisterView.h"

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.emailText = [[MyTextField alloc] init];
        self.nameText = [[MyTextField alloc] init];
        self.passwordText = [[MyTextField alloc] init];
        self.codeText = [[MyTextField alloc] init];
        self.registerBtn = [[UIButton alloc] init];
        self.codeBtn = [[UIButton alloc] init];
        self.exitBtn = [[UIButton alloc] init];
    }
    return self;
}

-(void) RegisterViewSetting {
    [self addSubview:self.nameText];
    [self addSubview:self.emailText];
    [self addSubview:self.passwordText];
    [self addSubview:self.codeText];
    [self addSubview:self.codeBtn];
    [self addSubview:self.registerBtn];
    [self addSubview:self.exitBtn];
    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(60);
        make.left.mas_offset(60);
        make.right.mas_offset(-60);
        make.height.mas_offset(35);
    }];
    self.nameText.tag = 201;
    [self.nameText updateLeftViewImage:[UIImage imageNamed:@"姓名.png"]];
    
    [self.emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameText.mas_bottom).mas_offset(40);
        make.left.mas_offset(60);
        make.right.mas_offset(-60);
        make.height.mas_offset(35);
    }];
    self.emailText.tag = 202;
    [self.emailText updateLeftViewImage:[UIImage imageNamed:@"邮箱.png"]];
    
    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailText.mas_bottom).mas_offset(40);
        make.left.mas_offset(60);
        make.right.mas_offset(-60);
        make.height.mas_offset(35);
    }];
    self.passwordText.secureTextEntry = YES;
    self.passwordText.tag = 203;
    [self.passwordText updateLeftViewImage:[UIImage imageNamed:@"密码.png"]];
    
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordText.mas_bottom).mas_offset(40);
        make.left.mas_offset(60);
        make.right.mas_offset(-180);
        make.height.mas_offset(35);
    }];
    self.codeText.tag = 204;
    [self.codeText updateLeftViewImage:[UIImage imageNamed:@"验证码.png"]];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeText.mas_top);
        make.left.mas_equalTo(self.codeText.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.nameText.mas_right);
        make.height.mas_offset(35);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeText.mas_bottom).mas_offset(40);
        make.left.mas_offset(80);
        make.right.mas_offset(-80);
        make.height.mas_offset(50);
    }];

    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerBtn.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(self.registerBtn.mas_right);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeBtn setBackgroundColor:[UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0]];
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 5.0;
    
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1.0]];
    [self.registerBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [self.registerBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    self.registerBtn.enabled = NO;
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 15.0;
    
    [self.exitBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.exitBtn setBackgroundColor:[UIColor whiteColor]];
}

@end

