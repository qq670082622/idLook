//
//  OrderProgM.h
//  IDLook
//
//  Created by HYH on 2018/6/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetialVCM.h"

@interface OrderProgM : NSObject

@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);

@property (nonatomic,strong)NSMutableArray *ds;

-(void)refreshDataWithModel:(OrderModel*)model;

@end

@interface OrderProgStructM :NSObject
@property(nonatomic,copy)NSString *title;    //标题
@property(nonatomic,copy)NSString *content;  //内容
@property(nonatomic,copy)NSString *time;  //订单处理时间
@property(nonatomic,copy)NSString *state;  //订单状态
@property(nonatomic,assign)CGFloat height;   //高度
@property(nonatomic,assign)NSInteger progress;  //当前进度是否是进行中，未进行，还是已经进行    0:未到当前进度   1:当前进度已完成  2:当前进度正在进行
@end
