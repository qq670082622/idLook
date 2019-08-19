//
//  MyOrderVCM.m
//  IDLook
//
//  Created by HYH on 2018/5/22.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyOrderVCM.h"
#import "OrderProjectModel.h"
#import "ProjectOrderInfoM.h"

NSString * const kMyOrderVCMCellClass =  @"kMyOrderVCMCellClass";
NSString * const kMyOrderVCMCellHeight = @"kMyOrderVCMCellHeight";
NSString * const kMyOrderVCMCellType =   @"kMyOrderVCMCellType";
NSString * const kMyOrderVCMCellData =   @"kMyOrderVCMCellData";

@implementation MyOrderVCM

-(id)init
{
    if (self=[super init]) {

//        [self analyzeOrderListWithArray:nil withState:0];
        if ([UserInfoManager getUserType]==UserTypePurchaser) {
            [self analyzePurAllOrderListWithArray:nil withState:0];
        }
        else
        {
            [self analyzeActorAllOrderListWithArray:nil withState:0];
        }
    }
    return self;
}

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)refreshOrderListWithState:(NSInteger)state CallBack:(void (^)(BOOL))callBack
{

    NSString *userid;
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        userid=@"actorid";
        if (state>0) {
            state=state+10;
        }
    }
    else
    {
        userid=@"buyerid";
    }
