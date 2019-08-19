//
//  UserInfoManager.m
//  IDLook
//
//  Created by HYH on 2018/4/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

/*********************************************用户信息相关************************************************************/

+ (void)setUserLoginfo:(UserInfoM *)info
{
    if(info.UID)
    {        
        [[NSUserDefaults standardUserDefaults] setValue:info.UID forKey:@"Userinfo_UID"];
        [[NSUserDefaults standardUserDefaults] setValue:info.mobile forKey:@"Userinfo_mobile"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.type forKey:@"User_type"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.identity forKey:@"User_subtype"];

        
        [[NSUserDefaults standardUserDefaults] setValue:info.head forKey:@"Userinfo_head"];
        [[NSUserDefaults standardUserDefaults] setValue:info.thumHead forKey:@"Userinfo_thumHead"];
        [[NSUserDefaults standardUserDefaults] setValue:info.nick forKey:@"Userinfo_nick"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.sex forKey:@"Userinfo_sex"];
        [[NSUserDefaults standardUserDefaults] setValue:info.name forKey:@"Userinfo_realname"];
        [[NSUserDefaults standardUserDefaults] setValue:info.birth forKey:@"Userinfo_birth"];
        [[NSUserDefaults standardUserDefaults] setValue:info.nationality forKey:@"Userinfo_nationality"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.mastery forKey:@"Userinfo_mastery"];
        
        [[NSUserDefaults standardUserDefaults] setValue:info.region forKey:@"Userinfo_region"];
        [[NSUserDefaults standardUserDefaults] setValue:info.address forKey:@"Userinfo_address"];
        [[NSUserDefaults standardUserDefaults] setValue:info.postalcode forKey:@"Userinfo_postalcode"];
        [[NSUserDefaults standardUserDefaults] setValue:info.contactnumber1 forKey:@"Userinfo_number1"];
        [[NSUserDefaults standardUserDefaults] setValue:info.contactnumber2 forKey:@"Userinfo_number2"];
        [[NSUserDefaults standardUserDefaults] setValue:info.email forKey:@"Userinfo_email"];

        [[NSUserDefaults standardUserDefaults] setInteger:info.height forKey:@"Userinfo_basic_0"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.weight forKey:@"Userinfo_basic_1"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.bust forKey:@"Userinfo_basic_2"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.waistline forKey:@"Userinfo_basic_3"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.hipline forKey:@"Userinfo_basic_4"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.shoesize forKey:@"Userinfo_basic_5"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.ageidentity forKey:@"Userinfo_agetype"];

        [[NSUserDefaults standardUserDefaults] setValue:info.background forKey:@"Userinfo_background"];
        [[NSUserDefaults standardUserDefaults] setValue:info.audit forKey:@"Userinfo_audit"];
        [[NSUserDefaults standardUserDefaults] setValue:info.miniaudit forKey:@"Userinfo_miniaudit"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.headstatus forKey:@"Userinfo_headstatus"];
        
        [[NSUserDefaults standardUserDefaults] setInteger:info.occupation forKey:@"Userinfo_occupation"];
        [[NSUserDefaults standardUserDefaults] setValue:info.academy forKey:@"Userinfo_schoolInfo"];
        [[NSUserDefaults standardUserDefaults] setValue:info.grade forKey:@"Userinfo_grade"];
        [[NSUserDefaults standardUserDefaults] setValue:info.specialty forKey:@"Userinfo_specialty"];
        [[NSUserDefaults standardUserDefaults] setValue:info.language forKey:@"Userinfo_language"];
        [[NSUserDefaults standardUserDefaults] setValue:info.localism forKey:@"Userinfo_localism"];

        [[NSUserDefaults standardUserDefaults] setValue:info.brief forKey:@"Userinfo_brief"];
        [[NSUserDefaults standardUserDefaults] setValue:info.representativework forKey:@"Userinfo_works"];
        [[NSUserDefaults standardUserDefaults] setValue:info.performtype forKey:@"Userinfo_perform"];
        [[NSUserDefaults standardUserDefaults] setValue:info.authorizedphoto forKey:@"Userinfo_authorizedphoto"];
        [[NSUserDefaults standardUserDefaults] setValue:info.authorizedvideo forKey:@"Userinfo_authorizedvideo"];
        
        [[NSUserDefaults standardUserDefaults] setInteger:info.authentication forKey:@"authentication"];
        
        [[NSUserDefaults standardUserDefaults] setValue:info.weiboName forKey:@"Userinfo_sina"];
        [[NSUserDefaults standardUserDefaults] setFloat:info.weiboFans forKey:@"Userinfo_fans"];

        [[NSUserDefaults standardUserDefaults] setValue:info.bankcard forKey:@"Userinfo_bankcard"];
        [[NSUserDefaults standardUserDefaults] setValue:info.bankname forKey:@"Userinfo_bankname"];
        [[NSUserDefaults standardUserDefaults] setValue:info.bankUser forKey:@"Userinfo_user"];
        
        [[NSUserDefaults standardUserDefaults] setValue:info.companyname forKey:@"Userinfo_companyname"];
        [[NSUserDefaults standardUserDefaults] setValue:info.buyername forKey:@"Userinfo_buyername"];

        [[NSUserDefaults standardUserDefaults] setValue:info.alipay forKey:@"Userinfo_alipay"];
        [[NSUserDefaults standardUserDefaults] setValue:info.alipayname forKey:@"Userinfo_alipayName"];

        [[NSUserDefaults standardUserDefaults] setInteger:info.actorinfo forKey:@"Userinfo_complet_0"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.modelcardType forKey:@"Userinfo_complet_1"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.talentshowType forKey:@"Userinfo_complet_2"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.micromirrorType forKey:@"Userinfo_complet_3"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.exoticroomType forKey:@"Userinfo_complet_4"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.pastWorksImgType forKey:@"Userinfo_complet_5"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.pastWorksVdoType forKey:@"Userinfo_complet_6"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.acqierementType forKey:@"Userinfo_complet_7"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.quotationType forKey:@"Userinfo_complet_8"];
        [[NSUserDefaults standardUserDefaults] setInteger:info.studio forKey:@"Userinfo_studio"];
        
        [[NSUserDefaults standardUserDefaults] setInteger:info.unreadNo forKey:@"Userinfo_unreadcount"];
        
        if (info.authorizationList) {
            [[NSUserDefaults standardUserDefaults] setObject:info.authorizationList forKey:@"Userinfo_authorizationlist"];
        }
        

        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)clearUserLoginfo
{
    
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"Userinfo_loginType"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"User_type"];
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"User_subtype"];

    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"thirdPartyLogin_openid"];
    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_UID"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_mobile"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_pwd"];
    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_head"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_thumHead"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_nick"];
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"Userinfo_sex"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_realname"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_birth"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_nationality"];

    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_region"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_address"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_postalcode"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_number1"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_number2"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_email"];

    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_background"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_audit"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_miniaudit"];
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"Userinfo_headstatus"];
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"Userinfo_mastery"];

    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_basic_0"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_basic_1"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_basic_2"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_basic_3"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_basic_4"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_basic_5"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_agetype"];

    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_occupation"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_schoolInfo"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_grade"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_specialty"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_language"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_localism"];

    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_brief"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_works"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_perform"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_authorizedphoto"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_authorizedvideo"];

    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Userinfo_authorizationlist"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_auth"];
    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_sina"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"Userinfo_fans"];

    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_bankcard"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_bankname"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_user"];
     
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_unreadcount"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_companyname"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_buyername"];

    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_alipay"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Userinfo_alipayName"];

    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_0"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_1"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_2"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_3"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_4"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_5"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_6"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_7"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_complet_8"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_studio"];
     [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_status"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Userinfo_discount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setUserLoginType:(UserLoginType)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:@"Userinfo_loginType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (UserLoginType)getUserLoginType
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_loginType"];
    if(obj==nil)
    {
        return -1;
    }
    return [obj integerValue];
}

