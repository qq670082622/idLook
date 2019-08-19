//
//  ProjectDetailVC2.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectDetailVC2Delegate <NSObject>
@optional
-(void)VCReferesh;//编辑或新建成功pop后上级vc刷新的代理
-(void)refereshVCWithModelId:(NSString *)modelId;
@end
@interface ProjectDetailVC2 : UIViewController
@property(nonatomic,strong)ProjectModel2 *model;//编辑和查看项目需要传此model
//@property(nonatomic,assign)BOOL isAudition;//是否是拍摄，否则是试镜
@property(nonatomic,assign)NSInteger type;//1新建 2编辑 3查看
@property(nonatomic,weak)id<ProjectDetailVC2Delegate>delegate;
@property(nonatomic,assign)BOOL isFromAskCalendar;
@end

NS_ASSUME_NONNULL_END
