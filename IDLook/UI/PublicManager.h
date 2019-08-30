//
//  PublicManager.h
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,PickerType)  //选择器类型
{
    PickerTypeHeight,        //身高
    PickerTypeWeight,        //体重
    PickerTypeBust,          //胸围
    PickerTypeWaist,         //腰围
    PickerTypeHipline,       //臀围
    PickerTypeShoeSize,       //鞋码
    PickerTypeOccupation,     //职业
    PickerTypeSchool,         //毕业院校
    PickerTypeGrade,         //年级
    PickerTypeMajor,           //专业
    PickerTypeSex,             //性别
    PickerTypeNationality,     //国籍
    PickerTypeLanguage,         //语言
    PickerTypeRegion,           //所在地
    PickerTypeTrade,          //所属行业
    PickerTypePostion,        //所属职业
    PickerTypeMastery         //专精
};

typedef NS_ENUM(NSInteger,OrderCheckType)  //下单条件类型
{
    OrderCheckTypeShotType,         //广告类别
    OrderCheckTypeDays,             //拍摄天数
    OrderCheckTypePortraitCycle,    //肖像周期
    OrderCheckTypePortraitRange,    //肖像范围
    
    OrderCheckTypeMirrCycle,        //微出镜周期
    OrderCheckTypeMirrRegion,       //微出镜区域
    OrderCheckTypeMirrRange,        //微出镜范围
    
    OrderCheckTypeMaterialCycle,      //素材使用周期
    OrderCheckTypeMaterialRegion,     //素材使用区域
    OrderCheckTypeMaterialRange,       //素材使用范围
    
    OrderCheckTypeRenewalType,       //续约类别
    OrderCheckTypeRenewalCycle,      //续约周期
    OrderCheckTypeRenewalRange       //续约范围
};

typedef NS_ENUM(NSInteger,RefreshType)
{
    RefreshTypePullDown,   //下拉刷新
    RefreshTypePullUp     //上拉刷新
};

typedef NS_ENUM(NSInteger,SourceType)   //资源类型
{
    SourceTypePhoto,    //图片
    SourceTypeVideo     //视频
};

typedef NS_ENUM(NSInteger,ScreenCellType)  //筛选条件
{
    ScreenCellTypeImage,       //形象类型(可多选)
    ScreenCellTypeAge,         //年龄（可多选）
    ScreenCellTypePrice,       //价格（可多选）
    ScreenCellTypeCity,        //城市（单选）
    ScreenCellTypeAdv,          //广告类型（可多选）
    ScreenCellTypeHeight,      //身高
    ScreenCellTypeWeight,       //体重
    ScreenCellTypeSex,          //性别
    ScreenCellTypeNationality,   //国籍
    ScreenCellTypeRole,          //角色
    ScreenCellTypeShotType          //拍摄类型
};

@interface PublicManager : NSObject

/**
 根据类型获取属性类型数组
 @param type 属性类型
 @return 数组
 */
+(NSArray*)getPickerDataWithType:(PickerType)type;


/**
 根据类型得到订单选择框内容
 @param type cell类型
 @return 数组
 */
+(NSArray*)getOrderCellType:(OrderCheckType)type;

/**
 获取视频第一帧
 @param path 视频url地址
 @return 第一帧图片
 */
+(UIImage*) getVideoPreViewImage:(NSURL *)path;


/**
 获取视频时长
 @param path 视频url地址
 @return 时长
 */
+(int)getVideoLength:(NSURL*)path;


/**
 播放器时间转换
 */
+ (NSString *)convertTime:(CGFloat)second;

/**
 *  切换横竖屏
 *
 *  @param orientation UIInterfaceOrientation
 */
+ (void)forceOrientation:(UIInterfaceOrientation)orientation;

/**
 *  是否是横屏
 *
 *  @return 是 返回yes
 */
+ (BOOL)isOrientationLandscape;


/**
 时间转化为时间戳
 @param str 时间
 @return 时间戳
 */
+(NSInteger)getDataTimeString:(NSString*)str;

/**
 根据date得到时间 2015-01-01
 @param date 日期date
 @return 时间格式
 */
+ (NSString *)string1FromDate:(NSDate *)date;

/**
 根据date得到时间 2015-01-01 10:00
 @param date 日期date
 @return 时间格式
 */
+ (NSString *)string2FromDate:(NSDate *)date;


/**
 当前时间前/后 n天的时间 ，如前30天 day=30 ，后30天，day=-30
 @param day 天数
 @return 时间
 */
+ (NSString*)getTimeWithNowDateWithDay:(NSInteger)day;

/**
根据日期得到月份
 @param date 日期
 @return 月份
 */
+ (NSInteger)getMonthWithDate:(NSDate*)date;


/**
 两个日期比较   yyyy-MM-dd格式
 @param currentDay 第一个日期
 @param BaseDay 第二个日期
 @return  -1:日期1在日期2之前  0:相同。  1:日期1在日期2之后
 */
+ (int)compareOneDay:(NSString *)currentDay withAnotherDay:(NSString *)BaseDay;

/**
 根据日期得到年份
 @param date 日期
 @return 年份
 */
+ (NSInteger)getYearWithDate:(NSDate*)date;


//获取日期的date格式
+ (NSDate *)dateFromString1:(NSString *)string;

//获取日期的date格式
+ (NSDate *)dateFromString2:(NSString *)string;

/**
 根据时间长度得到 00:00格式
 @param totalSeconds 时间长度
 @return 00:00格式时间
 */
+ (NSString *)timeFormatted:(int)totalSeconds;


/**
 根据url得到资源类型  ，图片，视频，pdf等
 @param url url
 @return 资源类型
 */
+ (SourceType)getSourceTypeWithUrl:(NSString*)url;


/**
 去掉小数后面无效的0
 @param floatValue 浮点型数字
 @return 去掉后的数值
 */
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue;
/**
 压缩图片
 @param maxLength 需要多少k以内
 @return 压缩后的image
 */
+ (UIImage *)scaleImageWithSize:(NSInteger)maxLength image:(UIImage *)image;
/**
 去除字典中的空值
 @param beforeDic 需要多少k以内
 @return 处理好的字典
 */
+ (NSMutableDictionary *)deleteAllNullValueFrom:(NSMutableDictionary *)beforeDic;
@end
