//
//  ProjectMainVC+Action.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/27.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainVC+Action.h"
#import "ScheduleConfrimVC.h"
#import "AuditionPlaceOrderVC.h"
#import "MakeupPlaceOrderVC.h"
#import "ScheduleLockVC.h"
#import "AuditionNoticeVC.h"
#import "PayWaysVC.h"
#import "AcceptPricePopV.h"
#import "ModifShotTimeVC.h"
#import "DatePickPopV.h"
#import "QNTestVC.h"
#import "PortraitSignVC.h"
#import "BirthSelectV.h"
#import <AVFoundation/AVFoundation.h>
#import "PublicWebVC.h"
#import "PortraitDownLoadView.h"
@implementation ProjectMainVC (Action)

#pragma mark --button action
//底部按钮事件
-(void)BottomButtonAction:(NSInteger)type withProjectInfo:(ProjectOrderInfoM*)info withProjectDic:(nonnull NSDictionary *)projectInfo
{
    WeakSelf(self);
    if (type==ProjectBtnTypeScheduleAgain) {  //档期再确认
        ScheduleConfrimVC *schedulVC = [[ScheduleConfrimVC alloc]init];
        schedulVC.hidesBottomBarWhenPushed=YES;
        schedulVC.info=info;
        [self.navigationController pushViewController:schedulVC animated:YES];
    }
    else if (type==ProjectBtnTypeDelectActor)  //删除演员
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认删除演员？" message:@"删除之后如需该演员只能重新询问档期" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self buyerProcessWithInfo:info withOperate:1];
                                                        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }];
        
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if (type==ProjectBtnTypeAudition)     //试镜下单
    {
        AuditionPlaceOrderVC *auditVC = [[AuditionPlaceOrderVC alloc]init];
        auditVC.info=info;
        auditVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:auditVC animated:YES];
    }
    else if (type==ProjectBtnTypeLockSchedule)  //锁定档期
    {
        ScheduleLockVC *lockVC = [[ScheduleLockVC alloc]init];
        lockVC.info=info;
        lockVC.projectInfo=self.dsm.projectInfo;
        lockVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:lockVC animated:YES];
    }
    else if (type==ProjectBtnTypeAcceptPrice)  //接受价格
    {
        NSInteger buyerNegoPrice = [(NSNumber*)safeObjectForKey(info.askScheduleInfo, @"buyerNegoPrice")integerValue];  //买家报价
//        NSInteger actorNegoPrice = [(NSNumber*)safeObjectForKey(info.askScheduleInfo, @"actorNegoPrice")integerValue];  //演员还价

        AcceptPricePopV *popV = [[AcceptPricePopV alloc]init];
        [popV showWithBuyPrice:buyerNegoPrice withActorPrice:info.totalPrice];
        popV.AcceptPricePopVBlock = ^(NSInteger type) {
            if (type==1) {  //接受
                [weakself buyerProcessWithInfo:info withOperate:3];
            }
            else if (type==2) //拒绝
            {
                [weakself cancelOrderWithInfo:info];
            }
        };
    }
    else if (type==ProjectBtnTypeTryVideoPay || type==ProjectBtnTypeLockSchedulPay || type==ProjectBtnTypeLockSchedulPayLast || type==ProjectBtnTypeMakeupPay)   //试镜去支付,锁档去支付（首款）,锁档支付尾款,定妆去支付
    {
        [self PayActionWithInfo:info withType:type withProjectDic:projectInfo];
    }
    else if (type==ProjectBtnTypeCancel)   //取消
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认取消订单？" message:@"取消订单之后不能恢复" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self cancelOrderWithInfo:info];
                                                        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"再想想"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }];
        
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if (type==ProjectBtnTypeTryVideoUrgeAccept)   //试镜催演员接单
    {
        [self tryVideoProceWithInfo:info withOperate:204 withStatus:@"收到你的催接单通知，已提醒该演员尽快接单" isRefresh:NO];
    }
    else if (type==ProjectBtnTypeLockUrgeConfrim)   //锁档催确认
    {
        [self lockSchedulurgeConfrimWork:info];
    }
    else if (type==ProjectBtnTypeMakeupUrgeAccept)   //定妆催确认
    {
        [self makeupurgeConfrimWork:info];
    }
    else if (type==ProjectBtnTypeContact)  //联系脸探
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        });
    }
    else if (type==ProjectBtnTypeUrgeUpload)  //催上传
    {
        [self tryVideoProceWithInfo:info withOperate:205 withStatus:@"收到你的催上传通知，已提醒该演员尽快上传。" isRefresh:NO];
    }
    else if (type==ProjectBtnTypeLookWork)  //查看作品（试镜）
    {
        NSArray *array = (NSArray*)safeObjectForKey(info.tryVideoInfo, @"fileList");
        if (array.count==0) {
            [SVProgressHUD showImage:nil status:@"无视频"];
            return;
        }
        
        NSDictionary *dic = [array lastObject];
        if ([dic[@"fileType"]integerValue]==2) {
            NSString *url = (NSString*)safeObjectForKey(dic, @"url");
            [self playVideoWithUrl:url];
        }

    }
    else if (type==ProjectBtnTypeConfrimWork)   //确认作品（试镜）
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认作品？" message:@"确认作品后则表示该订单已完成" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self tryVideoProceWithInfo:info withOperate:212 withStatus:@"作品已确认" isRefresh:YES];
                                                        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }];
        
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if (type==ProjectBtnTypeAuditAnnunciate)  //试镜通告
    {
        AuditionNoticeVC *noticeVC = [[AuditionNoticeVC alloc]init];
        noticeVC.noticeType=0;
        noticeVC.info=info;
        noticeVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    else if (type==ProjectBtnTypeConfrimArrive)  //确认到场（自备场地）
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认到场？" message:@"确认到场后则表示该订单已完成" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self tryVideoProceWithInfo:info withOperate:210 withStatus:@"已确认到场" isRefresh:YES];
                                                        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }];
        
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if (type==ProjectBtnTypeConfrimArriveAgain)  //再次确认（自备场地）
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"再次确认到场？" message:@"再次确认到场后则表示该订单已完成" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self tryVideoProceWithInfo:info withOperate:212 withStatus:@"已确认到场" isRefresh:YES];
                                                        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }];
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{}];

    }
    else if (type==ProjectBtnTypeModifTime)   //试镜修改时间
    {
        NSString *auditionDate = info.tryVideoInfo[@"auditionDate"];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"YYYY-MM-DD HH:mm"];
