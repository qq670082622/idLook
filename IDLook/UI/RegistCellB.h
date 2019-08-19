//
//  RegistCellB.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegistCellB : UITableViewCell
@property(nonatomic,copy)void(^typeChoose1)(UserType type);  //身份选择
@property(nonatomic,copy)void(^buyerChoose)(NSInteger type);  //购买方选择

-(void)reloadUIWithModel:(LoginCellStrutM*)model;

@end

NS_ASSUME_NONNULL_END
