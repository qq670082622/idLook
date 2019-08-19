//
//  OrderModel.m
//  IDLook
//
//  Created by HYH on 2018/6/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderModel.h"
#import "CJSONDeserializer.h"

@implementation OrderModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.orderId = (NSString *)safeObjectForKey(dic, @"orderid");
        self.orderdate    = (NSString *)safeObjectForKey(dic, @"orderdate");
        self.ordertype =[(NSNumber *)safeObjectForKey(dic, @"ordertype") integerValue];
        self.orderstate    = (NSString *)safeObjectForKey(dic, @"orderstate");
        self.ordermsg    = (NSString *)safeObjectForKey(dic, @"ordermsg");

        self.buyerid    = (NSString *)safeObjectForKey(dic, @"buyerid");
        self.actorid    = (NSString *)safeObjectForKey(dic, @"actorid");
        self.policynum    = (NSString *)safeObjectForKey(dic, @"policynum");

        NSDictionary *artistInfo = (NSDictionary*)safeObjectForKey(dic, @"actorinfo");
        
        self.actorNick    = (NSString *)safeObjectForKey(artistInfo, @"nickname");
        self.actorHead    = (NSString *)safeObjectForKey(artistInfo, @"headporurl");
        
        NSDictionary *dicA = (NSDictionary*)safeObjectForKey(dic, @"detail");
        
        self.projectName    = (NSString *)safeObjectForKey(dicA, @"entryname");
        self.brand    = (NSString *)safeObjectForKey(dicA, @"brand");
        self.product    = (NSString *)safeObjectForKey(dicA, @"product");
        self.shootplace    = (NSString *)safeObjectForKey(dicA, @"shootplace");
        self.shootdays =[(NSNumber *)safeObjectForKey(dicA, @"shootdays") integerValue];
        self.shootdays2 =[(NSNumber *)safeObjectForKey(dicA, @"comshootdays") integerValue];
        self.auditionType =[(NSNumber *)safeObjectForKey(dicA, @"mode") integerValue];
        self.demand    = (NSString *)safeObjectForKey(dicA, @"demand");
        self.requirement    = (NSString *)safeObjectForKey(dicA, @"requirement");
        self.price    = (NSString *)safeObjectForKey(dicA, @"price");
        self.profit    = (NSString *)safeObjectForKey(dicA, @"profit");
        self.datereservation    = (NSString *)safeObjectForKey(dicA, @"datereservation");
        self.datereservationend    = (NSString *)safeObjectForKey(dicA, @"datereservationend");
        self.datemakeup    = (NSString *)safeObjectForKey(dicA, @"datemakeup");
        self.creativeurl    = (NSString *)safeObjectForKey(dicA, @"creativeurl");
        
        self.advType    = (NSString *)safeObjectForKey(dicA, @"type");
        self.advType2    = (NSString *)safeObjectForKey(dicA, @"comtype");
        self.cycle    = (NSString *)safeObjectForKey(dicA, @"cycle");
        self.region    = (NSString *)safeObjectForKey(dicA, @"region");
        self.fixedprice    = (NSString *)safeObjectForKey(dicA, @"fixedprice");
        self.makeupprice    = (NSString *)safeObjectForKey(dicA, @"makeupprice");
        self.manageprice    = (NSString *)safeObjectForKey(dicA, @"manageprice");
        self.insuranceprice    = (NSString *)safeObjectForKey(dicA, @"insuranceprice");

        self.fixedprofit    = (NSString *)safeObjectForKey(dicA, @"fixedprofit");
        self.totalprice    = (NSString *)safeObjectForKey(dicA, @"totalprice");
        self.totalprofit    = (NSString *)safeObjectForKey(dicA, @"totalprofit");
        self.projectdesc    = (NSString *)safeObjectForKey(dicA, @"projectdesc");
        self.latestworktime    = (NSString *)safeObjectForKey(dicA, @"latestworktime");
        
        self.shotordertype =[(NSNumber *)safeObjectForKey(dicA, @"ordertype") integerValue];
        self.ordertypeprice    = (NSString *)safeObjectForKey(dicA, @"ordertypeprice");
        self.freeprice    = (NSString *)safeObjectForKey(dicA, @"freeprice");
        self.showprice    = (NSString *)safeObjectForKey(dicA, @"showprice");

