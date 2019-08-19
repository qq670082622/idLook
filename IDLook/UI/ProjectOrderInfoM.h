//
//  ProjectOrderInfoM.h
//  IDLook
//
//  Created by Mr Hu on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ProjectBtnType)
{
    ProjectBtnTypeScheduleAgain=1,    //档期再确认
    ProjectBtnTypeDelectActor,     //删除演员
    ProjectBtnTypeAudition,        //试镜下单
    ProjectBtnTypeLockSchedule,     //锁定档期
    ProjectBtnTypeAcceptPrice,      //接受价格
    ProjectBtnTypeTryVideoPay,      //试镜去支付
    ProjectBtnTypeLockSchedulPay,      //锁档去支付
    ProjectBtnTypeLockSchedulPayLast,  //锁档支付尾款
    ProjectBtnTypeMakeupPay,      //定妆去支付
    ProjectBtnTypeCancel,         //取消
    ProjectBtnTypeTryVideoUrgeAccept,     //试镜催演员接单
    ProjectBtnTypeLockUrgeConfrim,     //锁档催演员确认
    ProjectBtnTypeMakeupUrgeAccept,     //定妆催演员确认
    ProjectBtnTypeContact,        //联系脸探
    ProjectBtnTypeUrgeUpload,      //催上传
    ProjectBtnTypeLookWork,        //查看作品（试镜）
    ProjectBtnTypeConfrimWork,     //确认作品（试镜）
    ProjectBtnTypeAuditAnnunciate,   //试镜通告
    ProjectBtnTypeConfrimArrive,    //确认到场（自备场地）
    ProjectBtnTypeConfrimArriveAgain,    //再次确认到场（自备场地）
    ProjectBtnTypeModifTime,       //试镜修改时间
    ProjectBtnTypeGoAuditRoom,     //进入试镜室
    ProjectBtnTypeConfimFinish,    //试镜确认完成
    ProjectBtnTypeDownloadOnlineAuditionVideo, //下载手机试镜视频
    ProjectBtnTypeMakeup,          //定妆
    ProjectBtnTypeShotAnnunciate,    //拍摄通告
    ProjectBtnTypeModifTimeAndPlace,   //修改时间地点（定妆）
    ProjectBtnTypeModifShotTime,    //修改拍摄日期(锁档)
    ProjectBtnTypeShotFinish,       //拍摄确认完成
    ProjectBtnTypePortraitApply,        //发起肖像授权书
    ProjectBtnTypePortraitLook,      //预览肖像授权书
    ProjectBtnTypePortraitQuickly,    //催签字
    ProjectBtnTypePortraitDownLoad,   //下载肖像授权书
    ProjectBtnTypeMore,          //更多
    
    //订单按钮
    OrderBtnTypeConfrimSchedule,   //确认档期
    OrderBtnTypeNoSchedule,        //无档期
    OrderBtnTypeAccept,            //接单
    OrderBtnTypePortraitSign,      //肖像授权签字
    OrderBtnTypeReject,            //拒单
    OrderBtnTypeUploadVide,        //上传视频
    OrderBtnTypeEnterAuditonRoom, //进入试镜间
    OrderBtnTypeLookAnnunciate,     //查看通告
    OrderBtnTypeLookVideo          //查看视频
};

@interface ProjectOrderInfoM : NSObject

/**
 资源方id
 */
@property (nonatomic,assign) NSInteger actorId;

/**
 资源方信息
 */
@property (nonatomic,strong) NSDictionary *actorInfo;

/**
 询档信息
 */
@property (nonatomic,strong) NSDictionary *askScheduleInfo;

/**
 购买方id
 */
@property (nonatomic,assign) NSInteger buyerId;

/**
 首付款
 */
@property (nonatomic,assign) NSInteger firstPrice;

/**
 定妆信息
 */
@property (nonatomic,strong) NSDictionary *makeupInfo;

/**
 下单时间
 */
@property (nonatomic,copy)NSString  *orderDate;

/**
 订单ID
 */
@property (nonatomic,copy)NSString  *orderId;

/**
 订单状态    ask_schedule:询问档期; try_video: 试镜; lock_schedule:锁定档期; makeup: 定妆; shot:拍摄; author: 授权书; cancel:取消; finished: 完成
 */
@property (nonatomic,copy)NSString  *orderState;

/**
  订单类型 0：询问档期； 1：微出镜； 2：试葩间； 3：试镜订单； 4：拍摄； 5：定妆； 6：授权书； 7：锁定档期； 11：试镜服务',
 */
@property (nonatomic,assign) NSInteger orderType;

/**
 订单类型名称   0：询问档期； 1：微出镜； 2：试葩间； 3：试镜订单； 4：拍摄； 5：定妆； 6：授权书； 7：锁定档期； 11：试镜服务',
 */
