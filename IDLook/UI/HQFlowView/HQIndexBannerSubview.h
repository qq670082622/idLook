
//
//  HQIndexBannerSubview.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

/******************************
 
 可以根据自己的需要继承HQIndexBannerSubview
 
 ******************************/

#import <UIKit/UIKit.h>
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"
@interface HQIndexBannerSubview : UIView

/**
 *  主图
 */
@property (nonatomic, strong) FLAnimatedImageView *mainImageView;

/**
 *  阴影
 */
@property (nonatomic, strong) UIImageView *iconImage;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, copy) void (^didSelectCellBlock)(NSInteger tag, HQIndexBannerSubview *cell);

/**
 设置子控件frame,继承后要重写
 
 @param superViewBounds <#superViewBounds description#>
 */
- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds;



@end
