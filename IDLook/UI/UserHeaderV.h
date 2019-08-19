//
//  UserHeaderV.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UserHeaderVDelegate <NSObject>
-(void)clickTypeViewWithIndex:(NSInteger)index;//类型视图点击回调
-(void)clickWorkWithIndex:(NSInteger)index;//作品切换

@end

@interface UserHeaderV : UIView
@property(nonatomic,assign)id <UserHeaderVDelegate> delegate;
@property(nonatomic,strong)NSArray *typeViewArray;

/**
 切换作品种类
 @param page 种类
 */
-(void)moveSlideWorkType:(NSInteger)page;

/**
 切换子类型
 @param page 类型
 */
- (void)moveSliderToPage:(NSInteger)page;
@end

NS_ASSUME_NONNULL_END
