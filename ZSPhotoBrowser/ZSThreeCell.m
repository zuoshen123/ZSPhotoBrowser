//
//  ZSThreeCell.m
//  ZSPhotoBrowser
//
//  Created by zuoshen on 2017/8/7.
//  Copyright © 2017年 zuoshen. All rights reserved.
//

#import "ZSThreeCell.h"
#import <Masonry/Masonry.h>
#import "ZSImagePreViewController.h"
#import <YYWebImage/UIImageView+YYWebImage.h>

@interface ZSThreeCell() <XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>{
    
    UIImageView* image1;
    UIImageView* image2;
    UIImageView* image3;
}

@end

@implementation ZSThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat imageWidth = ([UIScreen mainScreen].bounds.size.width - 48)/3;
        CGFloat imageHeight = imageWidth*9/16;
        
        image1 = [[UIImageView alloc] init];
        image2 = [[UIImageView alloc] init];
        image3 = [[UIImageView alloc] init];
        
        image1.contentMode = UIViewContentModeScaleAspectFill;
        image2.contentMode = UIViewContentModeScaleAspectFill;
        image3.contentMode = UIViewContentModeScaleAspectFill;
        
        image1.clipsToBounds = YES;
        image2.clipsToBounds = YES;
        image3.clipsToBounds = YES;
        
        [self.contentView addSubview:image1];
        [self.contentView addSubview:image2];
        [self.contentView addSubview:image3];
        
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@16);
            make.top.mas_equalTo(@5);
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
            make.bottom.mas_equalTo(-5);
        }];
        [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1.mas_right).offset(8);
            make.top.mas_equalTo(@5);
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
            make.bottom.mas_equalTo(-5);
        }];
        [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image2.mas_right).offset(8);
            make.top.mas_equalTo(@5);
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageHeight);
            make.right.mas_equalTo(-16);
            make.bottom.mas_equalTo(-5);
        }];
        
        image1.userInteractionEnabled = YES;
        image2.userInteractionEnabled = YES;
        image3.userInteractionEnabled = YES;
        
        image1.tag = 1;
        image2.tag = 2;
        image3.tag = 3;
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick:)];
        singleTap.numberOfTapsRequired = 1;
        UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick:)];
        singleTap2.numberOfTapsRequired = 1;
        UITapGestureRecognizer* singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick:)];
        singleTap3.numberOfTapsRequired = 1;
        [image1 addGestureRecognizer:singleTap];
        [image2 addGestureRecognizer:singleTap2];
        [image3 addGestureRecognizer:singleTap3];
    }
    return self;
}

-(void)setImageUrls:(NSString *)url{
    [image1 yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionSetImageWithFadeAnimation];
    [image2 yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionSetImageWithFadeAnimation];
    [image3 yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionSetImageWithFadeAnimation];
}

-(void) singleClick:(UITapGestureRecognizer*) gesture{
    NSInteger index = 0;
    if (gesture.view.tag == 1) {
        index = 0;
    }else if (gesture.view.tag == 2){
        index = 1;
    }else{
        index = 2;
    }
    [ZSImagePreViewController showPreViewController:self currentImageIndex:index imageCount:3];
}

#pragma mark    -   XLPhotoBrowserDatasource

- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    if (index == 0) {
        return image1.image;
    }else if (index == 1){
        return image2.image;
    }else{
        return image3.image;
    }
}

- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index
{
    if (index == 0) {
        return image1;
    }else if (index == 1){
        return image2;
    }else{
        return image3;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
