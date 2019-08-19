//
//  CheckGradeViewController.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//查看评价

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckGradeViewController : UIViewController
@property(nonatomic,strong) OrderProjectModel *projectModel;

@property(nonatomic,assign)BOOL isMy;//我的评价 还是艺人的所有评价
@end

NS_ASSUME_NONNULL_END
