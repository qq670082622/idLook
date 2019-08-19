//
//  ScreenSliderA.h
//  YuAi
//
//  Created by HYH on 2017/11/22.
//  Copyright © 2017年 wsz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenSliderA : UIView
@property(nonatomic,copy)void(^ScreeSliderAClick)(NSInteger index);
@property(nonatomic,strong)NSArray *typeViewArray;

@end
