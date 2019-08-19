//
//  projectModel2.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectModel2 : NSObject
@property(nonatomic,assign) NSInteger Allevaluate;//1,未评价 2，部分评价 3，全部评价

@property(nonatomic,copy) NSString *Annexids;//id拼接字符串

@property(nonatomic,assign) NSInteger shotDays;//拍摄天数

@property(nonatomic,copy) NSString *projectAuditionEnd;//最晚上传作品日期

@property(nonatomic,copy) NSString *projectCity;//拍摄城市

@property(nonatomic,copy) NSString *projectDesc;//项目简介

@property(nonatomic,assign) double projectDocumentaryprice;//跟单费

@property(nonatomic,copy) NSString *projectEnd;//拍摄日期结束

@property(nonatomic,copy) NSString *projectId;//项目编号

@property(nonatomic,copy) NSString *projectName;//项目名称

@property(nonatomic,copy) NSString *shotCycle;//肖像周期 1：1周 2：1月 3：1季 4：半年 5：1年 6：2年 7：3年 8：4年 9：5年

@property(nonatomic,copy) NSString *shotRegion;//肖像范围

@property(nonatomic,copy) NSString *projectStart;//拍摄日期开始

@property(nonatomic,assign) NSInteger projectStatus;//1正常，2进行中（能查看不能编辑）

@property(nonatomic,assign) NSInteger projectType;//1试镜项目，2,拍摄项目

@property(nonatomic,copy) NSString *projectUrl;//项目脚本

//@property(nonatomic,strong) NSArray *vdo;//试镜下项目中的视频内容[{"id":"","cuturl":"","videourl":"","dutation"}..]
//
//@property(nonatomic,strong) NSArray *img;//试镜下项目中的图片内容[{"id":"","imageurl":""}...]
@property(nonatomic,strong) NSArray *projectScriptList;//{"cutUrl": "string","duration": 0,"id": 0,"type": "1:图片; 2:视频","url": "string"}
@property(nonatomic,strong) NSArray *roleList;//角色列表
@property(nonatomic,strong) NSArray *castings;//角色[{"name":"","sex":"","heightStart":"","heightEnd":"","type":"阳光","remark":""},{}..]
@property(nonatomic,assign) NSInteger UserId;//购买方id

@end

NS_ASSUME_NONNULL_END
