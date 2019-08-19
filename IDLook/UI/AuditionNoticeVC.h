//
//  AuditionNoticeVC.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuditionNoticeVC : UIViewController

/**
 通知类型。  0：试镜通知。 1:锁定档期拍摄通知 2.定妆修改时间地点
 */
@property(nonatomic,assign)NSInteger noticeType;

@property (nonatomic,strong)ProjectOrderInfoM *info;

@end

NS_ASSUME_NONNULL_END
