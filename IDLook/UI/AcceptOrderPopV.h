//
//  AcceptOrderPopV.h
//  IDLook
//
//  Created by HYH on 2018/7/13.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcceptOrderPopV : UIView
@property(nonatomic,copy)void(^acceptOrder)(void);

-(void)show;

@end
