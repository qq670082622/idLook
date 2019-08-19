//
//  MyOrderListCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/5.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderListCellA : UITableViewCell

//查看项目详情
@property(nonatomic,copy)void(^lookProjectdetialBlock)(void);

@property(nonatomic,copy)void(^buttonClickBlock)(NSInteger type,ProjectOrderInfoM *info);

@property(nonatomic,copy)void(^MyOrderlookOrderDetialBlock)(ProjectOrderInfoM *info);

-(void)reloadUIWithDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
