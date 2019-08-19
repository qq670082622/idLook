//
//  MyProjectVC2.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyProjectVC2 : UIViewController
@property(nonatomic,assign)BOOL isSelectType;//是从询问档期选择来的 还是从我的项目进来的
@property(nonatomic,copy)void(^selectModel)(ProjectModel2 *pjModel);
@end

NS_ASSUME_NONNULL_END
