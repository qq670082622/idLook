/*
 @header  MyWorkHeadView.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/30
 @description
      我的作品头视图
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyWorkHeadView : UICollectionReusableView

/**
 刷新
 @param model 作品model
 @param type 类型
 */
-(void)reloadUIWithModel:(WorksModel*)model withType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
