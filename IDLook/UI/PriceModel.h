//
//  PriceModel.h
//  IDLook
//
//  Created by HYH on 2018/7/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceModel : NSObject

/**
 标题
 */
@property(nonatomic,copy)NSString *title;

/**
 广告类型
 1：视频 2：平面 3：活动  4试镜
 */
@property(nonatomic,assign)NSInteger type;

/**
 广告子类型
  11TVC，12Video宣传，13微电影；
 21全平面，22内部宣传，23产品包装；
 31发布会，32年会，33车展，34路演，35庆典，36走秀
 41自备场地 42影棚试镜 43手机快速试镜 
 */
@property(nonatomic,assign)NSInteger subType;

/**
 价格
 */
@property(nonatomic,assign)NSInteger price;

/**
 天数
 */
@property(nonatomic,assign)NSInteger day;

/**
 报价id
 */
@property(nonatomic,assign)NSInteger creativeid;
/**
老价格 通过这个判断是不是修改报价
 */

@property(nonatomic,assign)NSInteger waitPrice;
/**
审核完成价格：即当前有效价格
 */
@property(nonatomic,copy)NSString *singleprice;
/**
 状态： 单项报价审核中状态默认 0.未审核  :1.审核中  2.审核完成 3.审核失败，4.删除，5留档',
 */
@property(nonatomic,assign)NSInteger examinestate;
/**
 删除状态：0新增审核 1，待删除，2，已删除，3，删除审核失败',4.修改审核中
 */
@property(nonatomic,assign)NSInteger status;
-(id)initWithDic:(NSDictionary*)dic;

//删除审核：state==1 /增加审核 state==0 ex==1  /修改审核 state==4 ex==1


//需求一共“1.新增审核 2.修改审核 3.删除审核 4正常  其中2、4可修改
//1:price无值，ex=1  2:price有值 ex=1 3:state=1
//************java******************
@property(nonatomic,assign)NSInteger examPrice;//审核中报价
@property(nonatomic,assign)NSInteger salePrice;//展示中报价
@property(nonatomic,assign)NSInteger examineState;//状态11=新建报价审核中；12=修改报价审核中；13=删除报价审核中；21=新建报价审核通过；22=修改报价审核完成；23=删除报价审核通过；31=新建报价审核失败；32=修改报价审核失败；33=删除报价审核失败
@property(nonatomic,assign)NSInteger quotationId;//a报价id
@property(nonatomic,assign)NSInteger singleType;//"11=视频；21=平面；41=套拍
@property(nonatomic,assign)NSInteger advertType;//1=视频；2=平面；4=套拍
@property(nonatomic,strong)NSArray *detailInfoList;//装5天报价
@end
