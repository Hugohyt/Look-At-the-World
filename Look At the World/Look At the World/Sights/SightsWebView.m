//
//  SightsWebView.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/2.
//

#import "SightsWebView.h"

@implementation SightsWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.sightsWebView = [[WKWebView alloc] initWithFrame:frame];
    [self addSubview:self.sightsWebView];
    
    return self;
}


@end
