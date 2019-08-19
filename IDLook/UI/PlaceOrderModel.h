//
//  PlaceOrderModel.h
//  IDLook
//
//  Created by HYH on 2018/6/20.
//  Copyright © 2018年 HYH. All rights reserved.
//  试镜方式

#import <Foundation/Foundation.h>

@class OrderStructM;

@interface PlaceOrderModel : NSObject

//试镜方式
+(NSArray*)getAuditionWay;

//试镜任务要求
+(NSArray*)getAuditionRequirement;

//品牌方介绍
+(NSArray*)getBrandIntroduction;

//品牌方介绍2
+(NSArray*)getBrandIntroduction2;

//定妆方式
+(NSArray*)getShotWay;

//定妆类型
+(NSArray*)getMakeupWay;

//锁档方式
+(NSArray*)getScheduleWay;

//拍摄类别
+(NSArray*)getShotTypes;

//拍摄定装费用
+(NSArray*)getShotPrice;

//微出镜任务要求
+(NSArray*)getMirrorRequirement;

//试葩间任务要求
+(NSArray*)getTrialRequirement;

//续约内容
+(NSArray*)getRenewalContent;

//获取报价系数
+(CGFloat)getRatioWithSinglePrice:(CGFloat)price;
//新的报价系数
+(CGFloat)getRatioWithSinglePriceWithNew:(CGFloat)price;
@end

@interface OrderStructM : NSObject

@property (nonatomic,copy) NSString *title;  //标题
@property (nonatomic,copy) NSString *desc;  //描述
@property (nonatomic,copy) NSString *price;  //价格

@property (nonatomic,assign) BOOL isChoose;  //是否选中
@property (nonatomic,assign) BOOL isEdit;  //是否选中

@property (nonatomic,copy) NSString *content;  //内容

@property(nonatomic,copy)NSString *placeholder;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)NSArray *videoTypeArray;   //数组格式 @[@{@"content":@"",@"advType":@(1),@"advSubType":@(1)}];

@property(nonatomic,strong)NSDictionary *videoTypeDic;   //数组格式 @{@"dic":@{}},@"day":@(5);

-(id)initWithDic:(NSDictionary*)dic;

@end
