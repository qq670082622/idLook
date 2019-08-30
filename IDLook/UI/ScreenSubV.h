//
//  ScreenSubV.h
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
// 左侧弹窗 subView

#import <UIKit/UIKit.h>
#import "ScreenPopVCM.h"

@interface ScreenSubV : UIView
/**
 选中的条件
 */
@property(nonatomic,strong)NSMutableArray *selectArray;

@property (nonatomic,strong)UITextField *minTextF;
@property (nonatomic,strong)UITextField *maxTextF;

-(void)reloadUIWithDic:(NSDictionary*)dic withSelect:(NSString*)select;

/**
 所有按钮取消选中状态
 */
-(void)allcCancleSelect;

@end
