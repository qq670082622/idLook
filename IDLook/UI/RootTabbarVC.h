//
//  RootTabbarVC.h
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTabBarController.h"
@interface RootTabbarVC : MCTabBarController//UITabBarController


/**
 跳转到我的
 @param index 3
 */
-(void)skipMineWithIndex:(NSInteger)index;

@end