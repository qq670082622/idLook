/*
 @header  AdvBannerView.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/26
 @description
    首页广告轮播视图  老版 弃用
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdvBannerView : UIView
@property(nonatomic,copy)void(^clickBannerWithDictionary)(NSDictionary *dic);
@property(nonatomic,copy)void(^loginOut)(void);
/**
 根据dataS加载banner
 @param dataS 图片url数组
 */
-(void)setImagesWithBannerDatas:(NSArray*)dataS;

/**
 翻页间隔,不传时定时器没用
 */
@property (nonatomic,assign) CGFloat rollInterval;

/**
 翻页动画时长
 */
@property (nonatomic,assign) CGFloat animateInterval;

@end

NS_ASSUME_NONNULL_END