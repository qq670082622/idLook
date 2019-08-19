//
//  InsuranceOrderDetailVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//保单详情页面 

#import <UIKit/UIKit.h>
#import "InsuranceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InsuranceOrderDetailVC : UIViewController
@property(nonatomic,assign)NSInteger type;//1查看 2；理赔(购买成功 用此状态)
@property(nonatomic,strong)InsuranceModel *model;
@end

NS_ASSUME_NONNULL_END
