//
//  StoreTableHeaderView.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//商城头部视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreTableHeaderView : UIView
@property(nonatomic,assign)NSInteger integral;
@property(nonatomic,copy)void(^soreDetail)(void);
@end

NS_ASSUME_NONNULL_END
