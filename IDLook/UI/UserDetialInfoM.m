//
//  UserDetialInfoM.m
//  IDLook
//
//  Created by Mr Hu on 2019/3/7.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "UserDetialInfoM.h"

@implementation UserDetialInfoM

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.actorId    = [(NSNumber *)safeObjectForKey(dic, @"actorId") integerValue];
        self.priceInfo =(NSDictionary*)safeObjectForKey(dic, @"priceInfo");
        self.commentInfo =(NSDictionary*)safeObjectForKey(dic, @"commentInfo");
        self.lastComment =(NSDictionary*)safeObjectForKey(dic, @"lastComment");
        self.worksList    = (NSArray *)safeObjectForKey(dic, @"worksList");
       self.fansInfo = (NSArray *)safeObjectForKey(dic, @"fansInfo");
        
        NSDictionary *accountInfo = (NSDictionary*)safeObjectForKey(dic, @"accountInfo");
        NSDictionary *basicInfo = (NSDictionary*)safeObjectForKey(dic, @"basicInfo");
        NSDictionary *popularInfo = (NSDictionary*)safeObjectForKey(dic, @"popularInfo");
        NSDictionary *professionInfo = (NSDictionary*)safeObjectForKey(dic, @"professionInfo");

        //basicInfo
        self.actorName = (NSString *)safeObjectForKey(basicInfo, @"actorName");
        self.avatar    = (NSString *)safeObjectForKey(basicInfo, @"avatar");
        self.birthday    = (NSString *)safeObjectForKey(basicInfo, @"birthday");
        self.nickName    = (NSString *)safeObjectForKey(basicInfo, @"nickName");
        self.region    = (NSString *)safeObjectForKey(basicInfo, @"region");
        self.language    = (NSString *)safeObjectForKey(basicInfo, @"language");
        self.nationality    = (NSString *)safeObjectForKey(basicInfo, @"nationality");
        self.sex    = [(NSNumber *)safeObjectForKey(basicInfo, @"sex") integerValue];
        self.height    = [(NSNumber *)safeObjectForKey(basicInfo, @"height") integerValue];
        self.weight    = [(NSNumber *)safeObjectForKey(basicInfo, @"weight") integerValue];
        self.shoes    = [(NSNumber *)safeObjectForKey(basicInfo, @"shoes") integerValue];
        self.waist    = [(NSNumber *)safeObjectForKey(basicInfo, @"waist") integerValue];
        self.chest    = [(NSNumber *)safeObjectForKey(basicInfo, @"chest") integerValue];
        self.hips    = [(NSNumber *)safeObjectForKey(basicInfo, @"hips") integerValue];
        self.actorStudio    = [(NSNumber *)safeObjectForKey(basicInfo, @"actorStudio") integerValue];
        self.authentication    = [(NSNumber *)safeObjectForKey(basicInfo, @"authentication") integerValue];

        //professionInfo
        self.occupation    = [(NSNumber *)safeObjectForKey(professionInfo, @"occupation") integerValue];
        self.mastery    = [(NSNumber *)safeObjectForKey(professionInfo, @"mastery") integerValue];
        self.academy    = (NSString *)safeObjectForKey(professionInfo, @"academy");
        self.grade    = (NSString *)safeObjectForKey(professionInfo, @"grade");
        self.major    = (NSString *)safeObjectForKey(professionInfo, @"major");
        self.brief    = (NSString *)safeObjectForKey(professionInfo, @"brief");
        self.representativeWork    = (NSString *)safeObjectForKey(professionInfo, @"representativeWork");
        self.performType    = (NSString *)safeObjectForKey(professionInfo, @"performType");
        
        //popularInfo
        self.collect    = [(NSNumber *)safeObjectForKey(popularInfo, @"collect") integerValue];
        self.isPraise    = [(NSNumber *)safeObjectForKey(popularInfo, @"isPraise") boolValue];
        self.isCollect    = [(NSNumber *)safeObjectForKey(popularInfo, @"isCollect") boolValue];
        self.weiboFans    = [(NSNumber *)safeObjectForKey(popularInfo, @"weiboFans") integerValue];
        self.praise    = [(NSNumber *)safeObjectForKey(popularInfo, @"praise") integerValue];

        //accountInfo
        self.aliPayId    = (NSString *)safeObjectForKey(accountInfo, @"aliPayId");
        self.bankCardNo    = (NSString *)safeObjectForKey(accountInfo, @"bankCardNo");
        self.bankName    = (NSString *)safeObjectForKey(accountInfo, @"bankName");
        self.unlockingPrice = [(NSNumber *)safeObjectForKey(dic, @"unlockingPrice") boolValue];
    }
    return self;
}


@end
