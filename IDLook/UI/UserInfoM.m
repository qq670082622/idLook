//
//  UserInfoM.m
//  IDLook
//
//  Created by HYH on 2018/5/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoM.h"

@implementation UserInfoM

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.UID    = [NSString stringWithFormat:@"%ld",(long)[(NSNumber *)safeObjectForKey(dic, @"id") integerValue]];
        self.mobile = (NSString *)safeObjectForKey(dic, @"phone");
        self.pwd    = (NSString *)safeObjectForKey(dic, @"password");
    
        self.identity  = [(NSNumber *)safeObjectForKey(dic, @"identity") integerValue];
        self.type = [(NSNumber *)safeObjectForKey(dic, @"type") integerValue];
        

        self.nick    = (NSString *)safeObjectForKey(dic, @"nickname");
        self.name    = (NSString *)safeObjectForKey(dic, @"name");

        self.head    = (NSString *)safeObjectForKey(dic, @"headporurl");
        self.thumHead    = (NSString *)safeObjectForKey(dic, @"headmini");

        self.sex =[(NSNumber *)safeObjectForKey(dic, @"sex") integerValue];
        
        self.region = (NSString *)safeObjectForKey(dic, @"region");
        self.address = (NSString *)safeObjectForKey(dic, @"address");
        
        NSInteger postcode = [(NSNumber *)safeObjectForKey(dic, @"postalcode") integerValue];
        self.postalcode = postcode>0?[NSString stringWithFormat:@"%ld",postcode]:@"";
        
         self.contactnumber1 = (NSString *)safeObjectForKey(dic, @"numberone");
        self.contactnumber2 = (NSString *)safeObjectForKey(dic, @"numbertwo");
        self.email = (NSString *)safeObjectForKey(dic, @"email");
        
        //艺人
        self.height = [(NSNumber *)safeObjectForKey(dic, @"height") integerValue];
        self.weight = [(NSNumber *)safeObjectForKey(dic, @"weight") integerValue];
        self.shoesize = [(NSNumber *)safeObjectForKey(dic, @"shoesize") integerValue];
        self.waistline = [(NSNumber *)safeObjectForKey(dic, @"waistline") integerValue];
        self.hipline = [(NSNumber *)safeObjectForKey(dic, @"hipline") integerValue];
        self.bust = [(NSNumber *)safeObjectForKey(dic, @"bust") integerValue];

        self.background = (NSString *)safeObjectForKey(dic, @"background");
        self.audit = (NSString *)safeObjectForKey(dic, @"audit");
        self.miniaudit = (NSString *)safeObjectForKey(dic, @"miniaudit");
        self.headstatus = [(NSNumber *)safeObjectForKey(dic, @"headstatus") integerValue];
        
        self.occupation = [(NSNumber *)safeObjectForKey(dic, @"occupation") integerValue];
        self.mastery = [(NSNumber *)safeObjectForKey(dic, @"mastery") integerValue];
        self.academy = (NSString *)safeObjectForKey(dic, @"academy");
        self.specialty = (NSString *)safeObjectForKey(dic, @"specialty");
        self.grade = (NSString *)safeObjectForKey(dic, @"grade");

        self.brief = (NSString *)safeObjectForKey(dic, @"brief");
        self.representativework = (NSString *)safeObjectForKey(dic, @"representativework");
        self.ageidentity = [(NSNumber *)safeObjectForKey(dic, @"ageidentity") integerValue];
        self.performtype = (NSString *)safeObjectForKey(dic, @"performtype");
        self.authorizedphoto = (NSString *)safeObjectForKey(dic, @"authorizedphoto");
        self.authorizedvideo = (NSString *)safeObjectForKey(dic, @"authorizedvideo");
        
        self.authorizationList    = (NSArray *)safeObjectForKey(dic, @"authorization");
        self.authentication = [(NSNumber *)safeObjectForKey(dic, @"authentication") integerValue];
        
        self.talentList    = (NSArray *)safeObjectForKey(dic, @"talentshow");
        self.micromirror    = (NSArray *)safeObjectForKey(dic, @"micromirror");
        self.exoticroom    = (NSArray *)safeObjectForKey(dic, @"exoticroom");
        self.mordcardList    = (NSArray *)safeObjectForKey(dic, @"modelcard");
        
        self.isCollection = [(NSNumber *)safeObjectForKey(dic, @"iscoll") boolValue];
        self.isPraise = [(NSNumber *)safeObjectForKey(dic, @"ispraise") boolValue];
        self.praises = [(NSNumber *)safeObjectForKey(dic, @"praises") integerValue];

        self.authorization1 = (NSString *)safeObjectForKey(dic, @"authorization1");
        self.authorization2 = (NSString *)safeObjectForKey(dic, @"authorization2");
        self.authorization3 = (NSString *)safeObjectForKey(dic, @"authorization3");
        self.authorization4 = (NSString *)safeObjectForKey(dic, @"authorization4");

        self.sortKey =[(NSNumber *)safeObjectForKey(dic, @"sortkey") integerValue];

        self.sortpage =[(NSNumber *)safeObjectForKey(dic, @"sortpage") integerValue];
        
        self.nationality = (NSString *)safeObjectForKey(dic, @"nationality");
        self.language = (NSString *)safeObjectForKey(dic, @"language");
        self.localism = (NSString *)safeObjectForKey(dic, @"dialect");
        self.birth = (NSString *)safeObjectForKey(dic, @"birth");
        
        self.weiboName = (NSString *)safeObjectForKey(dic, @"weiboname");
        self.weiboFans = [(NSNumber *)safeObjectForKey(dic, @"weibofans") floatValue];
        
        self.priceList    = (NSArray *)safeObjectForKey(dic, @"priceList");
        
        self.bankname = (NSString *)safeObjectForKey(dic, @"bankname");
        self.bankUser = (NSString *)safeObjectForKey(dic, @"accountname");
        
        NSInteger bankcard = [(NSNumber *)safeObjectForKey(dic, @"bankcard") integerValue];
        self.bankcard = bankcard>0?[NSString stringWithFormat:@"%ld",bankcard]:@"";
        
        self.alipay = (NSString *)safeObjectForKey(dic, @"zhifubao");
        self.alipayname = (NSString *)safeObjectForKey(dic, @"alipayname");

        self.unreadNo =[(NSNumber *)safeObjectForKey(dic, @"unreadNo") integerValue];
        
        self.performance    = (NSArray *)safeObjectForKey(dic, @"performance");
        self.acqierement    = (NSArray *)safeObjectForKey(dic, @"acqierement");
        self.pastWorksImg    = (NSArray *)safeObjectForKey(dic, @"pastWorksImg");
        self.pastWorksVdo    = (NSArray *)safeObjectForKey(dic, @"pastWorksVdo");

        self.companyname = (NSString *)safeObjectForKey(dic, @"companyname");
        self.buyername = (NSString *)safeObjectForKey(dic, @"buyername");
        
        self.creative    = (NSArray *)safeObjectForKey(dic, @"creative");

        self.actorinfo =[(NSNumber *)safeObjectForKey(dic, @"actorinfo") integerValue];
        self.modelcardType =[(NSNumber *)safeObjectForKey(dic, @"modelcardType") integerValue];
        self.talentshowType =[(NSNumber *)safeObjectForKey(dic, @"talentshowType") integerValue];
        self.micromirrorType =[(NSNumber *)safeObjectForKey(dic, @"micromirrorType") integerValue];
        self.exoticroomType =[(NSNumber *)safeObjectForKey(dic, @"exoticroomType") integerValue];
        self.pastWorksImgType =[(NSNumber *)safeObjectForKey(dic, @"pastWorksImgType") integerValue];
        self.pastWorksVdoType =[(NSNumber *)safeObjectForKey(dic, @"pastWorksVdoType") integerValue];
        self.acqierementType =[(NSNumber *)safeObjectForKey(dic, @"acqierementType") integerValue];
        self.quotationType =[(NSNumber *)safeObjectForKey(dic, @"quotationType") integerValue];
        
        self.showlist    = (NSArray *)safeObjectForKey(dic, @"showlist");

        self.internalagenttype =[(NSNumber *)safeObjectForKey(dic, @"internalagenttype") integerValue];
        self.studio =[(NSNumber *)safeObjectForKey(dic, @"studio") integerValue];
        self.rate =[(NSNumber *)safeObjectForKey(dic, @"rate") floatValue];
