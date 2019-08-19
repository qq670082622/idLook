//
//  ProjectChooseVC.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectChooseVC : UIViewController
@property(nonatomic,copy)void(^selectProjectModelBlock)(ProjectModel *projectModel);  //选中项目的回掉

@property(nonatomic,assign)NSInteger projectType;  //项目类型
@property(nonatomic,strong)ProjectModel *projectModel;

@end

NS_ASSUME_NONNULL_END