//        NSDate *audition = [dateFormatter dateFromString:auditionDate];
//        NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSComparisonResult result = [audition compare:nowDate];
//        if (result == NSOrderedAscending) {
//            //NSLog(@"Date1  is in the future");
//            [SVProgressHUD showImage:nil status:@"已过试镜时间，如有疑问，请联系脸探客服"];
//            return;
//        }
      
      //   NSString *auditionDate = info.tryVideoInfo[@"auditionDate"];
        BirthSelectV *birthV = [[BirthSelectV alloc] init];
        birthV.didSelectDate = ^(NSString *dateStr){
            if ([auditionDate isEqualToString:dateStr]) {//选了一样的天数 不操作
                
            }else{//选择了不一样的天数
                NSMutableDictionary *tryInfo = [NSMutableDictionary new];
                [tryInfo addEntriesFromDictionary:info.tryVideoInfo];
                [tryInfo removeObjectForKey:@"auditionDate"];
                [tryInfo setObject:dateStr forKey:@"auditionDate"];
                info.tryVideoInfo = [tryInfo copy];
                [weakself tryVideoProceWithInfo:info withOperate:208 withStatus:@"已修改试镜时间" isRefresh:YES];
            }
            };
           type =DateTypeMinute;
     [birthV showWithString:auditionDate withType:type];
        
    }

    else if (type==ProjectBtnTypeGoAuditRoom)  //进入试镜室
    {
      
         NSString *auditionDate = info.tryVideoInfo[@"auditionDate"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-DD HH:mm"];
        NSDate *audition = [dateFormatter dateFromString:auditionDate];
        NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSComparisonResult result = [audition compare:nowDate];
        if (result == NSOrderedDescending) {
            //NSLog(@"Date1  is in the future");
            [SVProgressHUD showImage:nil status:@"试镜时间还没开始"];
            return;
        }
      //进入试镜
        NSDictionary *arg = @{
                              @"orderId":info.orderId,
                              @"userId":@([[UserInfoManager getUserUID] integerValue])
                              };
        [AFWebAPI_JAVA lauchAuditionOnlineWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *body = object[@"body"];
                NSString *token = body[@"token"];
                if (token.length>0) {
                    QNTestVC *qn = [QNTestVC new];
                    qn.isCall = YES;
                    qn.token = token;
                    qn.hisAvatar = info.actorInfo[@"actorHead"];
                    qn.hisName = info.actorInfo[@"actorName"];
                    qn.roomName = body[@"roomName"];
                    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                    if (authStatus != AVAuthorizationStatusAuthorized) {
                        
                        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                            NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
                            if (granted) {
                                [self presentViewController:qn animated:YES completion:nil];
                            }
                        }];
                        
                    } else {  //做你想做的（可以去打开设置的路径）
                        [self presentViewController:qn animated:YES completion:nil];
                    }
                }
            }else{
                [SVProgressHUD showImage:nil status:@"未获取到试镜间信息"];
            }
            }
          
         ];
            
    }
    else if (type==ProjectBtnTypeConfimFinish)  //试镜确认完成
    {
        NSString *auditionDate = info.tryVideoInfo[@"auditionDate"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-DD HH:mm"];
        NSDate *audition = [dateFormatter dateFromString:auditionDate];
        NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSComparisonResult result = [audition compare:nowDate];
        if (result == NSOrderedDescending) {
            //NSLog(@"Date1  is in the future");
            [SVProgressHUD showImage:nil status:@"还没有到试镜时间不能确认完成"];
            return;
        }
        
   
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认完成？" message:@"确认完成后则表示该订单已完成" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self tryVideoProceWithInfo:info withOperate:212 withStatus:@"已完成" isRefresh:YES];
                                                        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                        }];
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if (type==ProjectBtnTypeDownloadOnlineAuditionVideo)  //下载试镜视频
    {
       
    }
    else if (type==ProjectBtnTypeModifShotTime)  //修改拍摄日期(锁档)
    {
        ModifShotTimeVC *modifVC = [[ModifShotTimeVC alloc]init];
        modifVC.hidesBottomBarWhenPushed=YES;
        modifVC.info=info;
        [self.navigationController pushViewController:modifVC animated:YES];
    }
    else if (type==ProjectBtnTypeMakeup)   //定妆下单
    {
        MakeupPlaceOrderVC *makeupVC = [[MakeupPlaceOrderVC alloc]init];
        makeupVC.info=info;
        makeupVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:makeupVC animated:YES];
    }
    else if (type==ProjectBtnTypeShotAnnunciate)  //拍摄通告
    {
        AuditionNoticeVC *noticeVC = [[AuditionNoticeVC alloc]init];
        noticeVC.noticeType=1;
        noticeVC.info=info;
        noticeVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    else if (type==ProjectBtnTypeModifTimeAndPlace)  //修改时间地点（定妆）
    {
        AuditionNoticeVC *noticeVC = [[AuditionNoticeVC alloc]init];
        noticeVC.noticeType=2;
        noticeVC.info=info;
        noticeVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    else if (type==ProjectBtnTypeShotFinish)  //拍摄确认完成
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认完成？" message:@"确认完成后则表示该订单已完成" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self shotConfrimFinsihInfo:info];
                                                        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                        }];
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if (type==ProjectBtnTypePortraitApply)  //填写授权书
    {
        PortraitSignVC *psvc = [PortraitSignVC new];
        psvc.actorNametr = info.actorInfo[@"actorName"];
        psvc.actiorHeadStr = info.actorInfo[@"actorHead"];
        psvc.roleNametr = info.roleInfo[@"roleName"];
        if (info.authShotOrderId && info.authShotOrderId.length>0) {
             psvc.orderId = info.authShotOrderId;
        }else{
        psvc.orderId = info.orderId;
        }
        psvc.roleId = [info.roleInfo[@"roleId"] integerValue];
        psvc.created = ^{
          [weakself.dsm getNewProjectWithProjectId:weakself.dsm.projectInfo[@"projectId"]];
        };
        [self.navigationController pushViewController:psvc animated:YES];
    }
    else if (type==ProjectBtnTypePortraitLook)  //预览
    {
        NSDictionary *arg = @{
                              @"orderId":info.orderId,
                              @"userType":@(1)
                              };
        [AFWebAPI_JAVA lookPortraitWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *body = object[JSON_body];
                NSString *renderUrl = body[@"renderUrl"];
                PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"肖像授权" url:renderUrl];
                webVC.hidesBottomBarWhenPushed=YES;
                [weakself.navigationController pushViewController:webVC animated:YES];
            }
        }];
    }
    else if (type==ProjectBtnTypePortraitCancel)//取消授权
    {
        NSDictionary *arg = @{
                              @"orderId":info.orderId,
                              @"userId":@([[UserInfoManager getUserUID] integerValue])
                              };
        [AFWebAPI_JAVA portraitCancelWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                  [self.dsm getNewProjectWithProjectId:self.dsm.projectInfo[@"projectId"]];
            }else{
                [SVProgressHUD showErrorWithStatus:(NSString *)object];
            }
        }];
    }
    else if (type==ProjectBtnTypePortraitQuickly)  //崔签字
    {
  
        NSDictionary *arg = @{
                              @"orderId":info.orderId,
                              @"userId":@([[UserInfoManager getUserUID] integerValue])
                              };
        [AFWebAPI_JAVA portraitQuikWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [SVProgressHUD showImage:nil status:@"收到您的催签字通知，已提醒该演员尽快签字"];
            }else{
                [SVProgressHUD showErrorWithStatus:(NSString *)object];
            }
        }];
    }
    else if (type==ProjectBtnTypePortraitDownLoad)  //授权书下载
    {
        PortraitDownLoadView *pdv = [[PortraitDownLoadView alloc] init];
        pdv.download = ^(NSString * _Nonnull email) {
            NSDictionary *dig = @{
                                  @"email":email,
                                  @"userId":@([[UserInfoManager getUserUID] integerValue]),
                                  @"orderId":info.authShotOrderId
                                  };
            [AFWebAPI_JAVA portraitDownloadWithArg:dig callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    [SVProgressHUD showSuccessWithStatus:@"授权书将会以PDF形式发送至邮箱"];
                }else{
                    
                }
            }];
        };
        [pdv show];
    }
    else if (type==ProjectBtnTypeMore)  //更多
    {
        
    }
}

