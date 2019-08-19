//
//  PublishGradeViewController.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/21.
//  Copyright © 2019年 HYH. All rights reserved.
//评价页面

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"
#import "UserDetialInfoM.h"
#import "CheckGradeModel.h"
#import "GradeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PublishGradeViewController : UIViewController
//@property(nonatomic,strong) OrderProjectModel *projectModel;
@property(nonatomic,strong) UserDetialInfoM  *userModel;
@property(nonatomic,copy)void(^gradeSuccessReferesh)(void);
@property(nonatomic,strong)CheckGradeModel *checkModel;
@end

NS_ASSUME_NONNULL_END
