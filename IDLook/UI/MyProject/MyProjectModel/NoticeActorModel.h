//
//  NoticeActorModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeActorModel : NSObject

@property(nonatomic,strong)NSDictionary *actorInfo;
//                               "actorInfo": {
//                                   "actorHead": "string",
//                                   "actorId": 0,
//                                   "actorName": "string",
//                                   "masteryName": "string",
//                                   "performType": "如：甜美|气质|动感",
//                                   "region": "string",
//                                   "sex": "1=男;2=女"
//                               },
@property(nonatomic,copy)NSString *orderState;
// @"orderState":orderState, "ask_schedule:询问档期; try_video: 试镜; lock_schedule:锁定档期; makeup: 定妆; shot:拍摄; author: 授权书; cancel:取消; finished: 完成"
@property(nonatomic,copy)NSString *subState;
// @"subState":subState, ask_schedule_query:询问档期; ask_schedule_buyerNegoPrice:买方议价; ask_schedule_actorNegoPrice: 演员还价;  try_video_wait_actor_upload: 待演员上传作品; try_video_actor_uploaded: 演员已上传作品; try_video_wait_audition: 待开始试镜;  try_video_on_audition: 试镜中; pending_pay: 待支付; pending_pay_first: 待支付首款; pending_pay_last: 待支付尾款; pay_done: 已付尾款或全部支付;   wait_actor_accept: 待演员确认; actor_accept: 演员接受;  actor_reject: 演员拒绝; over_time: 已过期; cancel: 取消; finish: 完成;"
@property(nonatomic,copy)NSString *shotStart;
@property(nonatomic,copy)NSString *shotEnd;
@property(nonatomic,copy)NSString *roleName;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,assign)BOOL dateBeyond;//是否超出项目拍摄时间
@end

NS_ASSUME_NONNULL_END
