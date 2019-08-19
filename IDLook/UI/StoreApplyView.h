//
//  StoreApplyView.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//申请弹窗父视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreApplyView : UIView
-(void)showWithProductName:(NSString *)productName num:(NSInteger)num andTotalSorce:(NSInteger)totalSorce;
@property(nonatomic,copy)void(^apply)(void);
- (void)hide;
@end

NS_ASSUME_NONNULL_END
