//
//  MyworksBottomV.h
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyworksBottomV : UIView
@property(nonatomic,strong)UIButton *allBtn;
@property(nonatomic,copy)void(^chooseAllBlock)(BOOL select);
@property(nonatomic,copy)void(^delectBlock)(void);

@end
