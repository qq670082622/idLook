//
//  UseSelectPopView.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//选天数的弹窗

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UseSelectPopView : UIView
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *selectStr;
@property(nonatomic,copy)void(^selectID)(NSString *string);
-(void)initSubviews;
@end

NS_ASSUME_NONNULL_END
