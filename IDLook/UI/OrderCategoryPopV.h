//
//  OrderCategoryPopV.h
//  IDLook
//
//  Created by HYH on 2018/6/22.
//  Copyright © 2018年 HYH. All rights reserved.
//   广告类别弹出视图

#import <UIKit/UIKit.h>

@interface OrderCategoryPopV : UIView

@property(nonatomic,copy)void(^typeSelectAction)(NSString *content,NSInteger advType,NSInteger advSubType);


/**
 根据type得到选择的内容
 @param type 类型
 @param selectArray 已选中的内容
 @param isMuilSel  是否多选
 */
-(void)showWithType:(OrderCheckType)type withSelect:(NSArray*)selectArray withMultiSel:(BOOL)isMuilSel withEnableArray:(NSArray*)enableArray;

@end
