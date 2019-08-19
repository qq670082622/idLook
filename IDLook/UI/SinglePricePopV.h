//
//  SinglePricePopV.h
//  IDLook
//
//  Created by HYH on 2018/7/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EditPricePopType)
{
    EditPricePopTypeSingle,    //单项报价
    EditPricePopTypeModify     //修改报价
};

@interface SinglePricePopV : UIView
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,copy)void(^confirmBlock)(NSString *content);

-(void)showWithPrice:(NSString*)price withMinPrice:(CGFloat)price1 withMaxPrice:(CGFloat)price2 withEditType:(EditPricePopType)type;

@end
