//
//  AskCalendarVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/4.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetialInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface AskCalendarVC : UIViewController
@property (nonatomic,strong) UserDetialInfoM *info;
@property (nonatomic,strong) NSDictionary *priceDic;
@property(nonatomic,strong)NSArray *selectArray;//选择了哪些项目 pricemodel数组
@property(nonatomic,assign)NSInteger orderYear;//肖像年限
@property(nonatomic,assign)NSInteger orderRegion;//肖像范围
@property(nonatomic,assign)NSInteger otherArea;//异地拍摄
@property(nonatomic,assign)NSInteger total_vip;//vip总价
@property(nonatomic,assign)NSInteger total_normal;//普通总价
@end

NS_ASSUME_NONNULL_END
