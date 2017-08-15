//
//  ZSPresentAnimation.m
//  ZSPhotoBrowser
//
//  Created by zuoshen on 2017/8/9.
//  Copyright © 2017年 zuoshen. All rights reserved.
//

#import "ZSPresentAnimation.h"

@implementation ZSPresentAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    [toVC beginAppearanceTransition:YES animated:YES];
    
    if(self.isPresent){
        [self presentViewControllerAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self dismissViewControllerAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
    
    [fromVC beginAppearanceTransition:NO animated:YES];
}

-(void)presentViewControllerAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    toView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[transitionContext containerView] addSubview:toView];
    CATransform3D t1 = CATransform3DIdentity;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 0.95);
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [fromView.layer setTransform:t1];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [fromView.layer setTransform:CATransform3DIdentity];
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }];
    
}


-(void)dismissViewControllerAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
//    UIView * snap = [toView snapshotViewAfterScreenUpdates:YES];
    UIView * snap = [[UIView alloc] initWithFrame:fromView.bounds];
    snap.backgroundColor = [UIColor clearColor];
    CATransform3D t1 = CATransform3DIdentity;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 0.95);
    [[transitionContext containerView] insertSubview:snap belowSubview:fromView];
    [UIView animateWithDuration:0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [toView.layer setTransform:t1];
        [snap.layer setTransform:t1];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [toView.layer setTransform:CATransform3DIdentity];
            [snap.layer setTransform:CATransform3DIdentity];
            
        } completion:^(BOOL finished) {
            [snap removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
    
}

@end
