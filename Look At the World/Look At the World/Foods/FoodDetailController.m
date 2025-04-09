//
//  FoodDetailController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/31.
//

#import "FoodDetailController.h"

@interface FoodDetailController ()
@property (nonatomic, strong) NSMutableArray* ImageArr;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;

@end

@implementation FoodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.exitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.exitBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 80, 50, 50);
    self.ImageArr = [NSMutableArray array];
    self.detailsView = [[FoodDetailView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40)];
    [self.view addSubview:self.detailsView];
    [self.view addSubview:self.exitBtn];
    [self.exitBtn setImage:[[UIImage imageNamed:@"取消.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.exitBtn addTarget:self action:@selector(PressExit) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_group_t imageLoadGroup = dispatch_group_create();
    for (int i = 1; i < 4; i++) {
        UIImageView* iView = [[UIImageView alloc] init];
        dispatch_group_enter(imageLoadGroup);
        
        NSURL *imageURL = [NSURL URLWithString:self.detailsModel.view[i]];
        [iView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"图片加载失败");
            } else {
                NSLog(@"图片加载成功");
                [self.ImageArr addObject:iView];
            }
            dispatch_group_leave(imageLoadGroup);
        }];
    }
    // 在所有图片加载完成后设置主视图
    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
        [self SettingImageScrollView];
    });
    [self SettingWidget];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleMedium)];
    [self.view addSubview:self.activityIndicator];
    //设置小菊花的frame
    self.activityIndicator.frame= CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, self.detailsView.imageScrollView.frame.size.height/2, 40, 40);
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor grayColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor whiteColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    [self.activityIndicator startAnimating];
}

-(void) PressExit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) SettingWidget {
    self.detailsView.nameLabel.text = self.detailsModel.name;
    self.detailsView.placeLabel.text = self.detailsModel.location;
    self.detailsView.cookBookLabel.text = self.detailsModel.recipe;
    self.detailsView.detailsLabel.text = self.detailsModel.article;
    [self.detailsView layoutIfNeeded];
    CGFloat cookBookY = self.detailsView.cookBookLabel.frame.origin.y;
    CGFloat cookBookHeight = self.detailsView.cookBookLabel.frame.size.height;
    CGFloat height = cookBookY + cookBookHeight + 20;
    NSLog(@"%lf %lf", cookBookY, cookBookHeight);
    self.detailsView.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
}

-(void) SettingImageScrollView {
    for (int i = 0; i < 3; i++) {
        UIImageView* iView = self.ImageArr[i];
        iView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, self.detailsView.imageScrollView.frame.size.height);
        [self.activityIndicator stopAnimating];
        [self.detailsView.imageScrollView addSubview:iView];
        
    }

}
@end
