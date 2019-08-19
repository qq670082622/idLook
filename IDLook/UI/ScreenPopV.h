//
//  ScreenPopV.h
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
//  筛选添加弹出视图 上下弹窗 y过期

#import <UIKit/UIKit.h>

@interface ScreenPopV : UIView

@property(nonatomic,copy)void(^confrimBlock)(NSDictionary *dic);  //搜索的条件内容
@property(nonatomic,strong)NSDictionary *selectDic; //已选中的条件

- (void)showWithType:(NSInteger)type;

@end