@property (nonatomic,copy)NSString  *orderTypeName;

/**
 项目信息
 */
@property (nonatomic,strong) NSDictionary *projectInfo;

/**
 项目脚本信息
 */
@property (nonatomic,strong) NSArray *projectScriptList;


/**
 角色信息
 */
@property (nonatomic,strong) NSDictionary *roleInfo;

/**
 拍摄结束日期
 */
@property (nonatomic,copy)NSString  *shotEnd;

/**
 拍摄开始日期
 */
@property (nonatomic,copy)NSString  *shotStart;

/**
 拍摄信息
 */
@property (nonatomic,strong) NSDictionary *shotInfo;

/**
 拍摄类别
 */
@property (nonatomic,copy)NSString  *shotType;

/**
  订单子状态
 ask_schedule_query:询问档期; ask_schedule_buyerNegoPrice:买方议价; ask_schedule_actorNegoPrice: 演员还价;ask_schedule_acceptActorPrice: 买家接受演员价格;  try_video_wait_actor_upload: 待演员上传作品; try_video_actor_uploaded: 演员已上传作品; try_video_wait_audition: 待开始试镜; try_video_on_audition: 试镜中; pending_pay: 待支付; pending_pay_first: 待支付首款; pending_pay_last: 待支付尾款; pay_done: 已付尾款或全部支付; wait_actor_accept: 待演员确认; actor_accept: 演员接受; actor_reject: 演员拒绝; over_time: 已过期; cancel: 取消; confirm: 买家确认演员到场或作品;finish: 完成;
 */
@property (nonatomic,copy)NSString  *subState;

/*
询档：orderType=0
    1.ask_schedule_query:询问档期 --> actor_accept: 演员接受(已确认档期) --> (可试镜，锁档，档期再确认)
    2.ask_schedule_query:询问档期 --> actor_reject: 演员拒绝(无档期)
    3.ask_schedule_buyerNegoPrice:买方议价 --> actor_reject: 演员拒绝
                                         --> actor_accept: 演员接受
                                         -->ask_schedule_actorNegoPrice: 演员还价
试镜：orderType=3
    1(手机试镜/影棚试镜).pending_pay: 待支付 --> wait_actor_accept: 待演员接单 --> try_video_wait_actor_upload: 待演员上传作品 -->try_video_actor_uploaded: 演员已上传作品
     2(自备场地).pending_pay: 待支付 --> wait_actor_accept: 待演员接单 --> actor_accept: 演员已接单 -->confirm:确认完成 -->finish:完成
    3(在线试镜).pending_pay: 待支付 --> wait_actor_accept: 待演员接单 --> try_video_wait_audition: 待开始试镜 --> try_video_on_audition: 试镜中 -->finish: 完成
锁档：orderType=7
    pending_pay_first: 待支付首款  wait_actor_accept: 待演员接单 -->  pending_pay_last: （已接单）待支付尾款 -->pay_done: 已付尾款或全部支付
                                                        --> actor_reject: 演员拒绝
定妆：orderType=5
    pending_pay: 待支付 -->  wait_actor_accept: 待演员接单 -->actor_accept: 演员已接单
                                                        --> actor_reject: 演员拒绝
拍摄：orderType=4
 
授权书：orderType=6


*/


/**
 订单子状态名称
 */
@property (nonatomic,copy)NSString  *subStateName;

/**
 总价。买方和演员看到的价格不同
 */
@property (nonatomic,assign) NSInteger totalPrice;

/**
 试镜信息
 */
@property (nonatomic,strong) NSDictionary *tryVideoInfo;

-(id)initWithDic:(NSDictionary *)dic;

/**
 项目订单列表，根据订单获取购买方底部按钮的种类
 @param info 订单信息
 @return 按钮种类
 */
-(NSArray*)ProjectGetPurBottomButtonWithOrderInfo:(ProjectOrderInfoM*)info;

/** 
 订单列表，根据订单获取资源方底部按钮的种类
 @param info 订单信息
 @return 按钮种类
 */
-(NSArray*)OrderGetActorBottomButtonWithOrderInfo:(ProjectOrderInfoM*)info;

/**
 获取试镜方式
 @param type 试镜类型
 @return 试镜方式名称
 */
-(NSString*)getAuditionWayWithType:(NSInteger)type;

/**
 根据类型得到定妆类别名称
 @param type 定妆类别
 @return 定妆类别名字
 */
-(NSString*)getMakeupTypeWithType:(NSInteger)type;


/**
 失效原因
 @param statue 订单状态
 @return 失效原因
 */
-(NSString*)getFailureResonWithStatue:(NSString*)statue;

@end

NS_ASSUME_NONNULL_END
