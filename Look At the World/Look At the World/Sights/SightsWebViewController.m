//
//  SightsWebViewContollerViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/2.
//

#import "SightsWebViewController.h"
#import "WKWebView+AFNetworking.h"
#import "Masonry/Masonry.h"

@interface SightsWebViewController ()

@end

@implementation SightsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"黑返回.jpg"] forState:UIControlStateNormal];
    exitButton.frame = CGRectMake(0, 60, 20, 20);
    [exitButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:exitButton];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadWebView {
    self.sightsWebView = [[SightsWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.sightsWebView];
    NSLog(@"art:%@", self.subSightsModelDictionary[@"article"]);
    NSLog(@"%@",self.url);
    if (self.url) {
        NSLog(@"%@",self.url);
        NSURL* url = [NSURL URLWithString:self.url];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [self.sightsWebView.sightsWebView loadRequest:request];
        return;
    }
    NSURL* url = [NSURL URLWithString:self.subSightsModelDictionary[@"article"]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.sightsWebView.sightsWebView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
