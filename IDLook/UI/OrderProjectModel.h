//
//  OrderProjectModel.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

typedef NS_ENUM(NSInteger,OrderStateType)   //订单状态
{
    OrderStateTypeAll,            //全部
    OrderStateTypeConfirm,        //待确认
    OrderStateTypeGoing,          //进行中
    OrderStateTypeFinished,       //已完成
    OrderStateTypeFailure         //已失效
};

@interface OrderProjectModel : NSObject

/****
 试镜订单流程 ：   new ->  paied  -> acceptted  -> videouploaded  -> finished
 new ->  paied  -> rejected
 
 拍摄订单流程 ：  new ->  paiedone  -> acceptted  -> paiedtwo  -> finished
 new ->  paiedone  -> rejected
 ***/

/**
 项目id
 */
@property(nonatomic,copy)NSString *projectid;

/**
 项目名称
 */
@property(nonatomic,copy)NSString *name;

/**
 项目类型。 1：试镜。  2：拍摄
 */
@property(nonatomic,assign)NSInteger type;

/**
 项目脚本url串 ，|分割
 */
@property(nonatomic,copy)NSString *url;

/**
 项目简介
 */
@property(nonatomic,copy)NSString *desc;

/**
 试镜项目，作品最晚上传时间
 */
@property(nonatomic,copy)NSString *auditionend;

/**
 拍摄城市
 */
@property(nonatomic,copy)NSString *city;

/**
 拍摄项目，拍摄周期
 */
@property(nonatomic,copy)NSString *shotcycle;

/**
 拍摄项目，拍摄范围
 */
@property(nonatomic,copy)NSString *shotregion;

/**
 拍摄天数
 */
@property(nonatomic,assign)NSInteger auditiondays;

/**
 开始拍摄日期
 */
@property(nonatomic,copy)NSString *start;

/**
 结束拍摄日期
 */
@property(nonatomic,copy)NSString *end;

/**
 订单类别
 */
@property(nonatomic,strong)NSMutableArray *orderlist;

/**
 用户类型
 */
@property(nonatomic,assign)NSInteger useridentity;

/**
 订单状态  0:全部 1:待确认 2:进行中 3:已完成  4:已失效
 */
@property(nonatomic,assign)OrderStateType ordeState;

/**
 是否支付过服务费。0:没有
 */
@property(nonatomic,assign)NSInteger documentarystatus;

/**
 脚本图片
 */
@property(nonatomic,strong)NSArray *img;

/**
 脚本视频
 */
@property(nonatomic,strong)NSArray *vdo;

/**
 是否可以评论  , 1可以评价，0不能评价
 */
@property(nonatomic,assign)NSInteger isevaluate;

/**
 总评价数
 */
@property(nonatomic,assign)NSInteger allevaluate;


/**
 是否选中
 */
@property(nonatomic,assign)BOOL isChoose;

/**
 消息列表订单模型，消息专用
 */
@property(nonatomic,strong)OrderModel *orderModel;

/**
 解析数据
 @param dic 字典
 @return 数据模型
 */
- (id)initWithDic:(NSDictionary *)dic;

@end

