//
//  CenterTitleView.h
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterTitleView : UIView
@property(nonatomic,copy)void(^clickWithIndexBlock)(NSInteger index);
@end