+ (UserLoginType)checkWhetherHasLogined
{
    UserLoginType type = [UserInfoManager getUserLoginType];
    if(type==UserLoginTypeMobile)
    {
        NSString *mobile = [UserInfoManager getUserMobile];
        NSString *pwd = [UserInfoManager getUserPwd];
        if([mobile length]&&[pwd length])
        {
            return type;
        }
    }
    else
    {
        NSString *openId = [UserInfoManager getUserOpenID];
        if([openId length])
        {
            return type;
        }
    }
    return -1;
}

//公共基础配置
+ (void)setPublicConfig:(NSDictionary *)config
{
    [[NSUserDefaults standardUserDefaults] setObject:config forKey:@"public_config"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+ (NSDictionary *)getPublicConfig
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"public_config"];
    return dic==nil?@{}:dic;
}

//UID
+ (void)setUserUID:(NSString *)UID
{
    [[NSUserDefaults standardUserDefaults] setObject:UID forKey:@"Userinfo_UID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserUID
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_UID"];
    return result==nil?@"":result;
}

//手机号
+ (void)setUserMobile:(NSString *)phoneNum
{
    [[NSUserDefaults standardUserDefaults] setObject:phoneNum forKey:@"Userinfo_mobile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserMobile
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_mobile"];
    return result==nil?@"":result;
}

//密码
+ (void) setUserPwd:(NSString *)pwd
{
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"Userinfo_pwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserPwd
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_pwd"];
    return result==nil?@"":result;
}

//第三方登录openID
+ (void)setUserOpenID:(NSString *)openID
{
    [[NSUserDefaults standardUserDefaults] setObject:openID forKey:@"thirdPartyLogin_openid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserOpenID
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"thirdPartyLogin_openid"];
    return result==nil?@"":result;
}

//用户类型
+ (void)setUserType:(UserType)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:@"User_type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (UserType)getUserType
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_type"];
    if(obj==nil)return 0;
    return [obj integerValue];
}

//用户子类型
+ (void)setUserSubType:(UserSubType)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:@"User_subtype"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (UserSubType)getUserSubType
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_subtype"];
    if(obj==nil)return -1;
    return [obj integerValue];
}

