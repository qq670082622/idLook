//
//  WorksModel.h
//  IDLook
//
//  Created by HYH on 2018/5/30.
//  Copyright © 2018年 HYH. All rights reserved.
//

typedef NS_ENUM(NSInteger,WorkType)
{
    WorkTypePerformance,  //试戏作品
    WorkTypePastworks,     //过往作品
    WorkTypeIntroduction,   //自我介绍
    WorkTypeMordCard        //模特卡
};

#import <Foundation/Foundation.h>

@interface WorksModel : NSObject
@property(nonatomic,copy)NSString *url;        //图片或视频url

@property(nonatomic,copy)NSString *imageurl;        //图片url(模特卡)

@property(nonatomic,copy)NSString *video;        //视频url

@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL isEdit;        //是否能编辑
@property(nonatomic,assign)BOOL isSelect;      //是否选中

@property(nonatomic,copy)NSString *cutvideo;    //视频格式时，第一帧图片

@property(nonatomic,copy)NSString *creativeid;   //作品id

@property(nonatomic,copy)NSString *type;   //作品类型

@property(nonatomic,copy)NSString *timevideo;  //视频时长

@property(nonatomic,assign)NSInteger isModelCard;     //

@property(nonatomic,assign)NSInteger role;   //角色

/************才艺作品************/
@property(nonatomic,copy)NSString *keyword;   //作品关键词

/*************微出镜，试葩间************/
@property(nonatomic,assign)NSInteger microtype;     //-1:表演类型  1:过往作品图片 2:过往作品视频  3:才艺展示

@property(nonatomic,assign)CGFloat bitrate;       //比特率

@property(nonatomic,assign)CGFloat widthpx;       //像素宽

@property(nonatomic,assign)CGFloat heightpx;       //像素高

@property(nonatomic,assign)CGFloat size;       //大小

@property(nonatomic,copy)NSString *format;   //格式
@property(nonatomic,assign)NSInteger status; //审核状态

@property(nonatomic,assign)WorkType workType;   //作品类型。

//作品数据解析
-(id)initWithWorksDic:(NSDictionary*)dic;

//微出境，试葩间数据解析
-(id)initWithMirrDic:(NSDictionary*)dic;

//过往作品
-(id)initWithPastWorkDic:(NSDictionary*)dic;

//解析模特卡，自我介绍
-(id)initModelCardDic:(NSDictionary*)dic;

@end
