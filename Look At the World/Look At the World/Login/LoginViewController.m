//
//  LoginViewController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "SightsViewController.h"
#import "FoodsViewController.h"
#import "BooksViewController.h"
#import "HistoryViewController.h"


@interface LoginViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remainingSeconds;

@property (nonatomic, assign) BOOL loginEmailvalid;
@property (nonatomic, assign) BOOL loginPasswordValid;

@property (nonatomic, assign) BOOL nameValid;
@property (nonatomic, assign) BOOL codeValid;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.applyName = [[UILabel alloc] init];
    self.loginView = [[LoginView alloc] init];
    self.registerView = [[RegisterView alloc] init];
    self.loginViewModel = [[LoginViewModel alloc] init];
    [self ImageSetting];
    [self LabelSetting];
    [self LoginViewSetting];
}

-(void) LabelSetting {
    NSString* text = @"Look At the World";
    self.applyName.font = [UIFont fontWithName:@"Luoguochengmaobixiaoxingjianti" size:42];
    [self.view addSubview:self.applyName];
    self.applyName.text = text;
    
    self.applyName.textAlignment = NSTextAlignmentCenter;
    [self.applyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@80);
        make.top.mas_equalTo(@120);
    }];
}


-(void) ImageSetting {
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录背景图.jpg"]];
    [self.view addSubview:self.backgroundImage];
    
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.width.mas_equalTo(self.view);
        make.height.mas_offset(330);
    }];
    
    self.skipBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.skipBtn];
    [self.skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.skipBtn addTarget:self action:@selector(PressSkip) forControlEvents:UIControlEventTouchUpInside];
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.width.mas_offset(60);
        make.height.mas_offset(35);
        make.right.mas_equalTo(self.view).mas_offset(-20);
    }];
}

-(void) PressSkip {
    NSLog(@"111");
    self.tabbarViewController = [[TabBarViewController alloc] init];

    [self.delegate AddTabBar:self.tabbarViewController];
}

-(void) LoginViewSetting {
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(300);
        make.left.mas_offset(0);
        make.width.equalTo(self.view); // 修正：使用 equalTo 设置宽度等于 self.view
        make.bottom.equalTo(self.view);
    }];
    self.loginView.backgroundColor = [UIColor whiteColor];
    // 视图边缘圆角化
    self.loginView.layer.cornerRadius = 30.0;
    self.loginView.layer.masksToBounds = YES;
    //给登录界面注册KVO监听邮箱是否合法输入
    self.loginView.emailText.delegate = self;
    [self.view addSubview:self.registerView];
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.loginView);
        make.bottom.equalTo(self.loginView.mas_bottom).offset(552);
    }];
    [self.registerView RegisterViewSetting];
    
    self.registerView.backgroundColor = [UIColor whiteColor];
    self.registerView.layer.masksToBounds = YES;
    self.registerView.layer.cornerRadius = 30.0;
    //    self.registerView.hidden = YES;
    [self SettingRightView];
    //监听其余两个
    [self.registerView.nameText addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.registerView.codeText addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    //登录事件
    [self.loginView.loginBtn addTarget:self action:@selector(PressLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registerBtn addTarget:self action:@selector(PressRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    //注册事件
    [self.registerView.registerBtn addTarget:self action:@selector(PressRegisterBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.registerView.codeBtn addTarget:self action:@selector(PressCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.registerView.exitBtn addTarget:self action:@selector(PressExitBtn) forControlEvents:UIControlEventTouchUpInside];
    //忘记密码
    [self.loginView.findPasswordBtn addTarget:self action:@selector(PressFindPasswordBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboard:)];
    //这样设置，不会影响其他控件接收到触摸信息
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil]; // 键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) keyboard:(UITapGestureRecognizer*) tap
{
    [self.loginView.passwordText resignFirstResponder];
    [self.loginView.emailText resignFirstResponder];
    [self.registerView.nameText resignFirstResponder];
    [self.registerView.emailText resignFirstResponder];
    [self.registerView.codeText resignFirstResponder];
    [self.registerView.passwordText resignFirstResponder];
}


- (void)keyboardWasShown:(NSNotification *)aNotification {
    // 获得键盘大小
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.frame = CGRectMake(0, -kbSize.height*5/6, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                     }
                     completion:nil];
}

- (void)keyboardWillHidden:(NSNotification *)aNotification {
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                     }
                     completion:nil];
}

-(void) SettingRightView {
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    rightView.backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    UILabel* rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 35)];
    rightLabel.text = @"请输入正确邮箱号";
    rightLabel.font = [UIFont systemFontOfSize:8];
    rightLabel.numberOfLines = 0;
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    rightLabel.textColor = [UIColor whiteColor];
    rightView.layer.masksToBounds = YES;
    rightView.layer.cornerRadius = 17.5;
    [rightView addSubview:rightLabel];
    self.loginView.emailText.rightView = rightView;
    self.loginView.emailText.rightViewMode = UITextFieldViewModeNever;
    [self.loginViewModel addObserver:self forKeyPath:@"internalIsQQEmail" options:NSKeyValueObservingOptionNew context:nil];//
    
    UIView* rightView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    rightView1.backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    UILabel* rightLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 35)];
    rightLabel1.text = @"请输入正确邮箱号";
    rightLabel1.font = [UIFont systemFontOfSize:8];
    rightLabel1.numberOfLines = 0;
    rightLabel1.backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    rightLabel1.textColor = [UIColor whiteColor];
    rightView1.layer.masksToBounds = YES;
    rightView1.layer.cornerRadius = 17.5;
    [rightView1 addSubview:rightLabel1];
    self.registerView.emailText.delegate = self;
    self.registerView.emailText.rightView = rightView1;
    self.registerView.emailText.rightViewMode = UITextFieldViewModeNever;
    
