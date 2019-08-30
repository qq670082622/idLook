//
//  VideoListHeadView.h
//  IDLook
//
//  Created by Mr Hu on 2018/12/10.
//  Copyright © 2018年 HYH. All rights reserved.
//顶部第二栏

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoListHeadView : UITableViewHeaderFooterView
@property(nonatomic,copy)void(^screenConditionBlock)(ScreenCellType type,BOOL isSelect);

/**
 隐藏时刷新UI
 */
-(void)hideReloadUI;

/**
 选中条件后刷新标题
 @param type 筛选的类型
 @param title 标题
 */
-(void)reloadButtonWithType:(ScreenCellType)type withTitle:(NSString*)title;

/**
 筛选UI
 @param type 演员类型
 */
-(void)reloadUIWithType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