//用户头像
+ (void)setUserHead:(NSString *)head
{
    [[NSUserDefaults standardUserDefaults] setObject:head forKey:@"Userinfo_head"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserHead
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_head"];
    return result==nil?@"":result;
}

//用户昵称
+ (void)setUserNick:(NSString *)nick
{
    [[NSUserDefaults standardUserDefaults] setObject:nick forKey:@"Userinfo_nick"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserNick
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_nick"];
    return result==nil?@"":result;
}

//用户真实姓名
+ (void)setUserRealName:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"Userinfo_realname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserRealName
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_realname"];
    return result==nil?@"":result;
}

//用户出生日期
+ (void)setUserBirth:(NSString *)birth
{
    [[NSUserDefaults standardUserDefaults] setObject:birth forKey:@"Userinfo_birth"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserBirth
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_birth"];
    return result==nil?@"":result;
}

//用户国籍
+ (void)setUserNationality:(NSString *)nationality
{
    [[NSUserDefaults standardUserDefaults] setObject:nationality forKey:@"Userinfo_nationality"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserNationality
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_nationality"];
    return result==nil?@"":result;
}

//性别
+ (void)setUserSex:(NSInteger)sex
{
    [[NSUserDefaults standardUserDefaults] setInteger:sex forKey:@"Userinfo_sex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserSex
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_sex"];
    if(obj==nil)return -1;
    return [obj integerValue];
}

//所在地
+ (void)setUserRegion:(NSString *)region
{
    [[NSUserDefaults standardUserDefaults] setObject:region forKey:@"Userinfo_region"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserRegion
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_region"];
    return result==nil?@"":result;
}

//通讯地址
+ (void)setUserAddress:(NSString *)address
{
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"Userinfo_address"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserAddress
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_address"];
    return result==nil?@"":result;
}

//邮编
+ (void)setUserPostalCode:(NSString*)code
{
    [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"Userinfo_postalcode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString*)getUserPostalCode
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_postalcode"];
    return result==nil?@"":result;
}

//联系电话1
+ (void)setUserContactnumber1:(NSString *)number
{
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"Userinfo_number1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserContactnumber1
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_number1"];
    return result==nil?@"":result;
}

//联系电话2
+ (void)setUserContactnumber2:(NSString *)number
{
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"Userinfo_number2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserContactnumber2
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_number2"];
    return result==nil?@"":result;
}

//邮箱
+ (void)setUserEmail:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"Userinfo_email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserEmail
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_email"];
    return result==nil?@"":result;
}


//艺人用户基本资料   身高，体重，胸围，腰围，臀围，鞋码
+ (void)setUserBasicInfo:(NSInteger)value WithType:(PickerType)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:[NSString stringWithFormat:@"Userinfo_basic_%ld",type]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserBasicInfoWithType:(PickerType)type
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Userinfo_basic_%ld",type]];
    if(obj==nil)return 0;
    return [obj integerValue];
}

//艺人职业
+ (void)setUserOccupation:(NSInteger)occupation
{
    [[NSUserDefaults standardUserDefaults] setInteger:occupation forKey:@"Userinfo_occupation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserOccupation
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_occupation"];
    if(obj==nil)return 0;
    return [obj integerValue];
}

//专精
+ (void)setUserMastery:(NSInteger)mastery
{
    [[NSUserDefaults standardUserDefaults] setInteger:mastery forKey:@"Userinfo_mastery"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserMastery
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_mastery"];
    if(obj==nil)return -1;
    return [obj integerValue];
}

//艺人毕业院校
+ (void)setUserSchoolInfo:(NSString *)info
{
    [[NSUserDefaults standardUserDefaults] setValue:info forKey:@"Userinfo_schoolInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserSchoolInfo
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_schoolInfo"];
    return result==nil?@"":result;
}

//艺人年级
+ (void)setUserGrade:(NSString *)grade
{
    [[NSUserDefaults standardUserDefaults] setValue:grade forKey:@"Userinfo_grade"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserGrade
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_grade"];
    return result==nil?@"":result;
}

//艺人专业
+ (void)setUserSpecialty:(NSString *)specialty
{
    [[NSUserDefaults standardUserDefaults] setValue:specialty forKey:@"Userinfo_specialty"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserSpecialty
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_specialty"];
    return result==nil?@"":result;
}

//艺人主页头像
+ (void)setUserBackGround:(NSString *)background
{
    [[NSUserDefaults standardUserDefaults] setValue:background forKey:@"Userinfo_background"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserBackGround
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_background"];
    return result==nil?@"":result;
}

//艺人审核头像
+ (void)setUserAudit:(NSString *)audit
{
    [[NSUserDefaults standardUserDefaults] setValue:audit forKey:@"Userinfo_audit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserAudit
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_audit"];
    return result==nil?@"":result;
}

//艺人审核头像缩略图
+ (void)setUserMiniaudit:(NSString *)miniaudit
{
    [[NSUserDefaults standardUserDefaults] setValue:miniaudit forKey:@"Userinfo_miniaudit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserMiniaudit
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_miniaudit"];
    return result==nil?@"":result;
}

//艺人头像审核状态
+ (void)setUserHeadstatus:(NSInteger)headstatus
{
    [[NSUserDefaults standardUserDefaults] setInteger:headstatus forKey:@"Userinfo_headstatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserHeadstatus
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_headstatus"];
    if(obj==nil)return -1;
    return [obj integerValue];
}

//代表作品
+ (void)setUserTypicalworks:(NSString *)works
{
    [[NSUserDefaults standardUserDefaults] setValue:works forKey:@"Userinfo_works"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserTypicalworks
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_works"];
    return result==nil?@"":result;
}

//简介
+ (void)setUserBrief:(NSString *)brief
{
    [[NSUserDefaults standardUserDefaults] setValue:brief forKey:@"Userinfo_brief"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserBrief
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_brief"];
    return result==nil?@"":result;
}

//所属身份年龄段
+ (void)setUserAgeType:(NSInteger)age
{
    [[NSUserDefaults standardUserDefaults] setInteger:age forKey:@"Userinfo_agetype"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserAgeType
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_agetype"];
    if(obj==nil)return -1;
    return [obj integerValue];
}

//擅长表演类型
+(void)setPerformingTypes:(NSString*)type
{
    [[NSUserDefaults standardUserDefaults] setValue:type forKey:@"Userinfo_perform"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getPerformingTypes
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_perform"];
    return result==nil?@"":result;
}

//可开放微出镜图片类别
+(void)setExploitableMirrPhotos:(NSString *)type
{
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:@"Userinfo_authorizedphoto"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getExploitableMirrPhotos
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_authorizedphoto"];
    return result==nil?@"":result;
}

//可开放微出镜视频类别
+(void)setExploitableMirrVideos:(NSString *)type
{
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:@"Userinfo_authorizedvideo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getExploitableMirrVideos
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_authorizedvideo"];
    return result==nil?@"":result;
}


//授权书列表
+(void)setUserAuthorizationList:(NSArray*)list
{
    if(![list count])return;
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"Userinfo_authorizationlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSArray*)getUserAuthorizationList
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"Userinfo_authorizationlist"];
    if(obj==nil)return nil;
    else return (NSArray *)obj;
}

//认证状态
+ (void)setUserAuthState:(NSInteger)auth
{
    [[NSUserDefaults standardUserDefaults] setInteger:auth forKey:@"authentication"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserAuthState
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"];//Userinfo_auth
    if(obj==nil)return 0;
    return [obj integerValue];
}
//认证状态 _wm
+ (void)setUserAuthState_wm:(NSInteger)auth
{
    [[NSUserDefaults standardUserDefaults] setInteger:auth forKey:@"authentication"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserAuthState_wm
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"];
    if(obj==nil)return 0;
    return [obj integerValue];
}
//微博名字
+(void)setUserSinaName:(NSString*)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"Userinfo_sina"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserSinaName
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_sina"];
    return result==nil?@"":result;
}

//微博粉丝数，万为单位
+ (void)setUserSinaFansNumber:(CGFloat)number
{
    [[NSUserDefaults standardUserDefaults] setFloat:number forKey:@"Userinfo_fans"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (CGFloat)getUserSinaFansNumber
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_fans"];
    if(obj==nil)return 0;
    return [obj floatValue];
}

//银行卡号
+(void)setUserBankCard:(NSString*)bankcard
{
    [[NSUserDefaults standardUserDefaults] setObject:bankcard forKey:@"Userinfo_bankcard"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserBankCard
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_bankcard"];
    return result==nil?@"":result;
}

//开户行
+(void)setUserBankName:(NSString*)bankName
{
    [[NSUserDefaults standardUserDefaults] setObject:bankName forKey:@"Userinfo_bankname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserBankName
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_bankname"];
    return result==nil?@"":result;
}

//银行卡户名
+(void)setUserBankUser:(NSString*)user
{
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"Userinfo_user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserBankUser
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_user"];
    return result==nil?@"":result;
}

//支付宝账号
+(void)setUserAlipay:(NSString*)alipay
{
    [[NSUserDefaults standardUserDefaults] setObject:alipay forKey:@"Userinfo_alipay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserAlipay
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_alipay"];
    return result==nil?@"":result;
}

//支付宝姓名
+(void)setUserAlipayName:(NSString*)alipayName
{
    [[NSUserDefaults standardUserDefaults] setObject:alipayName forKey:@"Userinfo_alipayName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUseralipayName
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_alipayName"];
    return result==nil?@"":result;
}


//未读系统消息个数
+ (void)setUnreadCount:(NSInteger)count
{
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"Userinfo_unreadcount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUnreadCount
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_unreadcount"];
    if(obj==nil)return 0;
    return [obj integerValue];
}

//搜索历史
+(void)setSearchHistory:(NSArray*)array
{
    //    if(![array count])return;
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"Search_history"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSArray*)getSearchHistoryType
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"Search_history"];
    if(obj==nil)return nil;
    else return (NSArray *)obj;
}

//公司名称
+(void)setUserCompanyName:(NSString*)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"Userinfo_companyname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserCompanyName
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_companyname"];
    return result==nil?@"":result;
}

//管理员名字
+(void)setUserBuyerName:(NSString*)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"Userinfo_buyername"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserBuyerName
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_buyername"];
    return result==nil?@"":result;
}

//语言
+(void)setUserLanguage:(NSString*)language
{
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"Userinfo_language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserLanguage
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_language"];
    return result==nil?@"":result;
}

//方言
+(void)setUserLocalism:(NSString*)localism
{
    [[NSUserDefaults standardUserDefaults] setObject:localism forKey:@"Userinfo_localism"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getUserLocalism
{
    NSString *result = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_localism"];
    return result==nil?@"":result;
}

//是否工作室演员
+ (void)setUserStudio:(NSInteger)studio
{
    [[NSUserDefaults standardUserDefaults] setInteger:studio forKey:@"Userinfo_studio"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserStudio
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_studio"];
    if(obj==nil)return 0;
    return [obj integerValue];
}

//艺人是否资料完善类型
+ (void)setUserCompletInfo:(NSInteger)value WithType:(NSInteger)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:[NSString stringWithFormat:@"Userinfo_complet_%ld",type]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserCompletInfoWithType:(NSInteger)type
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Userinfo_complet_%ld",type]];
    if(obj==nil)return 0;
    return [obj integerValue];
}

//是否显示底部认证
+ (void)setAuthBottomShow:(BOOL)show
{
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:[NSString stringWithFormat:@"%@_authshow",[UserInfoManager getUserUID]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getAuthBottom
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@_authshow",[UserInfoManager getUserUID]]];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//用户状态和vip状况
+ (void)setUserStatus:(NSInteger)status//开头表示用户状态; 100正常，101注销，102待审核，104黑名单;2开头表示用户等级; 200普通用户，201VIP战略合作公司，202VIP制片
{
    [[NSUserDefaults standardUserDefaults] setInteger:status forKey:@"Userinfo_status"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getUserStatus
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_status"];
    if(obj==nil)return 100;
    return [obj integerValue];
}

//购买方折扣率
+ (void)setUserDiscount:(float)discount
{
    [[NSUserDefaults standardUserDefaults] setFloat:discount forKey:@"Userinfo_discount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (float)getUserDiscount
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userinfo_discount"];
    if(obj==nil)return 1;
    return [obj floatValue];
}

/**********************************************************用户设置***********************************************************/

//新消息通知
+ (void)setMsgNotify:(BOOL)notify
{
    [[NSUserDefaults standardUserDefaults] setBool:notify forKey:[NSString stringWithFormat:@"%@_NewMsg",[UserInfoManager getUserUID]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getMsgNotify
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@_NewMsg",[UserInfoManager getUserUID]]];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//声音
+ (void)setUserSoundOn:(BOOL)on
{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:[NSString stringWithFormat:@"%@_sound",[UserInfoManager getUserUID]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getSoundStatus;
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@_sound",[UserInfoManager getUserUID]]];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//震动
+ (void)setUserVibirateOn:(BOOL)on
{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:[NSString stringWithFormat:@"%@_vibirate",[UserInfoManager getUserUID]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getUserVibirateStatus
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@_vibirate",[UserInfoManager getUserUID]]];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//4g网络下 是否自动播放
+ (void)setWWanAuthPlay:(BOOL)play
{
    [[NSUserDefaults standardUserDefaults] setBool:play forKey:@"Setting_wwanplay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getWWanAuthPlay
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Setting_wwanplay"];
    if(obj==nil)return NO;
    return [obj boolValue];
}

//4g网络下 是否每次询问
+ (void)setAskEachTime:(BOOL)ask
{
    [[NSUserDefaults standardUserDefaults] setBool:ask forKey:@"Setting_askeach"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getAskEachTime
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Setting_askeach"];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//是否自动播放 wifi网络下
+ (void)setWifiAuthPlay:(BOOL)play
{
    [[NSUserDefaults standardUserDefaults] setBool:play forKey:@"Setting_wifiautoplay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getWifiAuthPlay
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Setting_wifiautoplay"];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//是否第一次设置网络
+ (void)setNetworkSettingFirst:(BOOL)first
{
    [[NSUserDefaults standardUserDefaults] setBool:first forKey:@"Setting_networkfirst"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getNetworkSettingFirst
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Setting_networkfirst"];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//列表播放是否静音
+ (void)setListPlayIsMute:(BOOL)mute
{
    [[NSUserDefaults standardUserDefaults] setBool:mute forKey:@"Setting_listplay_mute"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getListPlayIsMute
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Setting_listplay_mute"];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//是否弹出优惠券说明弹窗
+ (void)setPopupCoupon:(BOOL)pop
{
    [[NSUserDefaults standardUserDefaults] setBool:pop forKey:@"Setting_coupon"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getPopupCoupon
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"Setting_coupon"];
    if(obj==nil)return YES;
    return [obj boolValue];
}

//图片压缩比例
+ (void)setScaleRatio:(NSString *)ratio
{
    [[NSUserDefaults standardUserDefaults] setObject:ratio forKey:@"scaleRatio"];
      [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getScaleRatio
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"scaleRatio"];
    if(obj==nil)return 100;
    return [obj integerValue] ;
}
+ (void)setFirstLauch
{
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"lauched"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getFirstLauch
{
    NSString *obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"lauched"];
    if([obj isEqualToString:@"yes"])return NO;//说明已经启动过了，所以才会存yes
    return YES ;
}
+ (void)setIsJavaService:(BOOL)isJava
{
    if (isJava) {
         [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isJavaService"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isJavaService"];
    }
   
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsJavaService
{
    NSString *obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"isJavaService"];
    if([obj isEqualToString:@"yes"]){
    return YES ;
    }
    return NO;
}
//存取token
+ (void)setAccessToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"accessToken"];
 [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getAccessToken
{
     NSString *obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];
    if (obj) {
        return obj;
    }else{
        return @"";
    }
}
//存取refreshToken
+ (void)setRefreshToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"refreshToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getRefreshToken
{
    NSString *obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"refreshToken"];
    if (obj) {
        return obj;
    }else{
        return @"";
    }
}
//存取上次视频播放时间
+(void)setLastestVideoPlayTime:(long)time
{
    [[NSUserDefaults standardUserDefaults]setInteger:time forKey:@"lastTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(long)getLastedVideoPlayTime
{
    id obj = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastTime"];
    if(obj==nil)return 100;
    return [obj integerValue];
}




@end
