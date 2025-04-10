//
//  SightsWebViewContollerViewController.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/2.
//

#import <UIKit/UIKit.h>
#import "SightsWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SightsWebViewController : UIViewController

@property (strong, nonatomic, readwrite)NSDictionary* subSightsModelDictionary;
@property (strong, nonatomic, readwrite)SightsWebView* sightsWebView;
@property (strong, nonatomic, readwrite)NSString* url;

@end

NS_ASSUME_NONNULL_END
