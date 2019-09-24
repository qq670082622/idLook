//
//  UserDetialInfoM.h
//  IDLook
//
//  Created by Mr Hu on 2019/3/7.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetialInfoM : NSObject

@property (nonatomic,assign) NSInteger actorId;           //用户唯一标识
@property (nonatomic,strong) NSDictionary *priceInfo;  //报价信息
@property (nonatomic,strong) NSDictionary *commentInfo;  //评分信息
@property (nonatomic,strong) NSDictionary *lastComment;  //评论
@property (nonatomic,strong) NSArray *worksList;  //作品信息
@property (nonatomic,strong) NSArray *fansInfo;  //粉丝信息
/***********************basicInfo***************************************/
@property (nonatomic,copy) NSString *actorName;          //名字
@property (nonatomic,copy) NSString *avatar;            //头像
@property (nonatomic,copy) NSString *birthday;          //生日
@property (nonatomic,copy) NSString *nickName;          //艺名
@property (nonatomic,assign) NSInteger sex;         //性别
@property (nonatomic,copy) NSString *region;           //所在地
@property (nonatomic,copy) NSString *language;             //语言
@property (nonatomic,copy)NSString *nationality;    //国籍
@property (nonatomic,assign) NSInteger height;      //身高
@property (nonatomic,assign) NSInteger weight;      //体重
@property (nonatomic,assign) NSInteger shoes;      //鞋码
@property (nonatomic,assign) NSInteger waist;      //腰围
@property (nonatomic,assign) NSInteger chest;      //胸围
@property (nonatomic,assign) NSInteger hips;      //臀围
@property (nonatomic,assign) NSInteger actorStudio;  //是否工作室演员
@property (nonatomic,assign) NSInteger authentication;//认证状态 默认为0未提交，1已审核，2审核失败，3.审核中

/***********************professionInfo***************************************/
@property (nonatomic,assign)NSInteger occupation;             //职业
@property (nonatomic,assign)NSInteger mastery;             //专精  //1广告演员；2影视演员；3外模  4.前景演员
@property (nonatomic,copy) NSString *academy;             //毕业院校
@property (nonatomic,copy) NSString *grade;               //年级
@property (nonatomic,copy) NSString *major;             //专业
@property (nonatomic,copy) NSString *brief;               //简介
@property (nonatomic,copy) NSString *representativeWork;  //代表作品
@property (nonatomic,copy) NSString *performType;  //擅长表演类型

/***********************popularInfo***************************************/
@property (nonatomic,assign) NSInteger collect;     //收藏数量
@property (nonatomic,assign) BOOL isPraise;  //是否点赞
@property (nonatomic,assign) BOOL isCollect;  //是否收藏
@property (nonatomic,assign) NSInteger weiboFans;  //微博粉丝数
@property (nonatomic,assign) NSInteger praise;     //点赞数量

/***********************accountInfo 账户信息***************************************/
@property (nonatomic,copy) NSString *aliPayId;  //支付宝账号
@property (nonatomic,copy) NSString *bankCardNo;  //银行卡号
@property (nonatomic,copy) NSString *bankName;  //银行名

@property(nonatomic,assign)BOOL unlockingPrice;//是否解锁 yes解锁 no未解锁

-(id)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
