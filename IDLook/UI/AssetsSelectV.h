//
//  AssetsSelectV.h
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsSelectV : UIView
@property(nonatomic,copy)void(^AssetsSelectVClick)(NSInteger tag,BOOL isSelect);

-(void)reloadConditWithContent:(NSString*)string withSearchConditionType:(NSInteger)type;

//取消选中状态
-(void)setNormalButtonWithType:(NSInteger)type;


/**
 得到当前选中的button
 @param type 类型
 @return 按钮标题
 */
-(NSString*)getSelectButtonTitle:(NSInteger)type;

@end
