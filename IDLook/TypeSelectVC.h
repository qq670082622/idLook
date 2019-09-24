//
//  TypeSelectVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/12.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TypeSelectVC : UIViewController
@property(nonatomic,copy)void(^selectType)(NSInteger type);//户自定义类型 0=未选择 1=电商 2=制片 3=演员
@property(nonatomic,assign)BOOL isFromRegist;//是否来自注册。注册来的需要上一步下一步，需要演员按钮
@end

NS_ASSUME_NONNULL_END
