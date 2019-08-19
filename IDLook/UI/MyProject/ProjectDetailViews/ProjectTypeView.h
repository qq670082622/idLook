//
//  ProjectTypeView.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//选类型的弹窗页

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTypeView : UIView
-(void)showTypeWithSelectTypes:(NSString *)types;
@property(nonatomic,copy)void(^typeSelectAction)(NSString *str);
@end

NS_ASSUME_NONNULL_END