//    internalIsQQpassword
    [self.loginViewModel addObserver:self forKeyPath:@"internalIsQQpassword" options:NSKeyValueObservingOptionNew context:nil];
    UIView* rightView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    rightView2 .backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    UILabel* rightLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 35)];
    rightLabel2.text = @"密码长度限制6-20位";
    rightLabel2.font = [UIFont systemFontOfSize:8];
    rightLabel2.numberOfLines = 0;
    rightLabel2.backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    rightLabel2.textColor = [UIColor whiteColor];
    rightView2.layer.masksToBounds = YES;
    rightView2.layer.cornerRadius = 17.5;
    [rightView2 addSubview:rightLabel2];
    self.loginView.passwordText.delegate = self;
    self.loginView.passwordText.rightView = rightView2;
    self.loginView.passwordText.rightViewMode = UITextFieldViewModeNever;
    
    UIView* rightView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    rightView3 .backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    UILabel* rightLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 35)];
    rightLabel3.text = @"密码长度限制6-20位";
    rightLabel3.font = [UIFont systemFontOfSize:8];
    rightLabel3.numberOfLines = 0;
    rightLabel3.backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    rightLabel3.textColor = [UIColor whiteColor];
    rightView3.layer.masksToBounds = YES;
    rightView3.layer.cornerRadius = 17.5;
    [rightView3 addSubview:rightLabel3];
    self.registerView.passwordText.delegate = self;
    self.registerView.passwordText.rightView = rightView3;
    self.registerView.passwordText.rightViewMode = UITextFieldViewModeNever;
    
    self.registerView.nameText.delegate = self;
    self.registerView.codeText.delegate = self;
}

//忘记密码
-(void) PressFindPasswordBtn {
    // 检查 self.findPasswordController 是否已经初始化
        if (!self.findPasswordController) {
            self.findPasswordController = [[FindPasswordController alloc] init];
        }
        // 检查 self.loginView 和 self.registerView 是否存在
        if (self.loginView && self.registerView) {
            [self presentViewController:self.findPasswordController animated:YES completion:^{
                // 清空登录视图的文本框内容和设置 rightViewMode
                if (self.loginView.emailText) {
                    self.loginView.emailText.text = nil;
                    self.loginView.emailText.rightViewMode = UITextFieldViewModeNever;
                }
                if (self.loginView.passwordText) {
                    self.loginView.passwordText.text = nil;
                    self.loginView.passwordText.rightViewMode = UITextFieldViewModeNever;
                }
            }];
        }
}
#pragma mark - LoginView
-(void) PressLoginBtn {
    // 处理登录按钮点击事件
    NSLog(@"113");
    NSDictionary* parameters = @{@"email":self.loginView.emailText.text, @"password":self.loginView.passwordText.text };
    NSLog(@"%@", parameters);
    NSString* urlString = @"https://travel.knoci.cn/user/login";
    [self.loginViewModel PostUrlString:urlString parameters:parameters completion:^(id responseObject, NSError *error) {
        if(error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    [self showAlertWithMessage:errorModel.msg inViewController:self];
                    NSLog(@"服务器返回错误码: %ld，错误信息: %@", (long)errorModel.code, errorModel.msg);
                }
            } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {
                // server throw exception
                NSLog(@"服务器抛出异常，请稍后重试");
            } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
                // network error
                NSLog(@"网络连接错误，请检查网络设置");
            } else {
                // 其他未知错误
                NSLog(@"发生未知错误: %@", error.localizedDescription);
            }
        } else {
            LoginModel* registerModel = [LoginModel yy_modelWithJSON:responseObject];
            NSLog(@"%@", registerModel.msg);
            self.tabbarViewController = [[TabBarViewController alloc] init];
            [self.delegate AddTabBar:self.tabbarViewController];
        }
    }];
}

