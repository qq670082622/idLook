//
//  PlaceOrderCustomCell.h
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//   下单通用tableviewcell

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

@interface PlaceOrderCustomCell : UITableViewCell
@property(nonatomic,copy)void(^BeginEdit)(void);  //开始编辑
@property(nonatomic,strong)UITextField *textField;
-(void)reloadUIWithModel:(OrderStructM*)model;
@end
