//
//  OrderProjectModel.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "OrderProjectModel.h"

@implementation OrderProjectModel

-(NSMutableArray*)orderlist
{
    if (!_orderlist) {
        _orderlist=[NSMutableArray new];
    }
    return _orderlist;
}

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.projectid = (NSString *)safeObjectForKey(dic, @"projectid");
        self.name = (NSString *)safeObjectForKey(dic, @"name");
        self.type =[(NSNumber *)safeObjectForKey(dic, @"type") integerValue];
        self.url = (NSString *)safeObjectForKey(dic, @"url");
        self.desc = (NSString *)safeObjectForKey(dic, @"desc");
        self.auditionend = (NSString *)safeObjectForKey(dic, @"auditionend");
        self.city = (NSString *)safeObjectForKey(dic, @"city");
        self.shotcycle = (NSString *)safeObjectForKey(dic, @"shotcycle");
        self.shotregion = (NSString *)safeObjectForKey(dic, @"shotregion");
        self.auditiondays =[(NSNumber *)safeObjectForKey(dic, @"auditiondays") integerValue];
        self.start = (NSString *)safeObjectForKey(dic, @"start");
        self.end = (NSString *)safeObjectForKey(dic, @"end");

        self.useridentity= [(NSNumber *)safeObjectForKey(dic, @"useridentity") integerValue];
        self.documentarystatus =[(NSNumber *)safeObjectForKey(dic, @"documentarystatus") integerValue];
        self.isevaluate= [(NSNumber *)safeObjectForKey(dic, @"isevaluate") integerValue];
        self.allevaluate= [(NSNumber *)safeObjectForKey(dic, @"allevaluate") integerValue];

        self.vdo = (NSArray*)safeObjectForKey(dic, @"vdo");
        self.img = (NSArray*)safeObjectForKey(dic, @"img");
        
        id orderlist = safeObjectForKey(dic, @"orderlist");
        if ([orderlist isKindOfClass:[NSArray class]]) {
            NSArray *list = (NSArray*)orderlist;
            for (int i=0; i<list.count; i++) {
                OrderModel *model = [[OrderModel alloc]initWithDic:list[i]];
                [self.orderlist addObject:model];
            }
        }
        
        if ([orderlist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *orderDic = (NSDictionary*)orderlist;
            self.orderModel = [[OrderModel alloc]initWithDic:orderDic];
        }
        
    }
    return self;
}

@end
