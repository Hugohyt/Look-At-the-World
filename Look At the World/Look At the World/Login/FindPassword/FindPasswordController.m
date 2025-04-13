//
//  FindPasswordController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/21.
//

#import "FindPasswordController.h"

@interface FindPasswordController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remainingSeconds;

@property (nonatomic, assign) BOOL loginEmailvalid;
@property (nonatomic, assign) BOOL loginPasswordValid;
@property (nonatomic, assign) BOOL nameValid;
@property (nonatomic, assign) BOOL codeValid;
@property (nonatomic, assign) BOOL rightPasswordValid;

@end

@implementation FindPasswordController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewDidload");
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewModel = [[LoginViewModel alloc] init];
    self.findPasswordView = [[FindPasswordView alloc] init];
    self.findPasswordView.frame = self.view.bounds;
    [self.view addSubview:self.findPasswordView];
    [self SettingFindPasswordView];
    [self.findPasswordView.codeBtn addTarget:self action:@selector(PressCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.findPasswordView.confirmBtn addTarget:self action:@selector(PressConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self.findPasswordView.passwordTextField resignFirstResponder];
    [self.findPasswordView.emailTextField resignFirstResponder];
    [self.findPasswordView.nameTextField resignFirstResponder];
    [self.findPasswordView.codeTextField resignFirstResponder];
    [self.findPasswordView.rightPassTextField resignFirstResponder];
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    // 获得键盘大小
//    NSDictionary *info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.25
                     animations:^{
         self.view.frame = CGRectMake(0, -140, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     } completion:nil];
}

- (void)keyboardWillHidden:(NSNotification *)aNotification {
    [UIView animateWithDuration:0.25
                     animations:^{
         self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     } completion:nil];
}

#pragma mark - 设置控件
-(void) SettingFindPasswordView {
    self.findPasswordView.nameTextField.delegate = self;
    self.findPasswordView.emailTextField.delegate = self;
    self.findPasswordView.codeTextField.delegate = self;
    self.findPasswordView.passwordTextField.delegate = self;
    self.findPasswordView.rightPassTextField.delegate = self;
    
    [self.viewModel addObserver:self forKeyPath:@"internalIsQQEmail" options:NSKeyValueObservingOptionNew context:nil];
    [self.viewModel addObserver:self forKeyPath:@"internalIsQQpassword" options:NSKeyValueObservingOptionNew context:nil];
    
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
    self.findPasswordView.emailTextField.rightView = rightView1;
    self.findPasswordView.emailTextField.rightViewMode = UITextFieldViewModeNever;
    
//    internalIsQQpassword
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
    self.findPasswordView.passwordTextField.rightView = rightView2;
    self.findPasswordView.passwordTextField.rightViewMode = UITextFieldViewModeNever;
    
    UIView* rightView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    rightView3 .backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    UILabel* rightLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 35)];
    rightLabel3.text = @"两次输入密码不一致";
    rightLabel3.font = [UIFont systemFontOfSize:8];
    rightLabel3.numberOfLines = 0;
    rightLabel3.backgroundColor = [UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0];
    rightLabel3.textColor = [UIColor whiteColor];
    rightView3.layer.masksToBounds = YES;
    rightView3.layer.cornerRadius = 17.5;
    [rightView3 addSubview:rightLabel3];
    self.findPasswordView.rightPassTextField.rightView = rightView3;
    self.findPasswordView.rightPassTextField.rightViewMode = UITextFieldViewModeNever;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    if(textField.tag == 102) {
        self.viewModel.emailInputText = textField.text;
    } else if(textField.tag == 104) {
        self.viewModel.passwordInputText = textField.text;
    } else if (textField.tag == 105) {
        if ([textField.text isEqualToString:self.findPasswordView.passwordTextField.text]) {
            self.findPasswordView.rightPassTextField.rightViewMode = UITextFieldViewModeNever;
            self.rightPasswordValid = YES;
        } else {
            self.findPasswordView.rightPassTextField.rightViewMode = UITextFieldViewModeAlways;
            self.rightPasswordValid = NO;
        }
    } else if (textField.tag == 101) {
        self.nameValid = textField.text.length > 0;
    } else if (textField.tag == 103) {
        self.codeValid = textField.text.length > 0;
    }
    self.findPasswordView.confirmBtn.enabled = self.nameValid && self.codeValid && self.rightPasswordValid && self.loginEmailvalid && self.loginPasswordValid;
    NSLog(@"enabled = %d", self.findPasswordView.confirmBtn.enabled);
    if(self.findPasswordView.confirmBtn.enabled) {
        [self.findPasswordView.confirmBtn setBackgroundColor:[UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0]];
    } else {
        [self.findPasswordView.confirmBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    }
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"internalIsQQEmail"]) {
        BOOL isQQEmail = [change[NSKeyValueChangeNewKey] boolValue];
        NSLog(@"第二个结果：%d", isQQEmail);
        self.loginEmailvalid = isQQEmail;
        if (isQQEmail) {
            NSLog(@"不是");
            self.findPasswordView.emailTextField.rightViewMode = UITextFieldViewModeNever;
        } else {
            self.findPasswordView.emailTextField.rightViewMode = UITextFieldViewModeAlways;
        }
    } else if([keyPath isEqualToString:@"internalIsQQpassword"]) {
        BOOL isQQEmail = [change[NSKeyValueChangeNewKey] boolValue];
        NSLog(@"第二个结果：%d", isQQEmail);
        self.loginPasswordValid = isQQEmail;
        if (isQQEmail) {
            NSLog(@"不是");
            self.findPasswordView.passwordTextField.rightViewMode = UITextFieldViewModeNever;
        } else {
            self.findPasswordView.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
        }
    }
    
}

