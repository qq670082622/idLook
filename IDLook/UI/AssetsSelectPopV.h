//
//  AssetsSelectPopV.h
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsSelectPopV : UIView

@property(nonatomic,copy)void(^SelectConditionVBlock)(NSString *content,NSInteger type,NSInteger tag);

@property(nonatomic,copy)void(^hideBlock)(NSInteger type);


-(void)showPopViewWithType:(NSInteger)type withSelect:(NSString*)select;

-(void)hide;

@end
