//
//  VideoListPopV.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/12.
//  Copyright © 2018年 HYH. All rights reserved.
// 上下弹窗 顶部j点击以后出来的东西

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoListPopV : UIView
@property(nonatomic,copy)void(^compClickBlock)(NSDictionary *dic,NSString *title);  //选中回掉

@property(nonatomic,copy)void(^hideBlock)(void);  //隐藏视图回掉

/**
 选中的内容
 */
@property(nonatomic,strong)NSMutableArray *selectArray;


/**
 加载视图
 @param isLoading 是否加载
 @param mastery 专精类型
 @param type 类型
 @param offY 偏移量
 @param dic 选中的m内容
 */
-(void)showWithLoad:(BOOL)isLoading withMasteryType:(NSInteger)mastery withType:(ScreenCellType)type withVideoType:(NSInteger)videoType withOffY:(CGFloat)offY withSelectDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