//***********************java新参数***********************
        self.actorAgeIdentity = [(NSNumber *)safeObjectForKey(dic, @"actorAgeIdentity") floatValue];
        self.actorOccupation = [(NSNumber *)safeObjectForKey(dic, @"actorOccupation") floatValue];
        self.actorSex = [(NSNumber *)safeObjectForKey(dic, @"actorSex") floatValue];
        self.actorStudio = [(NSNumber *)safeObjectForKey(dic, @"actorStudio") floatValue];
        self.authentication = [(NSNumber *)safeObjectForKey(dic, @"authentication") floatValue];
        self.headstatus = [(NSNumber *)safeObjectForKey(dic, @"headstatus") floatValue];
        self.mastery = [(NSNumber *)safeObjectForKey(dic, @"mastery") floatValue];
        self.actorHeadMini = (NSString *)safeObjectForKey(dic, @"actorHeadMini");
        self.actorHeadPorUrl = (NSString *)safeObjectForKey(dic, @"actorHeadPorUrl");
        self.actorName = (NSString *)safeObjectForKey(dic, @"actorName");
        self.actorNickname = (NSString *)safeObjectForKey(dic, @"actorNickname");
        self.actorRegion = (NSString *)safeObjectForKey(dic, @"actorRegion");
        self.headAudit = (NSString *)safeObjectForKey(dic, @"headAudit");
        self.headMiniAudit = (NSString *)safeObjectForKey(dic, @"headMiniAudit");
        self.showList   = (NSArray *)safeObjectForKey(dic, @"showList");
        self.praise = [(NSNumber *)safeObjectForKey(dic, @"praise") floatValue];;//点赞次数
        self.collect = [(NSNumber *)safeObjectForKey(dic, @"collect") floatValue];;//收藏次数
        self.startPrice = [(NSNumber *)safeObjectForKey(dic, @"startPrice") floatValue];;//价格
        self.userId = [(NSNumber *)safeObjectForKey(dic, @"actorId") floatValue];;//id
    }
    return self;
}

