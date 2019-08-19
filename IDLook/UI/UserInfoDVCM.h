//
//  UserInfoDVCM.h
//  IDLook
//
//  Created by HYH on 2018/5/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUserInfoDVCMCellClass;    //cell类名_键
extern NSString * const kUserInfoDVCMCellHeight;   //cell高度_键
extern NSString * const kUserInfoDVCMCellType;     //cell类型_键
extern NSString * const kUserInfoDVCMCellData;     //数据

typedef NS_ENUM(NSInteger,UserInfoCellDType)
{
    UserInfoCellDTypeCertificate,    //授权书
    UserInfoCellDTypeModelCard,        //形象展示
    UserInfoCellDTypeBasicinfo,    //基本信息
    UserInfoCellDTypeSchool,  //毕业院校
    UserInfoCellDTypeBrief,    //简介
    UserInfoCellDTypeWorks    //代表作品
};

@interface UserInfoDVCM : NSObject

@property(nonatomic,strong)UserDetialInfoM *info;

@property (nonatomic,strong)NSMutableArray *ds;

- (void)refreshUserInfo;

@end