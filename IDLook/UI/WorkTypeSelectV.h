//
//  WorkTypeSelectV.h
//  IDLook
//
//  Created by HYH on 2018/5/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkTypeSelectV : UIView
@property(nonatomic,copy)void(^keywordSelectAction)(NSString *content);
-(void)showWithSelectArray:(NSArray*)array withType:(NSInteger)type withTitle:(NSString*)title;
@end
