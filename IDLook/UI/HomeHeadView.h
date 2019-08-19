//
//  HomeHeadView.h
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
// 三个大按钮 模特 演员 群演

#import <UIKit/UIKit.h>

@interface HomeHeadView : UIView
@property(nonatomic,copy)void(^clickTypeBlock)(NSInteger type);
@property(nonatomic,assign)CGFloat headerHeight;
@end

//@interface HomeHeadSubCell : UIView
//@property(nonatomic,assign)NSInteger type;//大图是0。小图是1
//-(void)reloadUIWithDic:(NSDictionary*)dic;
//@end
