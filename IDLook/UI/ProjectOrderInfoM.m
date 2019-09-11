//
//  ProjectOrderInfoM.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderInfoM.h"

@implementation ProjectOrderInfoM

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self = [ProjectOrderInfoM yy_modelWithDictionary:dic];
        
        [self setStateTitle];
    }
    return self;
}
//订单cell和项目cell共用
-(void)setStateTitle
{
    if (self.orderType==0) {  //询档订单
        if ([self.subState isEqualToString:@"ask_schedule_query"]) {
            self.subStateName=@"未确认档期";
        }
        else if([self.subState isEqualToString:@"actor_accept"])
        {
            self.subStateName=@"已确认档期";
        }
        else if([self.subState isEqualToString:@"actor_reject"])
        {
            self.subStateName=@"已拒绝";
        }
        else if([self.subState isEqualToString:@"ask_schedule_buyerNegoPrice"])
        {
            self.subStateName=@"买方议价";
        }
        else if([self.subState isEqualToString:@"ask_schedule_actorNegoPrice"])
        {
            self.subStateName=@"演员还价";
        }
        else if([self.subState isEqualToString:@"ask_schedule_acceptActorPrice"])
        {
            self.subStateName=@"买家同意价格";
        }
        else
        {
            self.subStateName=@"已失效";
        }
        self.orderTypeName=@"询问档期订单";
    }
    else if (self.orderType==3)  //试镜订单
    {
        if([self.subState isEqualToString:@"pending_pay"])
        {
            self.subStateName=@"等待支付";
        }
        else if([self.subState isEqualToString:@"wait_actor_accept"])
        {
            self.subStateName=@"待演员接单";
        }
        else if([self.subState isEqualToString:@"actor_accept"])
        {
            self.subStateName=@"等待试镜";
            UIButton *auditionBtn = [[UIApplication sharedApplication].keyWindow viewWithTag:336699];
            if (auditionBtn.hidden==NO) {
                self.subStateName=@"试镜中";
            }
        }
        else if([self.subState isEqualToString:@"try_video_wait_actor_upload"])
        {
            self.subStateName=@"待上传视频";
        }
        else if([self.subState isEqualToString:@"try_video_actor_uploaded"])
        {
            self.subStateName=@"已上传作品";
        }
        else if([self.subState isEqualToString:@"try_video_wait_audition"])
        {
            self.subStateName=@"等待试镜";
        }
        else if([self.subState isEqualToString:@"try_video_on_audition"])
        {
            self.subStateName=@"试镜中";
        }
        else if([self.subState isEqualToString:@"finish"])
        {
            self.subStateName=@"已完成";
        }
        else if([self.subState isEqualToString:@"confirm"])
        {
            self.subStateName=@"等待确认完成";
        }
        else
        {
            self.subStateName=@"已失效";
        }
        self.orderTypeName=@"试镜订单";
    }
    else if (self.orderType==7)  //锁档订单
    {
        if([self.subState isEqualToString:@"pending_pay_first"])
        {
            self.subStateName=@"待支付首款";
        }
        else if([self.subState isEqualToString:@"wait_actor_accept"])
        {
            self.subStateName=@"待演员确认";
        }
        else if([self.subState isEqualToString:@"actor_accept"])
        {
            self.subStateName=@"演员已确认";
        }
        else if([self.subState isEqualToString:@"pending_pay_last"])
        {
            self.subStateName=@"待支付尾款";
        }
        else if([self.subState isEqualToString:@"pay_done"])
        {
            self.subStateName=@"拍摄中";
        }
        else if([self.subState isEqualToString:@"actor_reject"])
        {
            self.subStateName=@"已失效";
        }
        else if([self.subState isEqualToString:@"finish"])
        {
            self.subStateName=@"拍摄完成";
        }
        else
        {
            self.subStateName=@"已失效";
        }
        self.orderTypeName=@"拍摄订单";
    }
    else if (self.orderType==5)  //定妆订单
    {
        if([self.subState isEqualToString:@"pending_pay"])
        {
            self.subStateName=@"等待支付";
        }
        else if([self.subState isEqualToString:@"wait_actor_accept"])
        {
            self.subStateName=@"待演员确认";
        }
        else if([self.subState isEqualToString:@"actor_accept"])
        {
            self.subStateName=@"演员已接单";
        }
        else if([self.subState isEqualToString:@"actor_reject"])
        {
            self.subStateName=@"已失效";
        }
        else if([self.subState isEqualToString:@"finish"])
        {
            self.subStateName=@"已完成";
        }
        else
        {
            self.subStateName=@"已失效";
        }
        self.orderTypeName=@"定妆订单";

    }
    else if (self.orderType==4)  //拍摄订单
    {
        if([self.subState isEqualToString:@"pending_pay_first"])
        {
            self.subStateName=@"待支付首款";
        }
        else if([self.subState isEqualToString:@"wait_actor_accept"])
        {
            self.subStateName=@"待演员确认";
        }
        else if([self.subState isEqualToString:@"actor_accept"])
        {
            self.subStateName=@"演员已确认";
        }
        else if([self.subState isEqualToString:@"pending_pay_last"])
        {
            self.subStateName=@"待支付尾款";
        }
        else if([self.subState isEqualToString:@"pay_done"])
        {
            self.subStateName=@"拍摄中";
        }
        else if([self.subState isEqualToString:@"actor_reject"])
        {
            self.subStateName=@"已失效";
        }
        else if([self.subState isEqualToString:@"finish"])
        {
            self.subStateName=@"拍摄完成";
        }
        else
        {
            self.subStateName=@"已失效";
        }
        self.orderTypeName=@"拍摄订单";
    }
    else if (self.orderType==6)  //授权书订单
    {
        if([self.subState isEqualToString:@"wait_admin_audit"])
        {
            self.subStateName=@"等待脸探审核";
        }
        else if([self.subState isEqualToString:@"wait_actor_author"])
        {
           self.subStateName=@"等待演员签字";
        }
        else if([self.subState isEqualToString:@"admin_audit_failure"])
        {
            self.subStateName=@"审核未通过";
        }
        else if([self.subState isEqualToString:@"finish"])
        {
             self.subStateName=@"演员已签字";
        }else if([self.subState isEqualToString:@"cancel"])
        {
            self.subStateName=@"已取消";
        }
        self.orderTypeName=@"授权书订单";
    }
}


