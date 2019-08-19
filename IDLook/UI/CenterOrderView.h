//
//  CenterOrderView.h
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterOrderView : UIView
@property(nonatomic,copy)void(^orderClickTypeBlock)(NSInteger type);
@end
