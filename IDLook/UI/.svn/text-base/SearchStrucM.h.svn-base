//
//  SearchStrucM.h
//  IDLook
//
//  Created by HYH on 2018/5/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 搜索的艺人类型
 - ArtistTypeMale:男的
 */
typedef NS_ENUM(NSInteger,ArtistType)
{
    ArtistTypeMale,     //男的
    ArtistTypeFemale,   //女的
    ArtistTypeOld,      //老的
    ArtistTypeYoung,    //少的
    ArtistTypeStar,     //明星
    ArtistTypeInternetcelebrity,   //网红
    ArtistTypeWrists     //运动腕
};


/**
 筛选条件类型
 - SearchConditionTypeAge:年龄
 */
typedef NS_ENUM(NSInteger,SearchConditionType)
{
    SearchConditionTypeAge,    //年龄
    SearchConditionTypePrice,  //价格
    SearchConditionTypeCity,   //城市
    SearchConditionTypeType    //类型
};

@interface SearchStrucM : NSObject

@property (nonatomic,strong)NSMutableArray *artistArray;  //表演类型


/**
 根据艺人类型获取具体类别
 */
-(NSArray*)getArtistArrayWithType:(ArtistType)type;


/**
 根据类型返回名称
 */
+(NSString *)getArtistTypeWithType:(ArtistType)type;

/**
 根据艺人类型获取有哪些筛选条件
 */
-(NSArray*)getConditionArrayWithType:(ArtistType)type;

/**
 头部的高度
 */
-(CGFloat)heightOfHeadViewWithType:(ArtistType)type;


/**
 根据艺人类型和筛选类型得到筛选类型
 */
-(NSArray*)getConditionArrayWithType:(ArtistType)type withSearchConditionType:(SearchConditionType)subType;

@end
