//
//  ProjectModel.h
//  IDLook
//
//  Created by 吴铭 on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectModel : NSObject
@property(nonatomic,assign)BOOL canEdit;
//@property(nonatomic,assign)NSInteger number;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) NSInteger id;
@property(nonatomic,copy) NSString *projectid;//项目id
@property(nonatomic,copy) NSString *desc;//"拍摄项目描述测试2",
@property(nonatomic,copy) NSString *url;//图片url "|"隔开 [拍摄用]
@property(nonatomic,strong) NSArray *vdo;//试镜下项目中的视频内容[{"id":"","cuturl":"","videourl":"","dutation"}..]
@property(nonatomic,strong) NSArray *img;//试镜下项目中的图片内容[{"id":"","imageurl":""}...]
@property(nonatomic,copy) NSString *annexids;
@property(nonatomic,assign)NSInteger type;//1试镜 2拍摄
@property(nonatomic,copy) NSString *city; //"shanghai",
@property(nonatomic,copy) NSString *start;// "2019-01-11",
@property(nonatomic,copy) NSString *end;// "2019-01-21",
@property(nonatomic,assign)NSInteger status;//
@property(nonatomic,assign) NSInteger editstatus;//0不可以 1可以
@property(nonatomic,assign) NSInteger delstatus;//是否可以删除 0不可以 1可以
@property(nonatomic,copy) NSString *auditionend;// "2019-01-21", 最晚上传时间
@property(nonatomic,assign)NSInteger auditiondays;// 8,拍摄天数
@property(nonatomic,assign)NSInteger userid;// 16
@property(nonatomic,copy) NSString *shotcycle;//肖像周期
@property(nonatomic,copy) NSString *shotregion;//使用范围

@property(nonatomic,assign)BOOL isChoose;   //是否选中
@property(nonatomic,assign)BOOL isExpend;   //是否展开

@end

NS_ASSUME_NONNULL_END
