//
//  ZSImagePreViewController.h
//  ZSPhotoBrowser
//
//  Created by zuoshen on 2017/8/7.
//  Copyright © 2017年 zuoshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPhotoBrowser.h"

@interface ZSImagePreViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) XLPhotoBrowser* photoBrowser;

+(void)showPreViewController:(id<XLPhotoBrowserDatasource>)delegate currentImageIndex:(NSInteger)currentImageIndex imageCount:(NSUInteger)imageCount;


@end
