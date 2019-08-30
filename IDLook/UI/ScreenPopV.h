//
//  ScreenPopV.h
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
//  左右弹窗superView

#import <UIKit/UIKit.h>

@interface ScreenPopV : UIView

@property(nonatomic,copy)void(^confrimBlock)(NSDictionary *dic);  //搜索的条件内容
@property(nonatomic,strong)NSDictionary *selectDic; //已选中的条件

- (void)showWithType:(NSInteger)type;

@end
