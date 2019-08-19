//
//  PreviewSubVB.h
//  IDLook
//
//  Created by HYH on 2018/7/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewSubVB : UIView

//加载ui
-(void)reloadUIWithArray:(NSArray *)array;

//刷新ui
-(void)refreshUIWithArray:(NSArray*)array withShowBG:(BOOL)show;

@end