//    NSDictionary *dicArg = @{userid:[UserInfoManager getUserUID],
//                             @"orderstatus":@(state)};
//    [AFWebAPI getAllOrderList:dicArg callBack:^(BOOL success, id object) {
//        if (success) {
//            NSArray *array=[object objectForKey:JSON_data];
//            [self analyzeOrderListWithArray:array withState:state];
//            callBack(YES);
//        }
//        else
//        {
//            AF_SHOW_RESULT_ERROR
//            callBack(NO);
//        }
//    }];
    
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"orderStatus":@(state)};
    [AFWebAPI_JAVA getAllOrderListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
             NSDictionary *dic=[object objectForKey:JSON_body];
            NSArray *projectOrderList = (NSArray*)safeObjectForKey(dic, @"projectOrderList");
            NSLog(@"--%@",projectOrderList);
            if ([UserInfoManager getUserType]==UserTypePurchaser) {
                [self analyzePurAllOrderListWithArray:projectOrderList withState:state];
            }
            else
            {
                [self analyzeActorAllOrderListWithArray:projectOrderList withState:state];
            }
            callBack(YES);
        }
        else
        {
            AF_SHOW_JAVA_ERROR
            callBack(NO);
        }
    }];
}
//归类演员订单
- (void)analyzeActorAllOrderListWithArray:(NSArray*)array withState:(NSInteger)state
{
    [self.ds removeAllObjects];
    
    NSMutableArray *sec0 = [NSMutableArray new];
    NSMutableArray *sec1 = [NSMutableArray new];
    NSMutableArray *sec2 = [NSMutableArray new];
    NSMutableArray *sec3 = [NSMutableArray new];
    NSMutableArray *sec4 = [NSMutableArray new];
    NSMutableArray *sec5 = [NSMutableArray new];
    
    
    for (int i =0; i<array.count; i++)
    {
        NSDictionary *dic = array[i];
        NSArray *orderGroups = dic[@"orderGroups"];
        CGFloat height = 30;
        NSString *classStr = @"MyOrderListCellB";
        NSMutableArray *newOrders = [NSMutableArray new];
        
        for (int j=0; j<orderGroups.count; j++) {
            NSDictionary *dicA =orderGroups[j];
            NSArray *orders = dicA[@"orders"];
            
            for (int k=0; k<orders.count; k++) {
                ProjectOrderInfoM *info =[[ProjectOrderInfoM alloc]initWithDic:orders[k]];
                [newOrders addObject:info];
                
                CGFloat cellH = 112;
                if ([[info OrderGetActorBottomButtonWithOrderInfo:info]count]>0 || [info.subStateName isEqualToString:@"已失效"]) {  //有按钮操作时
                    cellH = 138;
                }
                height=height+cellH;
            }
        }
        
        NSDictionary *info = @{@"projectInfo":dic,
                               @"orderInfo":@{@"orderType":@"1",
                                              @"orders":newOrders
                                              }
                               };
        
        if (state==0) {  //全部
            [sec0 addObject:@{kMyOrderVCMCellData:info,
                              kMyOrderVCMCellClass:classStr,
                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
        }
        else if (state==11)  //待确认
        {
            [sec1 addObject:@{kMyOrderVCMCellData:info,
                              kMyOrderVCMCellClass:classStr,
                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
        }
        else if (state==12)  //议价中
        {
            [sec2 addObject:@{kMyOrderVCMCellData:info,
                              kMyOrderVCMCellClass:classStr,
                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
        }
        else if (state==13)  //进行中
        {
            [sec3 addObject:@{kMyOrderVCMCellData:info,
                              kMyOrderVCMCellClass:classStr,
                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
        }
        else if (state==14)  //已完成
        {
            [sec4 addObject:@{kMyOrderVCMCellData:info,
                              kMyOrderVCMCellClass:classStr,
                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
        }
        else if (state==15)  //已失效
        {
            [sec5 addObject:@{kMyOrderVCMCellData:info,
                              kMyOrderVCMCellClass:classStr,
                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
        }
        
    }
    
    [self.ds addObject:sec0];
    [self.ds addObject:sec1];
    [self.ds addObject:sec2];
    [self.ds addObject:sec3];
    [self.ds addObject:sec4];
    [self.ds addObject:sec5];
    
}
//归类买家订单类型
- (void)analyzePurAllOrderListWithArray:(NSArray*)array withState:(NSInteger)state
{
    [self.ds removeAllObjects];
    
    NSMutableArray *sec0 = [NSMutableArray new];
    NSMutableArray *sec1 = [NSMutableArray new];
    NSMutableArray *sec2 = [NSMutableArray new];
    NSMutableArray *sec3 = [NSMutableArray new];
    NSMutableArray *sec4 = [NSMutableArray new];
    
    for (int i =0; i<array.count; i++)
    {
        NSDictionary *dic = array[i];
        NSArray *orderGroups = dic[@"orderGroups"];
        CGFloat height ;
        NSString *classStr = @"MyOrderListCellA";
        for (int j=0; j<orderGroups.count; j++) {
            NSDictionary *dicA =orderGroups[j];
            NSArray *orders = dicA[@"orders"];
            height = orders.count*112+30;
            
            NSMutableArray *newOrders = [NSMutableArray new];
            for (int k=0; k<orders.count; k++) {
                ProjectOrderInfoM *info =[[ProjectOrderInfoM alloc]initWithDic:orders[k]];
                [newOrders addObject:info];
            }
            
            NSDictionary *info = @{@"projectInfo":dic,
                                   @"orderInfo":@{@"orderType":dicA[@"orderType"],
                                                  @"orders":newOrders
                                                  }
                                   };
            
            if (state==0) {  //全部
                [sec0 addObject:@{kMyOrderVCMCellData:info,
                                  kMyOrderVCMCellClass:classStr,
                                  kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
            }
            else if (state==1)  //待确认
            {
                [sec1 addObject:@{kMyOrderVCMCellData:info,
                                  kMyOrderVCMCellClass:classStr,
                                  kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
            }
            else if (state==2)  //进行中
            {
                [sec2 addObject:@{kMyOrderVCMCellData:info,
                                  kMyOrderVCMCellClass:classStr,
                                  kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
            }
            else if (state==3)  //已完成
            {
                [sec3 addObject:@{kMyOrderVCMCellData:info,
                                  kMyOrderVCMCellClass:classStr,
                                  kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
            }
            else if (state==4)  //已失效
            {
                [sec4 addObject:@{kMyOrderVCMCellData:info,
                                  kMyOrderVCMCellClass:classStr,
                                  kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
            }
        }
        
    }
    
    [self.ds addObject:sec0];
    [self.ds addObject:sec1];
    [self.ds addObject:sec2];
    [self.ds addObject:sec3];
    [self.ds addObject:sec4];
}




//- (void)analyzeOrderListWithArray:(NSArray*)array withState:(NSInteger)state
//{
//    [self.ds removeAllObjects];
//
//    NSMutableArray *sec0 = [NSMutableArray new];
//    NSMutableArray *sec1 = [NSMutableArray new];
//    NSMutableArray *sec2 = [NSMutableArray new];
//    NSMutableArray *sec3 = [NSMutableArray new];
//    NSMutableArray *sec4 = [NSMutableArray new];
//
//    for (int i =0; i<array.count; i++)
//    {
//        OrderProjectModel *projectModel = [[OrderProjectModel alloc]initWithDic:array[i]];
//        projectModel.ordeState=state;
//        CGFloat height = 0;
//        NSString *classStr = @"";
//
//        if ([UserInfoManager getUserType]==UserTypePurchaser) {  //购买方
//            classStr=@"MyOrderProjectCellA";
//            height = [self getPurCellHeightWithProjectModel:projectModel];
//        }
//        else
//        {
//            OrderModel *structModel = [projectModel.orderlist firstObject];
//            classStr=@"MyOrderProjectCellB";
//            height=[self getResourceCellHeightWithState:state withOrderModel:structModel];
//        }
//
//        if (state==0) {  //全部
//            [sec0 addObject:@{kMyOrderVCMCellData:projectModel,
//                              kMyOrderVCMCellClass:classStr,
//                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
//        }
//        else if (state==1)  //待确认
//        {
//            [sec1 addObject:@{kMyOrderVCMCellData:projectModel,
//                              kMyOrderVCMCellClass:classStr,
//                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
//        }
//        else if (state==2)  //进行中
//        {
//            [sec2 addObject:@{kMyOrderVCMCellData:projectModel,
//                              kMyOrderVCMCellClass:classStr,
//                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
//        }
//        else if (state==3)  //已完成
//        {
//            [sec3 addObject:@{kMyOrderVCMCellData:projectModel,
//                              kMyOrderVCMCellClass:classStr,
//                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
//        }
//        else if (state==4)  //已失效
//        {
//            [sec4 addObject:@{kMyOrderVCMCellData:projectModel,
//                              kMyOrderVCMCellClass:classStr,
//                              kMyOrderVCMCellHeight:[NSNumber numberWithFloat:height]}];
//        }
//
//    }
//
//    [self.ds addObject:sec0];
//    [self.ds addObject:sec1];
//    [self.ds addObject:sec2];
//    [self.ds addObject:sec3];
//    [self.ds addObject:sec4];
//}

/**
 获取资源方订单cell高度
 @param state 订单总状态
 @param model 订单数据模型
 @return cell高度
 */
-(CGFloat)getResourceCellHeightWithState:(NSInteger)state withOrderModel:(OrderModel*)model
{
    CGFloat totalH  = 100;
    if (model.ordertype==OrderTypeAudition) {  //试镜
        if ([model.orderstate isEqualToString:@"paied"]||[model.orderstate isEqualToString:@"acceptted"]) {  //需要 接单，上传视频
            totalH+=45;
        }
    }
    else if (model.ordertype==OrderTypeShot) //拍摄
    {
        if ([model.orderstate isEqualToString:@"new"]) {  //需要 接单
            totalH+=45;
        }
    }
    
    if (state==4) {  //已失效,失效原因
        totalH+=45;
    }
    
    return totalH;
}

/**
 获取购买方订单cell高度
 @param model 项目数据模型
 @return cell高度
 */
-(CGFloat)getPurCellHeightWithProjectModel:(OrderProjectModel*)model
{
    CGFloat totalH  = 45;

    for (int i=0; i<model.orderlist.count; i++) {
        OrderModel *orderModel = model.orderlist[i];
        CGFloat subVHeight = 90;  //单个艺人cell高度
        if (model.ordeState==OrderStateTypeConfirm || model.ordeState==OrderStateTypeFailure) {  //待确认 高度90+45 有取消订单一栏高度45
            if (orderModel.ordertype==OrderTypeAudition&&[orderModel.orderstate isEqualToString:@"paied"]) {  //试镜订单已支付 ，不能取消
                subVHeight=90;
            }
            else
            {
                subVHeight=135;
            }
        }
        else if (model.ordeState==OrderStateTypeGoing)
        {
            if (orderModel.ordertype==OrderTypeAudition&&[orderModel.orderstate isEqualToString:@"videouploaded"]) {//试镜订单,有确认完成按钮
                subVHeight=135;
            }
            else if (orderModel.ordertype==OrderTypeShot&&[orderModel.orderstate isEqualToString:@"paiedtwo"])  //拍摄订单，有确认完成按钮
            {
                subVHeight=135;
            }
        }
        else
        {
            subVHeight=90;
        }
        totalH= totalH+subVHeight;
    }

    if (model.type==2) {  //拍摄项目，有服务费一栏
        if (model.ordeState!=OrderStateTypeFailure) {
            totalH =totalH +45;
        }
    }
    
    if (model.ordeState==OrderStateTypeFinished || model.ordeState==OrderStateTypeFailure) {  //合计总价一栏
        totalH =totalH +45;
    }
    
    return totalH;
}

@end
