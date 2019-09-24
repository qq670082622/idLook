//
//  UinfoEvaluateView.h
//  IDLook
//
//  Created by Mr Hu on 2019/3/6.
//  Copyright © 2019年 HYH. All rights reserved.
//  个人主页 评价view topV里o评价这一块

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UinfoEvaluateView : UIView
@property(nonatomic,copy)void(^lookAllEvaluate)(void);  //查看全部评价
-(void)reloadUIWithDic:(NSDictionary*)dic withCount:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