-(id)initJavaDataWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        NSDictionary *userBasicInfo = (NSDictionary*)safeObjectForKey(dic, @"userBasicInfo");  //用户基本信息
        NSDictionary *actorInfo = (NSDictionary*)safeObjectForKey(dic, @"actorInfo");   //艺人信心
        NSDictionary *buyerInfo = (NSDictionary*)safeObjectForKey(dic, @"buyerInfo");   //买家信息
        NSDictionary *userExtensionInfo = (NSDictionary*)safeObjectForKey(dic, @"userExtensionInfo");   //拓展信息

//        NSDictionary *tokenInfo = (NSDictionary*)safeObjectForKey(dic, @"tokenInfo");   //token信息
        
        //基本信息
        self.UID    = [NSString stringWithFormat:@"%ld",(long)[(NSNumber *)safeObjectForKey(userBasicInfo, @"userId") integerValue]];
        self.mobile = (NSString *)safeObjectForKey(userBasicInfo, @"phone");
        self.type = [(NSNumber *)safeObjectForKey(userBasicInfo, @"userType") integerValue];
        self.status=[(NSNumber *)safeObjectForKey(userBasicInfo, @"status") integerValue];
         self.vipLevel=[(NSNumber *)safeObjectForKey(userBasicInfo, @"vipLevel") integerValue];
        self.discount=[(NSNumber *)safeObjectForKey(userBasicInfo, @"discount") floatValue];
        
        if (self.type==1) {  //购买方
            self.address = (NSString *)safeObjectForKey(buyerInfo, @"address");
            self.head    = (NSString *)safeObjectForKey(buyerInfo, @"avatar");
            self.thumHead    = (NSString *)safeObjectForKey(buyerInfo, @"avatarMini");
            self.name    = (NSString *)safeObjectForKey(buyerInfo, @"buyerName");
            self.email = (NSString *)safeObjectForKey(buyerInfo, @"email");
            self.contactnumber1 = (NSString *)safeObjectForKey(buyerInfo, @"phone1");
            self.contactnumber2 = (NSString *)safeObjectForKey(buyerInfo, @"phone2");
            NSInteger postcode = [(NSNumber *)safeObjectForKey(buyerInfo, @"postCode") integerValue];
            self.postalcode = postcode>0?[NSString stringWithFormat:@"%ld",postcode]:@"";
            self.region = (NSString *)safeObjectForKey(buyerInfo, @"region");
            self.sex =[(NSNumber *)safeObjectForKey(buyerInfo, @"sex") integerValue];
        }
        else if (self.type==2)//资源方
        {
            self.academy = (NSString *)safeObjectForKey(actorInfo, @"academy");
            self.address = (NSString *)safeObjectForKey(actorInfo, @"address");
            self.ageidentity = [(NSNumber *)safeObjectForKey(actorInfo, @"ageIdentity") integerValue];
            self.audit    = (NSString *)safeObjectForKey(actorInfo, @"auditHead");
            self.miniaudit    = (NSString *)safeObjectForKey(actorInfo, @"auditHeadMini");
            self.head    = (NSString *)safeObjectForKey(actorInfo, @"avatar");
            self.thumHead    = (NSString *)safeObjectForKey(actorInfo, @"avatarMini");
            
            self.background    = (NSString *)safeObjectForKey(actorInfo, @"background");
            self.birth    = (NSString *)safeObjectForKey(actorInfo, @"birthday");
            self.brief = (NSString *)safeObjectForKey(actorInfo, @"brief");
            self.bust = [(NSNumber *)safeObjectForKey(actorInfo, @"chest") integerValue];
            self.localism = (NSString *)safeObjectForKey(actorInfo, @"dialect");
            self.email = (NSString *)safeObjectForKey(actorInfo, @"email");
            self.grade = (NSString *)safeObjectForKey(actorInfo, @"grade");
            self.headstatus = [(NSNumber *)safeObjectForKey(actorInfo, @"headStatus") integerValue];
            self.height = [(NSNumber *)safeObjectForKey(actorInfo, @"height") integerValue];
            self.hipline = [(NSNumber *)safeObjectForKey(actorInfo, @"hips") integerValue];
            self.language = (NSString *)safeObjectForKey(actorInfo, @"language");
            self.mastery = [(NSNumber *)safeObjectForKey(actorInfo, @"mastery") integerValue];
            self.name    = (NSString *)safeObjectForKey(actorInfo, @"name");
            self.nationality = (NSString *)safeObjectForKey(actorInfo, @"nationality");
            self.nick    = (NSString *)safeObjectForKey(actorInfo, @"nickName");
            self.occupation = [(NSNumber *)safeObjectForKey(actorInfo, @"occupation") integerValue];
            self.performtype = (NSString *)safeObjectForKey(actorInfo, @"performType");
            self.contactnumber1 = (NSString *)safeObjectForKey(actorInfo, @"phone1");
            self.contactnumber2 = (NSString *)safeObjectForKey(actorInfo, @"phone2");
            
            NSInteger postcode = [(NSNumber *)safeObjectForKey(actorInfo, @"postCode") integerValue];
            self.postalcode = postcode>0?[NSString stringWithFormat:@"%ld",postcode]:@"";
            self.region = (NSString *)safeObjectForKey(actorInfo, @"region");
            self.representativework = (NSString *)safeObjectForKey(actorInfo, @"representativeWork");
            self.sex =[(NSNumber *)safeObjectForKey(actorInfo, @"sex") integerValue];
            self.shoesize = [(NSNumber *)safeObjectForKey(actorInfo, @"shoes") integerValue];
            self.specialty = (NSString *)safeObjectForKey(actorInfo, @"specialty");
            self.waistline = [(NSNumber *)safeObjectForKey(actorInfo, @"waist") integerValue];
            self.weiboFans = [(NSNumber *)safeObjectForKey(actorInfo, @"weiboFans") floatValue];
            self.weight = [(NSNumber *)safeObjectForKey(actorInfo, @"weight") integerValue];
        }
        
        self.authentication = [(NSNumber *)safeObjectForKey(userExtensionInfo, @"authenticationStatus") integerValue];

    }
    return self;
}


@end
