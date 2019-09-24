//
//  UserInfoCellC.h
//  IDLook
//
//  Created by Mr Hu on 2019/3/7.
//  Copyright © 2019年 HYH. All rights reserved.
//作品和模特卡的cell。上面两个作废

#import <UIKit/UIKit.h>
#import "UserWorkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoCellC : UITableViewCell
-(void)reloadUIWithWorksModel:(UserWorkModel *)model;

@end

NS_ASSUME_NONNULL_END