//删除演员,接受演员还价
-(void)buyerProcessWithInfo:(ProjectOrderInfoM*)info withOperate:(NSInteger)operate
{
    NSDictionary *dicArg = @{@"operate":@(operate),
                             @"orderId":info.orderId,
                             @"userId":[UserInfoManager getUserUID]
                             };
    [SVProgressHUD show];
    [AFWebAPI_JAVA getBuyerProcesssWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self.dsm getNewProjectWithProjectId:self.dsm.projectInfo[@"projectId"]];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//取消订单
-(void)cancelOrderWithInfo:(ProjectOrderInfoM*)info
{
    NSDictionary *dicArg = @{
                             @"orderId":info.orderId,
                             @"userId":[UserInfoManager getUserUID]
                             };
    [SVProgressHUD showWithStatus:@"正在取消订单。。。"];
    [AFWebAPI_JAVA getOrderCancelWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"订单已取消"];
            [self.dsm getNewProjectWithProjectId:self.dsm.projectInfo[@"projectId"]];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

/*去支付
 ProjectBtnTypeTryVideoPay:试镜去支付     ProjectBtnTypeLockSchedulPay:锁档去支付
 ProjectBtnTypeLockSchedulPayLast:锁档支付尾款  ProjectBtnTypeMakeupPay:定妆去支付
*/
-(void)PayActionWithInfo:(ProjectOrderInfoM*)info withType:(ProjectBtnType)type withProjectDic:(NSDictionary *)projectInfo
{
    NSInteger price=0;
    if (info.orderType==7 ||info.orderType==4) {  //锁档和拍摄
        if (type==ProjectBtnTypeLockSchedulPay) {  //首款
            
            BOOL serviceFeePaid = [projectInfo[@"serviceFeePaid"]boolValue];  //服务费是否已支付
            NSInteger serviceFee = [projectInfo[@"projectServiceFeePerDay"]integerValue];  //服务费
            NSInteger projectDays = [projectInfo[@"projectDays"]integerValue];  //项目天数
            NSInteger firstprice = info.firstPrice;
            if (serviceFeePaid==NO) {
                firstprice =firstprice +serviceFee*projectDays;
            }
            price=firstprice;

        }
        else if (type==ProjectBtnTypeLockSchedulPayLast) //尾款
        {
            price=info.totalPrice-info.firstPrice;
        }
        else
        {
            price=info.totalPrice;
        }
    }
    else
    {
        price=info.totalPrice;
    }
    
    
    PayWaysVC *payVC=[[PayWaysVC alloc]init];
    payVC.orderids=info.orderId;
    payVC.totalPrice=price;
    payVC.hidesBottomBarWhenPushed=YES;
    WeakSelf(self);
    payVC.refreshData = ^{
        [weakself paySuccessBack:info withType:type];
    };
    [self.navigationController pushViewController:payVC animated:YES];
//    [self paySuccessBack:info withType:type];
}

//支付成功回掉
-(void)paySuccessBack:(ProjectOrderInfoM*)info withType:(ProjectBtnType)type
{
    //试镜
    if (type==ProjectBtnTypeTryVideoPay) {
        [self tryVideoProceWithInfo:info withOperate:202 withStatus:@"" isRefresh:YES];
    }
    //锁档
    else if (type==ProjectBtnTypeLockSchedulPay||type==ProjectBtnTypeLockSchedulPayLast)
    {
        NSInteger operate=0;
        if (type==ProjectBtnTypeLockSchedulPay) {  //首款
            operate=302;
        }
        else
        {
            operate=308;
        }
        
        NSDictionary *dicArg = @{@"operate":@(operate),
                                 @"orderIdList":@[info.orderId],
                                 @"userId":[UserInfoManager getUserUID],
                                 @"userType":@([UserInfoManager getUserType])
                                 };
        [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                [self.dsm getNewProjectWithProjectId:self.dsm.projectInfo[@"projectId"]];
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
        }];
    }
    //定妆
    else if (type==ProjectBtnTypeMakeupPay)
    {
        NSDictionary *dicArg = @{@"operate":@(402),
                                 @"orderId":info.orderId,
                                 @"userId":[UserInfoManager getUserUID],
                                 @"userType":@([UserInfoManager getUserType])
                                 };
        [AFWebAPI_JAVA getMakeupProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                 [self.dsm getNewProjectWithProjectId:self.dsm.projectInfo[@"projectId"]];
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
        }];
    }
}