/**
 项目订单列表，根据订单获取购买方底部按钮的种类
 @param info 订单信息
 @return 按钮种类
 */
-(NSArray*)ProjectGetPurBottomButtonWithOrderInfo:(ProjectOrderInfoM*)info
{
    NSArray *array;
    
    if (info.orderType==0) {  //询档订单
        if ([info.subState isEqualToString:@"ask_schedule_query"]) {
            array=@[@{@"title":@"档期再确认",@"width":@(80),@"type":@(ProjectBtnTypeScheduleAgain)},
                    @{@"title":@"删除演员",@"width":@(68),@"type":@(ProjectBtnTypeDelectActor)}];
        }
        else if([info.subState isEqualToString:@"actor_accept"])
        {
            BOOL lockSchedule = [(NSNumber*)safeObjectForKey(info.askScheduleInfo, @"lockSchedule") boolValue];
            if (lockSchedule==YES) {
                array=@[@{@"title":@"档期再确认",@"width":@(80),@"type":@(ProjectBtnTypeScheduleAgain)},
                        @{@"title":@"试镜下单",@"width":@(68),@"type":@(ProjectBtnTypeAudition)}];
            }
            else
            {
                array=@[@{@"title":@"档期再确认",@"width":@(80),@"type":@(ProjectBtnTypeScheduleAgain)},
                        @{@"title":@"试镜下单",@"width":@(68),@"type":@(ProjectBtnTypeAudition)},
                        @{@"title":@"锁定档期",@"width":@(68),@"type":@(ProjectBtnTypeLockSchedule)},
                        @{@"title":@"删除演员",@"width":@(68),@"type":@(ProjectBtnTypeDelectActor)}];
            }
        }
        else if([info.subState isEqualToString:@"actor_reject"])
        {
            array=@[@{@"title":@"档期再确认",@"width":@(80),@"type":@(ProjectBtnTypeScheduleAgain)},
                    @{@"title":@"删除演员",@"width":@(68),@"type":@(ProjectBtnTypeDelectActor)}];
        }
        else if([info.subState isEqualToString:@"ask_schedule_buyerNegoPrice"])
        {
            array=@[
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)},
                    @{@"title":@"删除演员",@"width":@(68),@"type":@(ProjectBtnTypeDelectActor)}];
        }
        else if([info.subState isEqualToString:@"ask_schedule_actorNegoPrice"])
        {
            array=@[@{@"title":@"接受价格",@"width":@(68),@"type":@(ProjectBtnTypeAcceptPrice)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)},
                    @{@"title":@"删除演员",@"width":@(68),@"type":@(ProjectBtnTypeDelectActor)}];

        }
        else if([info.subState isEqualToString:@"ask_schedule_acceptActorPrice"])
        {
            BOOL lockSchedule = [(NSNumber*)safeObjectForKey(info.askScheduleInfo, @"lockSchedule") boolValue];
            if (lockSchedule==YES) {
                array=@[@{@"title":@"档期再确认",@"width":@(80),@"type":@(ProjectBtnTypeScheduleAgain)},
                        @{@"title":@"试镜下单",@"width":@(68),@"type":@(ProjectBtnTypeAudition)}];
            }
            else
            {
                array=@[@{@"title":@"档期再确认",@"width":@(80),@"type":@(ProjectBtnTypeScheduleAgain)},
                        @{@"title":@"试镜下单",@"width":@(68),@"type":@(ProjectBtnTypeAudition)},
                        @{@"title":@"锁定档期",@"width":@(68),@"type":@(ProjectBtnTypeLockSchedule)},
                        @{@"title":@"删除演员",@"width":@(68),@"type":@(ProjectBtnTypeDelectActor)}];
            }
        }
        
    }
    else if (info.orderType==3)  //试镜订单
    {
        
        if([info.subState isEqualToString:@"pending_pay"])
        {
            array=@[@{@"title":@"去支付",@"width":@(56),@"type":@(ProjectBtnTypeTryVideoPay)},
                    @{@"title":@"取消",@"width":@(44),@"type":@(ProjectBtnTypeCancel)}];
        }
        else if([info.subState isEqualToString:@"wait_actor_accept"])
        {
            array=@[@{@"title":@"催接单",@"width":@(56),@"type":@(ProjectBtnTypeTryVideoUrgeAccept)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"actor_accept"])
        {
            NSInteger auditionMode =  [info.tryVideoInfo[@"auditionMode"] integerValue];
            if (auditionMode==1) {  //自备场地
                array=@[@{@"title":@"试镜通告",@"width":@(68),@"type":@(ProjectBtnTypeAuditAnnunciate)},
                        @{@"title":@"确认到场",@"width":@(68),@"type":@(ProjectBtnTypeConfrimArrive)},
                        @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
            }
            if (auditionMode==4) {  //在线试镜
                array=@[
//                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)},
                      @{@"title":@"修改时间",@"width":@(68),@"type":@(ProjectBtnTypeModifTime)},
                      @{@"title":@"进入试镜室",@"width":@(80),@"type":@(ProjectBtnTypeGoAuditRoom)},
                        @{@"title":@"确认完成",@"width":@(68),@"type":@(ProjectBtnTypeConfimFinish)},
                        ];
            }
        }
        else if([info.subState isEqualToString:@"try_video_wait_actor_upload"])
        {
            array=@[@{@"title":@"催上传",@"width":@(56),@"type":@(ProjectBtnTypeUrgeUpload)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"try_video_actor_uploaded"])
        {
            array=@[@{@"title":@"查看",@"width":@(44),@"type":@(ProjectBtnTypeLookWork)},
                    @{@"title":@"确认作品",@"width":@(68),@"type":@(ProjectBtnTypeConfrimWork)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"try_video_wait_audition"])
        {
            array=@[@{@"title":@"修改时间",@"width":@(68),@"type":@(ProjectBtnTypeModifTime)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"try_video_on_audition"])
        {
            array=@[@{@"title":@"进入试镜室",@"width":@(80),@"type":@(ProjectBtnTypeGoAuditRoom)},
                   // @{@"title":@"确认完成",@"width":@(68),@"type":@(ProjectBtnTypeConfimFinish)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"confirm"])
        {
            array=@[@{@"title":@"确认完成",@"width":@(68),@"type":@(ProjectBtnTypeConfrimArriveAgain)}];
        }
        else if([info.subState isEqualToString:@"finish"])
        {
             NSInteger auditionMode =  [info.tryVideoInfo[@"auditionMode"] integerValue];
            if (auditionMode==3) {//手机试镜
                array=@[
                       // @{@"title":@"下载",@"width":@(44),@"type":@(ProjectBtnTypeDownloadOnlineAuditionVideo)},
                        @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}
                        ];
            }
        }
    }
    else if (info.orderType==7)  //锁档订单
    {
        if([info.subState isEqualToString:@"pending_pay_first"])
        {
            array=@[@{@"title":@"去支付",@"width":@(56),@"type":@(ProjectBtnTypeLockSchedulPay)},
                    @{@"title":@"取消",@"width":@(44),@"type":@(ProjectBtnTypeCancel)}];
        }
        else if([info.subState isEqualToString:@"wait_actor_accept"])
        {
            array=@[@{@"title":@"催确认",@"width":@(56),@"type":@(ProjectBtnTypeLockUrgeConfrim)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"actor_accept"])
        {
            array=@[@{@"title":@"定妆下单",@"width":@(68),@"type":@(ProjectBtnTypeMakeup)},
                    @{@"title":@"支付尾款",@"width":@(68),@"type":@(ProjectBtnTypeLockSchedulPayLast)},
                    @{@"title":@"拍摄通告",@"width":@(68),@"type":@(ProjectBtnTypeShotAnnunciate)},
                    @{@"title":@"修改拍摄日期",@"width":@(85),@"type":@(ProjectBtnTypeModifShotTime)}];
        }
        else if([info.subState isEqualToString:@"pending_pay_last"])
        {
            array=@[@{@"title":@"定妆下单",@"width":@(68),@"type":@(ProjectBtnTypeMakeup)},
                    @{@"title":@"支付尾款",@"width":@(68),@"type":@(ProjectBtnTypeLockSchedulPayLast)},
                    @{@"title":@"拍摄通告",@"width":@(68),@"type":@(ProjectBtnTypeShotAnnunciate)},
                    @{@"title":@"修改拍摄日期",@"width":@(85),@"type":@(ProjectBtnTypeModifShotTime)}];
        }
        else if([info.subState isEqualToString:@"pay_done"])
        {
            array=@[@{@"title":@"确认完成",@"width":@(68),@"type":@(ProjectBtnTypeShotFinish)}];
        }
        else if([info.subState isEqualToString:@"actor_reject"])
        {
        }
        else if([info.subState isEqualToString:@"finish"])
        {
            
        }
    }
    else if (info.orderType==5)  //定妆订单
    {
        if([info.subState isEqualToString:@"pending_pay"])
        {
            array=@[@{@"title":@"去支付",@"width":@(56),@"type":@(ProjectBtnTypeMakeupPay)},
                    @{@"title":@"取消",@"width":@(44),@"type":@(ProjectBtnTypeCancel)}];
        }
        else if([info.subState isEqualToString:@"wait_actor_accept"])
        {
            array=@[@{@"title":@"催确认",@"width":@(56),@"type":@(ProjectBtnTypeMakeupUrgeAccept)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"actor_accept"])
        {
            array=@[@{@"title":@"修改时间地点",@"width":@(92),@"type":@(ProjectBtnTypeModifTimeAndPlace)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"actor_reject"])
        {
            array=@[@{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"finish"])
        {
            
        }
    }
    else if (info.orderType==4)  //拍摄订单
    {
        if([info.subState isEqualToString:@"pay_done"])
        {
            array=@[@{@"title":@"确认完成",@"width":@(68),@"type":@(ProjectBtnTypeShotFinish)}];
        }
        else if([info.subState isEqualToString:@"finish"])
        {
            array=@[@{@"title":@"肖像授权书",@"width":@(92),@"type":@(ProjectBtnTypePortraitApply)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
    }
    else if (info.orderType==6)  //授权书订单
    {
        if([info.subState isEqualToString:@"wait_admin_audit"])
        {
            array=@[@{@"title":@"预览",@"width":@(44),@"type":@(ProjectBtnTypePortraitLook)},
                    @{@"title":@"取消",@"width":@(44),@"type":@(ProjectBtnTypePortraitCancel)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        } else if([info.subState isEqualToString:@"admin_audit_failure"])
        {
            array=@[@{@"title":@"重填授权书",@"width":@(92),@"type":@(ProjectBtnTypePortraitApply)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"wait_actor_author"])
        {
            array=@[@{@"title":@"催签字",@"width":@(56),@"type":@(ProjectBtnTypePortraitQuickly)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}];
        }
        else if([info.subState isEqualToString:@"finish"])
        {
            array=@[
                    @{@"title":@"下载",@"width":@(44),@"type":@(ProjectBtnTypePortraitDownLoad)},
                    @{@"title":@"查看",@"width":@(44),@"type":@(ProjectBtnTypePortraitLook)},
                    @{@"title":@"联系脸探",@"width":@(68),@"type":@(ProjectBtnTypeContact)}
                     ];
        }
    }
    
    return array;
}

/**
 订单列表，根据订单获取资源方底部按钮的种类
 @param info 订单信息
 @return 按钮种类
 */
-(NSArray*)OrderGetActorBottomButtonWithOrderInfo:(ProjectOrderInfoM*)info
{
    NSArray *array;
   
    if ([info.subState isEqualToString:@"ask_schedule_query"]) {
        array=@[@{@"title":@"确认档期",@"width":@(68),@"type":@(OrderBtnTypeConfrimSchedule)},
                @{@"title":@"无档期",@"width":@(56),@"type":@(OrderBtnTypeNoSchedule)}];
    }
    else if ([info.subState isEqualToString:@"wait_actor_accept"])
    {
        array=@[@{@"title":@"接单",@"width":@(44),@"type":@(OrderBtnTypeAccept)},
                @{@"title":@"拒单",@"width":@(44),@"type":@(OrderBtnTypeReject)}];
    }
    else if ([info.subState isEqualToString:@"try_video_wait_actor_upload"])
    {
        array=@[@{@"title":@"上传视频",@"width":@(68),@"type":@(OrderBtnTypeUploadVide)}];
    }
    else if ([info.subState isEqualToString:@"try_video_wait_audition"])
    {
        array=@[@{@"title":@"查看通告",@"width":@(68),@"type":@(OrderBtnTypeLookAnnunciate)}];
    }
    else if ([info.subState isEqualToString:@"try_video_actor_uploaded"])
    {
        array=@[@{@"title":@"查看视频",@"width":@(68),@"type":@(OrderBtnTypeLookVideo)}];
    }
    else if ([info.subState isEqualToString:@"ask_schedule_buyerNegoPrice"])
    {
        array=@[@{@"title":@"确认档期",@"width":@(68),@"type":@(OrderBtnTypeConfrimSchedule)},
                @{@"title":@"无档期",@"width":@(56),@"type":@(OrderBtnTypeNoSchedule)}];
    }
    else if ([info.subState isEqualToString:@"finish"])
    {
        if (info.orderType==3) {   //试镜
            NSInteger auditionMode =  [info.tryVideoInfo[@"auditionMode"] integerValue];
            if (auditionMode==2||auditionMode==3) {  //手机，影棚试镜
                array=@[@{@"title":@"查看视频",@"width":@(68),@"type":@(OrderBtnTypeLookVideo)}];
            }
        }else if (info.orderType==6){//授权书
            array=@[
                    @{@"title":@"预览",@"width":@(56),@"type":@(ProjectBtnTypePortraitLook)}
                    ];
        }
    }
    else if ([info.subState isEqualToString:@"actor_accept"])
    {
        if (info.orderType==3) {   //试镜
            NSInteger auditionMode =  [info.tryVideoInfo[@"auditionMode"] integerValue];
            if (auditionMode==1) {  //自备场地
                array=@[@{@"title":@"查看通告",@"width":@(68),@"type":@(OrderBtnTypeLookAnnunciate)}];
            }else if (auditionMode==4){//手机在线试镜
                 array=@[@{@"title":@"进入试镜间",@"width":@(80),@"type":@(OrderBtnTypeEnterAuditonRoom)}];
            }
        }
    }
    else if ([info.subState isEqualToString:@"pending_pay_last"] ||[info.subState isEqualToString:@"pay_done"])
    {
        array=@[@{@"title":@"查看通告",@"width":@(68),@"type":@(OrderBtnTypeLookAnnunciate)}];
    }
    else if ([info.subState isEqualToString:@"wait_actor_author"])
    {
        array=@[@{@"title":@"去签字",@"width":@(56),@"type":@(OrderBtnTypePortraitSign)},
                @{@"title":@"预览",@"width":@(56),@"type":@(ProjectBtnTypePortraitLook)}
                ];
    }
    return array;
}

-(NSString*)getAuditionWayWithType:(NSInteger)type
{
    NSString *string=@"";
    if (type==1) {
        string=@"自备场地";
    }
    else if (type==2)
    {
        string=@"影棚试镜";
    }
    else if (type==3)
    {
        string=@"手机快速试镜";
    }
    else if (type==4)
    {
        string=@"在线试镜";
    }
    return string;
}

-(NSString*)getMakeupTypeWithType:(NSInteger)type
{
    NSString *string=@"";
    if (type==1) {
        string=@"自助定妆";
    }
    else if (type==2)
    {
        string=@"脸探定妆";
    }

    return string;
}

//失效原因
-(NSString*)getFailureResonWithStatue:(NSString*)statue
{
    NSString *reson = @"";
    if ([statue isEqualToString:@"actor_reject"]) {
        reson= [UserInfoManager getUserType]==UserTypePurchaser? @"演员已拒单":@"您已拒单";
    }
    else if ([statue isEqualToString:@"cancel"])
    {
        reson= @"订单已取消";
    }
    else if ([statue isEqualToString:@"over_time"])
    {
        reson= @"订单已过期";
    }
    
    return reson;
}

@end