-(void) PressRegisterBtn {
    [UIView animateWithDuration:0.8 animations:^{
        [self.registerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.loginView.mas_bottom); // 修正：使用 equalTo 设置顶部对齐
        }];
        [self.view layoutIfNeeded]; // 移动到动画块内，确保在动画过程中更新布局
    } completion:^(BOOL finished) {
        if (finished) {
            self.loginView.emailText.text = nil;
            self.loginView.passwordText.text = nil;
            self.loginView.emailText.rightViewMode = UITextFieldViewModeNever;
            self.loginView.passwordText.rightViewMode = UITextFieldViewModeNever;
            self.registerView.emailText.rightViewMode = UITextFieldViewModeNever;
            self.registerView.passwordText.rightViewMode = UITextFieldViewModeNever;
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField.tag == 101 || textField.tag == 202) {
        textField.rightViewMode = UITextFieldViewModeNever;
    }
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    if(textField.tag == 101 || textField.tag == 202) {
        NSLog(@"给他");
        self.loginViewModel.emailInputText = textField.text;
    } else if (textField.tag == 102 || textField.tag == 203) {
        self.loginViewModel.passwordInputText = textField.text;
    } else if (textField.tag == 201) {
        self.nameValid = textField.text.length > 0;
    } else if (textField.tag == 204) {
        self.codeValid = textField.text.length > 0;
    }
    self.registerView.registerBtn.enabled = self.loginEmailvalid && self.loginPasswordValid && self.nameValid && self.codeValid;
    
    if(self.registerView.registerBtn.enabled) {
        [self.registerView.registerBtn setBackgroundColor:[UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0]];
    } else {
        [self.registerView.registerBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    }
}

#pragma mark - postCode
//发送验证码
-(void) PressCodeBtn {
    NSString* codeString = self.registerView.emailText.text;
    NSLog(@"codeString:%@", codeString);
    [self.loginViewModel Email:codeString CodeWithSuccess:^(CodeModel * _Nonnull mainModel) {
        NSLog(@"%@", [mainModel yy_modelToJSONObject]);
        } failure:^(NSError * _Nonnull error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    [self showAlertWithMessage:errorModel.msg inViewController:self];
                    NSLog(@"服务器返回错误码: %ld，错误信息: %@", (long)errorModel.code, errorModel.msg);
                }
            } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {
                // server throw exception
                NSLog(@"服务器抛出异常，请稍后重试");
            } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
                // network error
                NSLog(@"网络连接错误，请检查网络设置");
            } else {
                // 其他未知错误
                NSLog(@"发生未知错误: %@", error.localizedDescription);
            }
        }];
    self.registerView.codeBtn.enabled = NO;
    self.remainingSeconds = 60;
    [self updateButtonTitle];
    // 启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [self.registerView.codeBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    self.registerView.codeBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.registerView.codeBtn.layer.shadowOffset = CGSizeMake(0, 3);
    self.registerView.codeBtn.layer.shadowOpacity = 0.3;
    self.registerView.codeBtn.layer.shadowRadius = 3;
}

- (void)countdown {
    self.remainingSeconds--;
    [self updateButtonTitle];
    if (self.remainingSeconds <= 0) {
        // 倒计时结束，停止定时器，恢复按钮状态
        [self.timer invalidate];
        self.timer = nil;
        self.registerView.codeBtn.enabled = YES;
        [self.registerView.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.registerView.codeBtn setBackgroundColor:[UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0]];
        self.registerView.codeBtn.layer.shadowColor = [UIColor clearColor].CGColor;
    }
}

- (void)updateButtonTitle {
    NSString *title = [NSString stringWithFormat:@"%ld 秒后重新获取", (long)self.remainingSeconds];
    [self.registerView.codeBtn setFont:[UIFont systemFontOfSize:12]];
    [self.registerView.codeBtn setTitle:title forState:UIControlStateDisabled];
    
}

#pragma mark - RegisterView

