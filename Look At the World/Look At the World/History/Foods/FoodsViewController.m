//
//  FoodsViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "FoodsViewController.h"

@interface FoodsViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    //翻页视图控制器对象
    UIPageViewController * _pageViewControl;
    //数据源数组
    NSMutableArray * _dataArray;
}
@property (nonatomic, strong) NSMutableArray* imageArr;
@property (nonatomic, strong) NSArray* detailsArr;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;

@end

@implementation FoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id managerpost = [ManagerPost sharedManager];
    LoginSubModel* personal = [managerpost getModel];
    NSLog(@"name = %@", personal.name);
    self.imageArr = [NSMutableArray array];
    self.detailsArr = [NSArray array];
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleMedium)];
    [self.view addSubview:self.activityIndicator];
    //设置小菊花的frame
    self.activityIndicator.frame= CGRectMake(self.view.frame.size.width/2 - 30, self.view.frame.size.height/2 - 30, 60, 60);
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor grayColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor whiteColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    [self.activityIndicator startAnimating];
    id manager = [ManagerGet sharedManager];
    NSString* url = @"https://travel.knoci.cn/foods/list";
    [manager GetRequestWithURL:url completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
            if(error) {
                if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                        // server error
                    NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                    NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                    if (errorModel) {
                        
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
                self.listModel = [FoodListModel yy_modelWithJSON:responseObject];
                NSLog(@"%@", self.listModel.msg);
                self.detailsArr = self.listModel.data;
                NSLog(@"%d", [self.detailsArr[1] isKindOfClass:[NSDictionary class]]);
                for(int i = 0; i < 8; i++) {
                    [self.imageArr addObject:self.detailsArr[i][@"view"][0]];
                }
                // 在主线程中更新 UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self SettingPageViewController];
                });
                NSLog(@"%@", self.imageArr);
            }
    }];

}

-(void) SettingPageViewController {
    _pageViewControl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:@{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMax), UIPageViewControllerOptionInterPageSpacingKey:@10}];
    _pageViewControl.view.frame = CGRectMake(20, 100, 353, 642);
    //将pageController下边两个角变为圆角
    CGRect rect = _pageViewControl.view.bounds;
    // 创建一个 UIBezierPath，只对底部两个角进行圆角处理
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    // 创建一个 CAShapeLayer
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    // 将 CAShapeLayer 设置为 UIImageView 的 mask
    _pageViewControl.view.layer.mask = maskLayer;
    _pageViewControl.dataSource = self;
    _pageViewControl.delegate = self;
    ModelViewController * model = [ModelViewController creatWithDictionary:self.detailsArr[0]];
    [_pageViewControl setViewControllers:@[model] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    _pageViewControl.doubleSided = NO;
    _pageViewControl.view.clipsToBounds = YES;
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_pageViewControl.view addGestureRecognizer:gesture];
    _dataArray = [[NSMutableArray alloc] init];
    [_dataArray addObject:model];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageViewControl.view];
    [self.activityIndicator stopAnimating];
}

- (UIPageViewControllerSpineLocation) pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    return UIPageViewControllerSpineLocationMin;
}

// 处理点击手势的方法
- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    NSLog(@"Tap gesture detected!");
    // 在这里可以添加你需要执行的逻辑
    // 获取当前显示的视图控制器
    UIViewController *currentViewController = _pageViewControl.viewControllers.firstObject;
     //查找当前视图控制器在 dataArray 中的索引
    NSInteger currentPageIndex = [_dataArray indexOfObject:currentViewController];
    FoodDetailController* details = [[FoodDetailController alloc] init];
    details.modalPresentationStyle = UIModalPresentationFullScreen;
    details.detailsModel = [FoodDetailModel yy_modelWithDictionary: self.detailsArr[currentPageIndex]];
//    details.transitioningDelegate = self;
    [self presentViewController:details animated:YES completion:nil];
}


// 返回自定义转场动画对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[ExpandTransitionAnimator alloc] init];
}


//翻页控制器进行向前翻页动作 这个数据源方法返回的视图控制器为要显示视图的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    int index = (int)[_dataArray indexOfObject:viewController];
    if (index == 0) {
        return nil;
    } else {
        return _dataArray[index - 1];
    }
}

//翻页控制器进行向后翻页动作 这个数据源方法返回的视图控制器为要显示视图的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int index = (int)[_dataArray indexOfObject:viewController];
    if (index == 7) {
        return nil;
    } else {
        if (_dataArray.count - 1 >= (index + 1)) {
            return _dataArray[index + 1];
        } else {
            NSLog(@"OK");
            ModelViewController * model = [ModelViewController creatWithDictionary:self.detailsArr[index + 1]];
            [_dataArray addObject:model];
            return model;
        }
    }
}

//设置分页控制器的分页数
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 8;
}

//设置初始的分页点
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}
@end
