//
//  ForwardVC.h
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForwardVC : UIViewController
@property(nonatomic,assign)CGFloat totalMoney;
@property(nonatomic,copy)void(^refreshUI)(void);
@end
