//
//  CenterMainCell.h
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CenterMainType)
{
    CenterMainTypePersonal,          //个人中心
    CenterMainTypeWorksUpload,       //作品上传
    CenterMainTypeAssets,            //资产管理
     CenterMainTypeVIP,            //我的VIP
    CenterMainTypePrice,            //报价管理
    CenterMainTypeMyProject,         //我的项目
    CenterMainTypeAuth,             //我的认证
    CenterMainTypeCertificate,      //我的授权书
    CenterMainTypeContact,          //联系脸探肖像
    CenterMainTypeShare,            //分享脸探
    CenterMainTypeStore,              //积分商城
    CenterMainTypeStrategy,          //脸探攻略
    CenterMainTypeStudio,          //脸探工作室
    CenterMainTypeSubAccounts,     //子账号
    CenterMainTypeRole,         //选角服务
    CenterMainTypeCoupon,          //优惠券(现在叫返现码兑换)
    CenterMainTypeGrade,           //我的评价
    CenterMainTypeInsurance,        //我的保险
    CenterMainTypeAnnunciate,      //通告
    CenterMainTypeReturnShare,      //返现码分享
};

@interface CenterMainCell : UITableViewCell
@property (nonatomic,copy)void(^CenterMainCellBlock)(NSInteger type);

@end

@interface CenterSubCell : UIView
-(void)reloadUIWithDic:(NSDictionary*)dic;
@end