//注册账号
-(void) PressRegisterBtn1 {
    NSDictionary* parameters = @{@"name":self.registerView.nameText.text, @"email":self.registerView.emailText.text, @"password":self.registerView.passwordText.text ,@"avatar":@"https://avatars.githubusercontent.com/u/129078194",@"code":self.registerView.codeText.text};
    NSLog(@"%@", parameters);
    NSString* urlString = @"https://travel.knoci.cn/user/register";
    [self.loginViewModel PostUrlString:urlString parameters:parameters completion:^(id responseObject, NSError *error) {
        if(error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    [self showAlertWithMessage:errorModel.msg inViewController:self];
                    NSLog(@"服务器返回错误码: %ld，错误信息: %@", (long)errorModel.code, errorModel.msg);
                }
            } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {
                // server throw exception
                NSLog(@"服务器抛出异常，请稍后重试");
            } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
                // network error
                NSLog(@"网络连接错误，请检查网络设置");
            } else {
                // 其他未知错误
                NSLog(@"发生未知错误: %@", error.localizedDescription);
            }
        } else {
            LoginModel* loginModel = [LoginModel yy_modelWithJSON:responseObject];
            NSLog(@"%@", loginModel);
            self.tabbarViewController = [[TabBarViewController alloc] init];
            [self.delegate AddTabBar:self.tabbarViewController];
        }
    } ];
}

-(void) PressExitBtn {
    [UIView animateWithDuration:0.8 animations:^{
        NSLog(@"退出");
        [self.registerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.loginView.mas_bottom).offset(552); // 修正：使用 equalTo 设置顶部对齐
        }];
        [self.view layoutIfNeeded]; // 移动到动画块内，确保在动画过程中更新布局
    }completion:^(BOOL finished) {
        if (finished) {
            self.registerView.nameText.text = nil;
            self.registerView.emailText.text = nil;
            self.registerView.codeText.text = nil;
            self.registerView.passwordText.text = nil;
            self.loginView.emailText.rightViewMode = UITextFieldViewModeNever;
            self.loginView.passwordText.rightViewMode = UITextFieldViewModeNever;
            self.registerView.emailText.rightViewMode = UITextFieldViewModeNever;
            self.registerView.passwordText.rightViewMode = UITextFieldViewModeNever;
        }
    }];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    NSLog(@"NO");
    
    if ([keyPath isEqualToString:@"internalIsQQEmail"]) {
        BOOL isQQEmail = [change[NSKeyValueChangeNewKey] boolValue];
        NSLog(@"第二个结果：%d", isQQEmail);
        self.loginEmailvalid = isQQEmail;
        if (isQQEmail) {
            NSLog(@"不是");
            self.loginView.emailText.rightViewMode = UITextFieldViewModeNever;
            self.registerView.emailText.rightViewMode = UITextFieldViewModeNever;
        } else {
            self.loginView.emailText.rightViewMode = UITextFieldViewModeAlways;
            self.registerView.emailText.rightViewMode = UITextFieldViewModeAlways;
        }
    } else if([keyPath isEqualToString:@"internalIsQQpassword"]) {
        BOOL isQQEmail = [change[NSKeyValueChangeNewKey] boolValue];
        NSLog(@"第二个结果：%d", isQQEmail);
        self.loginPasswordValid = isQQEmail;
        if (isQQEmail) {
            NSLog(@"不是");
            self.loginView.passwordText.rightViewMode = UITextFieldViewModeNever;
            self.registerView.passwordText.rightViewMode = UITextFieldViewModeNever;
        } else {
            self.loginView.passwordText.rightViewMode = UITextFieldViewModeAlways;
            self.registerView.passwordText.rightViewMode = UITextFieldViewModeAlways;
        }
    }
    self.loginView.loginBtn.enabled = self.loginEmailvalid && self.loginPasswordValid;
    
    NSLog(@"name = %d, code = %d", self.nameValid, self.codeValid);
    if(self.loginView.loginBtn.enabled) {
        [self.loginView.loginBtn setBackgroundColor:[UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0]];
    } else {
        [self.loginView.loginBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    }
    
}

-(void) dealloc {
    [self.loginViewModel removeObserver:self forKeyPath:@"internalIsQQEmail"];
//    [self.loginView.emailText removeObserver:self forKeyPath:@"text"];
    [self.loginViewModel removeObserver:self forKeyPath:@"internalIsQQpassword"];
    [self.registerView.nameText removeObserver:self forKeyPath:@"text"];
    [self.registerView.codeText removeObserver:self forKeyPath:@"text"];
 }
#pragma mark - 警告输入框
-(void)showAlertWithMessage:(NSString *)message inViewController:(UIViewController *)viewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.loginView.emailText.text = nil;
        self.loginView.passwordText.text = nil;
        self.registerView.emailText.text = nil;
        self.registerView.nameText.text = nil;
        self.registerView.codeText.text = nil;
        self.registerView.passwordText.text = nil;
    }];
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}
@end