//锁档催演员确认
-(void)lockSchedulurgeConfrimWork:(ProjectOrderInfoM*)info
{
    NSDictionary *dicArg = @{@"operate":@(305),
                             @"orderIdList":@[info.orderId],
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType])
                             };
    [SVProgressHUD show];
    [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showImage:nil status:@"收到你的催确认通知，已提醒该演员尽快确认"];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//定妆催演员确认
-(void)makeupurgeConfrimWork:(ProjectOrderInfoM*)info
{
    NSDictionary *dicArg = @{@"operate":@(406),
                             @"orderId":info.orderId,
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType])
                             };
    [SVProgressHUD show];
    [AFWebAPI_JAVA getMakeupProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showImage:nil status:@"收到你的催确认通知，已提醒该演员尽快确认"];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}


//试镜订单操作
-(void)tryVideoProceWithInfo:(ProjectOrderInfoM*)info withOperate:(NSInteger)operate withStatus:(NSString*)status isRefresh:(BOOL)refresh
{
    NSDictionary *dicArg = @{@"operate":@(operate),
                             @"orderId":info.orderId,
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType])
                             };
    if (status.length>0) {
        [SVProgressHUD show];
    }
    [AFWebAPI_JAVA getTryVideoProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            if (status.length>0) {
                [SVProgressHUD showImage:nil status:status];
            }
       
            if (refresh) {
                [self.dsm getNewProjectWithProjectId:self.dsm.projectInfo[@"projectId"]];
            }
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}


//拍摄确认完成
-(void)shotConfrimFinsihInfo:(ProjectOrderInfoM*)info
{
    NSDictionary *dicArg = @{@"operate":@(309),
                             @"orderIdList":@[info.orderId],
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType])
                             };
    [SVProgressHUD show];
    [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [self.dsm getNewProjectWithProjectId:self.dsm.projectInfo[@"projectId"]];
            [SVProgressHUD dismiss];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}
@end
