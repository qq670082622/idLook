//
//  OrderModel.h
//  IDLook
//
//  Created by HYH on 2018/6/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,OrderType)
{
    OrderTypeAll,            //全部
    OrderTypeMirror,        //微出镜订单
    OrderTypeTrial,         //试葩间素材订单
    OrderTypeAudition,      //试镜订单
    OrderTypeShot,          //拍摄订单
    OrderTypeRenewal        //肖像续约订单
};

@interface OrderModel : NSObject

/****
 试镜订单流程 ：   new ->  paied  -> acceptted  -> videouploaded  -> finished
                new ->  paied  -> rejected
 
 拍摄订单流程 ：  new -> acceptted   -> paiedone  -> paiedtwo  -> finished
               new ->  paiedone  -> rejected
 
 已取消：cancel  已拒绝：rejected   超时：overtime
 购买方违约：buydefault  演员违约：actordefault。 档期被买断：noschedule 
 ***/

/**
 订单id
 */
@property(nonatomic,copy)NSString *orderId;

/**
 产品id
 */
@property(nonatomic,copy)NSString *productId;

/**
 订单类型
 */
@property(nonatomic,assign)OrderType ordertype;

/**
 订单类型名称
 */
@property(nonatomic,copy)NSString *ordertypeName;

/**
 项目名称
 */
@property(nonatomic,copy)NSString *projectName;

/**
 项目简介
 */
@property(nonatomic,copy)NSString *projectdesc;

/**
 试镜订单，作品最晚上传时间
 */
@property(nonatomic,copy)NSString *latestworktime;

/**
 品牌
 */
@property(nonatomic,copy)NSString *brand;

/**
 产品
 */
@property(nonatomic,copy)NSString *product;

/**
 订单状态
 */
@property(nonatomic,copy)NSString *orderstate;  //new:新订单  finished ：已完成   rejected：已拒绝   其他单词：进行中     acceptted    rejected  paied

/**
 下单时间
 */
@property(nonatomic,copy)NSString *orderdate;

/**
 购买者id
 */
@property(nonatomic,copy)NSString *buyerid;

/**
 艺人id
 */
@property(nonatomic,copy)NSString *actorid;

/**
 艺人昵称
 */
@property(nonatomic,copy)NSString *actorNick;

/**
 艺人头像
 */
@property(nonatomic,copy)NSString *actorHead;

/**
 需求/画面描述
 */
@property(nonatomic,copy)NSString *demand;

/**
 要求
 */
@property(nonatomic,copy)NSString *requirement;

/**
 画面分镜
 */
@property(nonatomic,copy)NSString *creativeurl;


/////////////////试镜///////////////

/**
 拍摄天数1
 */
@property(nonatomic,assign)NSInteger shootdays;

/**
 拍摄天数2,平面拍摄天数
 */
@property(nonatomic,assign)NSInteger shootdays2;

/**
 拍摄地点
 */
@property(nonatomic,copy)NSString *shootplace;

/**
 预约试镜时间
 */
@property(nonatomic,copy)NSString *datereservation;

/**
 拍摄截止时间
 */
@property(nonatomic,copy)NSString *datereservationend;

/**
 订单价格
 */
@property(nonatomic,copy)NSString *price;

/**
 到手价格
 */
@property(nonatomic,copy)NSString *profit;

/**
 试镜方式
 */
@property(nonatomic,assign)NSInteger auditionType;    //1:自备场地   2:影棚试镜  3:手机快速试镜


/**
 拒单理由
 */
@property(nonatomic,copy)NSString *ordermsg;

/**
 保单号
 */
@property(nonatomic,copy)NSString *policynum;


/////////////////拍摄订单///////////////
/**
 广告类别1
 */
@property(nonatomic,copy)NSString *advType;

/**
 广告类别2，平面广告类别
 */
@property(nonatomic,copy)NSString *advType2;

/**
 预约定装时间
 */
@property(nonatomic,copy)NSString *datemakeup;

/**
 肖像周期
 */
@property(nonatomic,copy)NSString *cycle;

/**
 肖像范围
 */
@property(nonatomic,copy)NSString *region;

/**
 定装费
 */
@property(nonatomic,copy)NSString *makeupprice;

/**
 定角费
 */
@property(nonatomic,copy)NSString *fixedprice;

/**
 资源方定角费
 */
@property(nonatomic,copy)NSString *fixedprofit ;

/**
 管理费
 */
@property(nonatomic,copy)NSString *manageprice;

/**
 保险费
 */
@property(nonatomic,copy)NSString *insuranceprice;

/**
 总价格
 */
@property(nonatomic,copy)NSString *totalprice;

/**
 资源方总价格
 */
@property(nonatomic,copy)NSString *totalprofit ;

/**
 报价内容
 */
@property(nonatomic,copy)NSDictionary *offerInfo;

/**
 拍摄是否报过价
 */
@property(nonatomic,assign)NSInteger ordersubtype;

/**
 定妆类型
 */
@property(nonatomic,assign)NSInteger shotordertype;

/**
 定妆类型价格
 */
@property(nonatomic,copy)NSString *ordertypeprice;

/**
 优惠价格
 */
@property(nonatomic,copy)NSString *freeprice;

/**
 演出费
 */
@property(nonatomic,copy)NSString *showprice;

/**
 购买方类型
 */
@property(nonatomic,assign)NSInteger useridentity;

/**
 档期预约方式 1:付预约金。2:不约档
 */
@property(nonatomic,assign)NSInteger payterms;

/**
 档期预约金价格
 */
@property(nonatomic,copy)NSString *bailprice;

/**
 是否选中
 */
@property(nonatomic,assign)BOOL isChoose;

/**
 是否评价  1:未评价，2:已评价
 */
@property(nonatomic,assign)NSInteger evaluate;

- (id)initWithDic:(NSDictionary *)dic;


/**
 得到试镜方式
 @param type 试镜类型
 @return 试镜方式
 */
-(NSString*)getAuditionWayWithType:(NSInteger)type;

/**
  根据订单状态，订单类型，用户类型得到订单具体状态，
 @param info 订单信息
 @return 具体状态
 */
-(NSString*)getOrderStateWihtOrderInfo:(OrderModel*)info;

@end