//        self.offerInfo = (NSDictionary*)safeObjectForKey(dic, @"ordermsg");

        self.ordersubtype =[(NSNumber *)safeObjectForKey(dic, @"ordersubtype") integerValue];
        self.ordertypeName= [self getOrderTypeName:self.ordertype];
        
        NSString *offerInfo = (NSString*)safeObjectForKey(dic, @"ordermsg");
        NSData *jsonData = [offerInfo dataUsingEncoding:NSUTF8StringEncoding];
        self.offerInfo = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];

        if ([self.datereservation isEqualToString:@"0000-00-00"]) {
            self.datereservation=@"";
        }
        if ([self.datemakeup isEqualToString:@"0000-00-00"]) {
            self.datemakeup=@"";
        }
        self.useridentity= [(NSNumber *)safeObjectForKey(dic, @"useridentity") integerValue];
        self.payterms= [(NSNumber *)safeObjectForKey(dicA, @"payterms") integerValue];
        self.bailprice    = (NSString *)safeObjectForKey(dicA, @"bailprice");
        self.evaluate= [(NSNumber *)safeObjectForKey(dicA, @"evaluate") integerValue];
    }
    return self;
}

-(NSString*)getAuditionWayWithType:(NSInteger)type
{
    NSString *string;
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

-(NSString*)getOrderStateWihtOrderInfo:(OrderModel*)info
{
    NSString *string=@"";
    OrderType ordertype =info.ordertype;
    NSString *orderstate = info.orderstate;
    
    UserType  roleType = [UserInfoManager getUserType];
    
    if (ordertype==OrderTypeAudition) {
        if ([orderstate isEqualToString:@"new"])
        {
            string = @"待支付";
        }
        else if ([orderstate isEqualToString:@"paied"])
        {
            string = (roleType==UserTypePurchaser?@"待艺人接单":@"待接单");
        }
        else if ([orderstate isEqualToString:@"acceptted"])
        {
            string = (roleType == UserTypePurchaser ? @"待艺人上传试镜视频" : @"待上传试镜视频");
        }
        else if ([orderstate isEqualToString:@"videouploaded"])
        {
            string=@"待确认完成";
        }
        else if ([orderstate isEqualToString:@"finished"])
        {
            string=@"已完成";
        }
        else if ([orderstate isEqualToString:@"cancel"] || [orderstate isEqualToString:@"rejected"] || [orderstate isEqualToString:@"overtime"] || [orderstate isEqualToString:@"buydefault"] ||[orderstate isEqualToString:@"actordefault"]||[orderstate isEqualToString:@"noschedule"])
        {
            string=@"已失效";
        }
    }
    else
    {
        if ([orderstate isEqualToString:@"new"])
        {
            string = @"待确认档期";
        }
        else if ([orderstate isEqualToString:@"acceptted"])
        {
            string = (roleType == UserTypePurchaser ? @"待锁定档期" : @"待锁定档期");
        }
        else if ([orderstate isEqualToString:@"paiedone"])
        {
            string = (roleType == UserTypePurchaser ? @"已锁定档期" : @"等待拍摄");
        }
        else if ([orderstate isEqualToString:@"paiedtwo"])
        {
            string=(roleType == UserTypePurchaser ? @"待确认完成" : @"待确认完成");
        }
        else if ([orderstate isEqualToString:@"finished"])
        {
            string=@"已完成";
        }
        else if ([orderstate isEqualToString:@"cancel"] || [orderstate isEqualToString:@"rejected"] || [orderstate isEqualToString:@"overtime"] || [orderstate isEqualToString:@"buydefault"] ||[orderstate isEqualToString:@"actordefault"]||[orderstate isEqualToString:@"noschedule"])
        {
            string=@"已失效";
        }
    }    
    return string;
}

-(NSString*)getOrderTypeName:(OrderType)type
{
    NSString *str;
    
    if (type==OrderTypeAudition) {
        str=@"试镜订单";
    }
    else if (type==OrderTypeShot)
    {
        str=@"拍摄订单";
    }
    else if (type==OrderTypeMirror)
    {
        str=@"微出镜订单";
    }
    else if (type==OrderTypeTrial)
    {
        str=@"试葩间订单";
    }
    else if (type==OrderTypeRenewal)
    {
        str=@"肖像续约订单";
    }
    
    return str;
}

@end
