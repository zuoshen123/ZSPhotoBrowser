//
//  ZSImagePreViewController.m
//  ZSPhotoBrowser
//
//  Created by zuoshen on 2017/8/7.
//  Copyright © 2017年 zuoshen. All rights reserved.
//

#import "ZSImagePreViewController.h"
#import <Masonry/Masonry.h>
#import "ZSPresentAnimation.h"
#import "ZSInteractiveTransition.h"
#import "ZSUtils.h"

@interface ZSImagePreViewController ()<XLPhotoBrowserDelegate>

@property(nonatomic,strong) UIImageView* mImage;
@property(nonatomic,strong) UIButton* closeButton;
@property(nonatomic,strong) ZSInteractiveTransition* interactiveTransition;
//用于判断交互手势是否进行中
@property (nonatomic, assign) BOOL interactionInProgress,firstLoad;

@end

@implementation ZSImagePreViewController

+(void)showPreViewController:(id<XLPhotoBrowserDatasource>)delegate currentImageIndex:(NSInteger)currentImageIndex imageCount:(NSUInteger)imageCount{
    ZSImagePreViewController* controller = [[ZSImagePreViewController alloc] init];
    controller.photoBrowser = [[XLPhotoBrowser alloc]initWithFrame:[UIScreen mainScreen].bounds];
    controller.photoBrowser.currentImageIndex = currentImageIndex;
    controller.photoBrowser.imageCount = imageCount;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.photoBrowser.datasource = delegate;
    [[ZSUtils getCurrentVC] presentViewController:controller animated:YES completion:nil];
}

-(instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        _firstLoad = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
    if (_firstLoad) {
        if (_photoBrowser == nil) {
            _photoBrowser = [[XLPhotoBrowser alloc]initWithFrame:[UIScreen mainScreen].bounds];
        }
        _photoBrowser.delegate = self;
        [self.view addSubview:_photoBrowser];
        [_photoBrowser show];
        _firstLoad = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];
//    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _closeButton.frame = CGRectMake(16, 36, 50, 50);
//    [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//    [_closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_closeButton];
    
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
}

-(void)gestureCallbackPhotoBrowser:(XLPhotoBrowser *)browser withGestureState:(BrowserState)state withFactor:(CGFloat)factor{
    
    NSLog(@"BrowserState==%li*****factor== %f ",(long)state,factor);
    if (state == BrowserStateBegin) {
        _interactionInProgress = YES;
        self.interactiveTransition = [ZSInteractiveTransition new];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (state == BrowserStateChange){
//        factor = fminf(fmaxf(factor, 0.0), 0.99);
        [self.interactiveTransition updateInteractiveTransition:0.];
    }else if (state == BrowserStateDone){
        self.interactionInProgress = YES;
        [self.interactiveTransition updateInteractiveTransition:0.99];
        [self.interactiveTransition finishInteractiveTransition];
        self.interactiveTransition = nil;
    }else if (state == BrowserStateCancel){
        _interactionInProgress = NO;
        [self.interactiveTransition cancelInteractiveTransition];
        self.interactiveTransition = nil;
    }
}

-(void)dismissPhotoBrowser:(XLPhotoBrowser *)browser{
    _interactionInProgress = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)close:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    ZSPresentAnimation* present = [[ZSPresentAnimation alloc]init];
    present.isPresent = YES;
    return present;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ZSPresentAnimation new];
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactionInProgress ? _interactiveTransition : nil;
}

@end
