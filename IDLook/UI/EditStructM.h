//
//  EditStructM.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,UserInfoType)
{
    UserInfoTypeRealName,          //真是姓名
    UserInfoTypeBirth,             //出生日期
    UserInfoTypeSex,              //性别
    UserInfoTypeNationtitly,      //国籍
    UserInfoTypeNick,            //展示名
    UserInfoTypeLanguage,        //语言
    UserInfoTypeLocalism,        //方言
    UserInfoTypeHeight,          //身高
    UserInfoTypeWeight,          //体重
    UserInfoTypeBust,           //胸围
    UserInfoTypeWaist,          //腰围
    UserInfoTypeHipline,        //臀围
    UserInfoTypeShoeSize,       //鞋码
    UserInfoTypeOccupation,     //职业
    UserInfoTypeMastery,        //专精
    UserInfoTypeSchool,         //毕业院校
    UserInfoTypeGrade,          //年级
    UserInfoTypeMajor,         //专业
    UserInfoTypeRegion,         //所在地
    UserInfoTypeAddress,        //通讯地址
    UserInfoTypePostcode,       //邮编
    UserInfoTypeEmail,          //邮箱
    UserInfoTypeContactName,     //紧急联系人
    UserInfoTypeContactPhone,    //紧急联系人电话
    UserInfoTypeAge,             //所属身份年龄段
    UserInfoTypeGoodatType,      //擅长表演类型
    UserInfoTypeBrief,            //简介
    UserInfoTypeRepresentative,     //代表作品
    UserInfoTypeOther   //其他
    
};

@interface EditStructM : NSObject

/**
 标题
 */
@property(nonatomic,copy)NSString *title;

/**
 内容
 */
@property(nonatomic,copy)NSString *content;

/**
 占位文字
 */
@property(nonatomic,copy)NSString *placeholder;

/**
 是否显示箭头
 */
@property(nonatomic,assign)BOOL isShowArrow;

/**
 是否必填项
 */
@property(nonatomic,assign)BOOL IsMustInput;

/**
 是否可编辑
 */
@property(nonatomic,assign)BOOL isEdit;

/**
 类型
 */
@property(nonatomic,assign)UserInfoType type;

/**
 参数名称
 */
@property(nonatomic,copy)NSString *parameter;


-(id)initWithDic:(NSDictionary*)dic;

@end