- (void)dealloc
{
    [self.viewModel removeObserver:self forKeyPath:@"internalIsQQpassword"];
    [self.viewModel removeObserver:self forKeyPath:@"internalIsQQEmail"];
}

#pragma mark - postCode
//发送验证码
-(void) PressCodeBtn {
    NSString* codeString = self.findPasswordView.emailTextField.text;
    NSLog(@"codeString:%@", codeString);
    NSDictionary* parameters = @{@"name":self.findPasswordView.nameTextField.text, @"email":self.findPasswordView.emailTextField.text};
    NSLog(@"邮箱姓名比对");
    NSString* urlString = @"https://travel.knoci.cn/user/confirm";
    [self.viewModel PostUrlString:urlString parameters:parameters completion:^(id responseObject, NSError *error) {
        if(error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    [self showAlertWithMessage:errorModel.msg inViewController:self andTag:102];
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
            NoticeModel* notice = [NoticeModel yy_modelWithJSON:responseObject];
            NSLog(@"%@", notice.msg);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.viewModel Email:codeString CodeWithSuccess:^(CodeModel * _Nonnull mainModel) {
                    NSLog(@"开始获取验证码");
                    NSLog(@"%@", [mainModel yy_modelToJSONObject]);
            } failure:^(NSError * _Nonnull error) {
                    NSLog(@"%@", error);
                }];
            });
        }
    }];
    self.findPasswordView.codeBtn.enabled = NO;
    self.remainingSeconds = 60;
    [self updateButtonTitle];
    // 启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [self.findPasswordView.codeBtn setBackgroundColor:[UIColor colorWithRed:135/255.0 green:176/255.0 blue:190/255.0 alpha:1.0]];
    self.findPasswordView.codeBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.findPasswordView.codeBtn.layer.shadowOffset = CGSizeMake(0, 3);
    self.findPasswordView.codeBtn.layer.shadowOpacity = 0.3;
    self.findPasswordView.codeBtn.layer.shadowRadius = 3;
}

- (void)countdown {
    self.remainingSeconds--;
    [self updateButtonTitle];
    if (self.remainingSeconds <= 0) {
        // 倒计时结束，停止定时器，恢复按钮状态
        [self.timer invalidate];
        self.timer = nil;
        self.findPasswordView.codeBtn.enabled = YES;
        [self.findPasswordView.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.findPasswordView.codeBtn setBackgroundColor:[UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0]];
        self.findPasswordView.codeBtn.layer.shadowColor = [UIColor clearColor].CGColor;
    }
}

- (void)updateButtonTitle {
    NSString *title = [NSString stringWithFormat:@"%ld 秒后重新获取", (long)self.remainingSeconds];
    [self.findPasswordView.codeBtn setFont:[UIFont systemFontOfSize:12]];
    [self.findPasswordView.codeBtn setTitle:title forState:UIControlStateDisabled];
}
#pragma mark - postFindPassword
-(void) PressConfirmBtn {
    NSDictionary* parameters = @{@"name":self.findPasswordView.nameTextField.text, @"email":self.findPasswordView.emailTextField.text, @"code":self.findPasswordView.codeTextField.text, @"newpassword":self.findPasswordView.passwordTextField.text};
    NSString* urlString = @"https://travel.knoci.cn/user/reset";
    [self.viewModel PostUrlString:urlString parameters:parameters completion:^(id responseObject, NSError *error) {
        if(error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    [self showAlertWithMessage:errorModel.msg inViewController:self andTag:101];
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
//            NoticeModel* notice = [NoticeModel yy_modelWithJSON:responseObject];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更改成功" message:@"您的密码已经更改，按确定将返回登录界面" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

#pragma mark - 警告输入框
-(void)showAlertWithMessage:(NSString *)message inViewController:(UIViewController *)viewController andTag:(NSInteger) tag {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(tag == 101) {
            self.findPasswordView.nameTextField.text = nil;
            self.findPasswordView.emailTextField.text = nil;
            self.findPasswordView.codeTextField.text = nil;
            self.findPasswordView.passwordTextField.text = nil;
            self.findPasswordView.rightPassTextField.text = nil;
        } else if(tag == 102) {
            self.findPasswordView.nameTextField.text = nil;
            self.findPasswordView.emailTextField.text = nil;
        }
    }];
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.findPasswordView.nameTextField.text = nil;
    self.findPasswordView.emailTextField.text = nil;
    self.findPasswordView.codeTextField.text = nil;
    self.findPasswordView.passwordTextField.text = nil;
    self.findPasswordView.rightPassTextField.text = nil;
    self.findPasswordView.emailTextField.rightViewMode = UITextFieldViewModeNever;
    self.findPasswordView.passwordTextField.rightViewMode = UITextFieldViewModeNever;
    self.findPasswordView.rightPassTextField.rightViewMode = UITextFieldViewModeNever;
}
@end
