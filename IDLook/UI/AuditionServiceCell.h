//
//  AuditionServiceCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoleServiceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuditionServiceCell : UITableViewCell

@property(nonatomic,copy)void(^AuditionServiceCellPayBlock)(void);  //去支付
@property(nonatomic,copy)void(^AuditionServiceCellContactBlock)(void);  //联系脸探


-(void)reloadUIWithModel:(RoleServiceModel*)model;

@end

NS_ASSUME_NONNULL_END
