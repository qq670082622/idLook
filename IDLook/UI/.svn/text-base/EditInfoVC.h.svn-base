//
//  EditInfoVC.h
//  IDLook
//
//  Created by HYH on 2018/5/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EditType)
{
    EditTypeOther=-1,
    EditTypeWeiBoName,   //微博名
    EditTypeWeiBoFans,   //微博粉丝数
    EditTypeRegion,      //所在地
    EditTypeAddress,     //通讯地址
    EditTypePostCode,    //邮编
    EditTypeEmail,       //邮箱
    EditTypeUrgentName,   //紧急联系人
    EditTypeUrgentPhone1,   //紧急联系人电话1
    EditTypeUrgentPhone2,   //紧急联系人电话2
    EditTypeGraduatSchool,   //毕业院校
    EditTypeSpecialty,        //专业
    EditTypeNick             //艺名
};

@interface EditInfoVC : UIViewController
@property (nonatomic,copy)void(^didSelectBlock)(NSString *select);

@property(nonatomic,strong)NSDictionary *info;

@end
