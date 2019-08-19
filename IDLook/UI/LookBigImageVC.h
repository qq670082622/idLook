//
//  LookBigImageVC.h
//  IDLook
//
//  Created by HYH on 2018/6/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookBigImageVC : UIViewController

@property(nonatomic,assign)BOOL isShowDown;  //是否显示下载按钮
@property(nonatomic,copy)void(^downPhotoBlock)(NSInteger index);   //下载图片回掉

- (void)showWithImageArray:(NSArray *)array       //图片组（包括缩略图url和大图url）
               curImgIndex:(NSInteger)index       //当前imageV的序号(0开始)
                   AbsRect:(CGRect)rect;          //当前需要显示的绝对坐标

@end
