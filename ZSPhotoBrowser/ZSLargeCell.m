//
//  ZSLargeCell.m
//  ZSPhotoBrowser
//
//  Created by zuoshen on 2017/8/7.
//  Copyright © 2017年 zuoshen. All rights reserved.
//

#import "ZSLargeCell.h"
#import "XLPhotoBrowser.h"
#import <Masonry/Masonry.h>
#import "ZSImagePreViewController.h"
#import <YYWebImage/UIImageView+YYWebImage.h>

@interface ZSLargeCell()<XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>{
    
    UIImageView* mImage;
    UITapGestureRecognizer* singleTap;
}

@end

@implementation ZSLargeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        mImage = [[UIImageView alloc] init];
        mImage.contentMode = UIViewContentModeScaleAspectFill;
        mImage.clipsToBounds = YES;
        [self.contentView addSubview:mImage];
        mImage.userInteractionEnabled = YES;
        CGFloat height = ([UIScreen mainScreen].bounds.size.width-32)*9/16;
        [mImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@16);
            make.top.mas_equalTo(@5);
            make.right.mas_equalTo(-16);
            make.bottom.mas_equalTo(-5);
            make.height.mas_equalTo(height);
        }];
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick)];
        singleTap.numberOfTapsRequired = 1;
        [mImage addGestureRecognizer:singleTap];
    }
    return self;
}

-(void)setImageUrl:(NSString *)url{
    [mImage yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionSetImageWithFadeAnimation];
}

-(void) singleClick{
//    // 快速创建并进入浏览模式
//    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:0 imageCount:1 datasource:self];
//    
//    // 设置长按手势弹出的地步ActionSheet数据,不实现此方法则没有长按手势
////    [browser setActionSheetWithTitle:@"这是一个类似微信/微博的图片浏览器组件" delegate:self cancelButtonTitle:nil deleteButtonTitle:@"删除" otherButtonTitles:@"发送给朋友",@"保存图片",@"收藏",@"投诉",nil];
//    
//    // 自定义pageControl的一些属性
//    browser.pageDotColor = [UIColor purpleColor]; ///< 此属性针对动画样式的pagecontrol无效
//    browser.currentPageDotColor = [UIColor greenColor];
//    browser.pageControlStyle = XLPhotoBrowserPageControlStyleClassic;///< 修改底部pagecontrol的样式为系统样式,默认是弹性动画的样式
    
    [ZSImagePreViewController showPreViewController:self currentImageIndex:0 imageCount:1];
}

#pragma mark    -   XLPhotoBrowserDatasource

- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return mImage.image;
}

- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index
{
    return mImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
