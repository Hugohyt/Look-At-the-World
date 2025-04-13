//
//  ExpandTransitionAnimator.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/31.
//

#import "ExpandTransitionAnimator.h"

@implementation ExpandTransitionAnimator

// 定义动画持续时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

// 实现动画逻辑
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIPageViewController *pageViewController = nil;
       for (UIView *subview in fromVC.view.subviews) {
           if ([subview isKindOfClass:[UIPageViewController class]]) {
               pageViewController = (UIPageViewController *)subview;
               break;
           }
       }
       
       if (pageViewController) {
           // 获取 UIPageViewController 的起始位置和大小
           CGRect startFrame = [fromVC.view convertRect:pageViewController.view.frame toView:containerView];
           
           // 将 toVC 的视图添加到容器视图中，并设置初始状态
           toVC.view.frame = startFrame;
           [containerView addSubview:toVC.view];
           
           // 执行动画，将 toVC 的视图展开到全屏
           [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
               toVC.view.frame = containerView.bounds;
           } completion:^(BOOL finished) {
               // 动画完成后，标记过渡完成
               [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
           }];
       }
}

@end
