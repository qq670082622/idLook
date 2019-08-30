//
//  VideoListTopV.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/11.
//  Copyright © 2018年 HYH. All rights reserved.
// 顶部 综合排序 报价 筛选 顶部第一栏

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoListTopV : UIView
@property (nonatomic,copy)void(^selectWithType)(NSInteger type);
@property (nonatomic,copy)void(^screenAction)(void); //刷选
/**
 重置综合的内容
 @param select 综合，竞争力，颜值
 */
-(void)reloadFirstConditionWithSelect:(NSInteger)select;

@end

@interface ButtonModel : NSObject

/**
 标题
 */
@property(nonatomic,strong)NSString *title;

/**
 标题1
 */
@property(nonatomic,strong)NSString *title1;

/**
 标题2
 */
@property(nonatomic,strong)NSString *title2;

/**
 正常状态时url
 */
@property(nonatomic,strong)NSString *url;

/**
 高亮1时url
 */
@property(nonatomic,strong)NSString *url1;

/**
 高亮2时url
 */
@property(nonatomic,strong)NSString *url2;

/**
 按钮的高亮状态 0:正常状态  1：高亮1  2:高亮2
 */
@property(nonatomic,assign)NSInteger state;

-(id)initWithDic:(NSDictionary*)dic;


@end

NS_ASSUME_NONNULL_END
