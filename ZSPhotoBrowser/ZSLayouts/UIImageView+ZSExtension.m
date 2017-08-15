//
//  UIImageView+ZSExtension.m
//  ZSPhotoBrowser
//
//  Created by zuoshen on 2017/8/10.
//  Copyright © 2017年 zuoshen. All rights reserved.
//

#import "UIImageView+ZSExtension.h"
#import "UIImage+XLExtension.h"
#import <objc/runtime.h>

@implementation UIImageView (ZSExtension)

static char OriginalFrame;

- (CGRect)originalFrame
{
    NSValue* value = (NSValue*)objc_getAssociatedObject(self,&OriginalFrame);
    return [value CGRectValue];
}

- (void)setOriginalFrame:(CGRect)originalFrame
{
    objc_setAssociatedObject(self, &OriginalFrame, [NSValue valueWithCGRect:originalFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char IsWhiteState;

- (BOOL)isWhiteState
{
    NSNumber* value = (NSNumber*)objc_getAssociatedObject(self,&IsWhiteState);
    return [value boolValue];
}

static char WhiteLayer;

- (void)setIsWhiteState:(BOOL)isWhiteState
{
    objc_setAssociatedObject(self, &IsWhiteState, [NSNumber numberWithBool:isWhiteState], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (isWhiteState) {
        CALayer* layer = objc_getAssociatedObject(self,&WhiteLayer);
        if (layer == nil) {
            layer = [CALayer layer];
            layer.backgroundColor = [UIColor whiteColor].CGColor;
            layer.frame = self.bounds;
            objc_setAssociatedObject(self, &WhiteLayer, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [self.layer addSublayer:layer];
    }else{
        CALayer* layer = objc_getAssociatedObject(self,&WhiteLayer);
        [layer removeFromSuperlayer];
    }
}

@end
