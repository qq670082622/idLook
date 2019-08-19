//
//  ProjectDetailVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//项目详情(新建、编辑、查看皆在此)

#import <UIKit/UIKit.h>
#import "ProjectModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectDetailVCDelegate <NSObject>
@optional
-(void)VCRefereshWithProjectModel:(ProjectModel*)projectModel;//编辑或新建成功pop后上级vc刷新的代理

@end
@interface ProjectDetailVC : UIViewController
@property(nonatomic,strong)ProjectModel *model;//编辑和查看项目需要传此model
@property(nonatomic,assign)BOOL isAudition;//是否是拍摄，否则是试镜
@property(nonatomic,assign)NSInteger type;//1新建 2编辑 3查看
@property(nonatomic,weak)id<ProjectDetailVCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
