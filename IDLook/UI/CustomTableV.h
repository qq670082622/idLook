//
//  CustomTableV.h
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NoDataType)
{
    NoDataTypeCollection,     //无收藏
    NoDataTypeSearchResult,   //无搜索结果
    NoDataTypeWorks,          //无才艺作品
    NoDataTypeOrder,          //无订单
    NoDataTypeOrderMsg,       //无订单消息
    NoDataTypeCustomMsg,      //无系统消息
    NoDataTypeAssets,         //无资产明细
    NoDataTypePrice,           //无报价
    NoDataTypeNetwork,          //无网络
    NoDataTypeProject,           //无项目
     NoDataTypeRole,           //无角色
    NoDataTypeAuditionService,   //无选角服务
    NoDataTypeCoupon,           //无优惠券
    NoDataTypeAnnunciate,     //无通告
    NoDataTypeGrade,          //无评价
    NoDataTypeBankCard,         //无银行卡
    NoDataTypeAlipay,         //无支付宝
};

@protocol CustomTableViewDelegate <NSObject>
- (void)CustomTableViewNoDataSceneClicked:(id)sender;
- (void)CustomTableViewButtonClicked;
@end

@interface CustomTableV : UITableView

@property (nonatomic,assign)id<CustomTableViewDelegate>dele;

-(void)startLoading;    //开始加载

- (void)showWithNoDataType:(NoDataType)type;   //显示缺省图

-(void)hideNoDataScene;         //隐藏缺省图

@end
