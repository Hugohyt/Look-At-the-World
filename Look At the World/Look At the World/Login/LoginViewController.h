//
//  LoginViewController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/13.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "MyTextField.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "LoginViewModel.h"
#import "TabBarViewController.h"
#import "FindPasswordController.h"


@protocol LoginViewDelegate <NSObject>

-(void) AddTabBar: (UITabBarController*_Nonnull) tb;

@end
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) UILabel* applyName;
@property (nonatomic, strong) LoginView* loginView;
@property (nonatomic, strong) RegisterView* registerView;
@property (nonatomic, strong) UIImageView* backgroundImage;
@property (nonatomic, strong) UIButton* skipBtn;
@property (nonatomic, strong) LoginViewModel* loginViewModel;
@property(nonatomic, assign) id<LoginViewDelegate> delegate;
@property (nonatomic, strong) TabBarViewController* tabbarViewController;
@property (nonatomic, strong) FindPasswordController* findPasswordController;
@property (nonatomic, strong) UIAlertController* alertController;
@end

NS_ASSUME_NONNULL_END
