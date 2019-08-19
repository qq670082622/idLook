//
//  UserInfoCellB.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoVCM.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoCellB : UITableViewCell
@property(nonatomic,copy)void(^lookBigModelCardPhoto)(NSArray *array,NSInteger index);  //查看模特卡
-(void)reloadUIWithArray:(NSArray*)array withMastery:(NSInteger)mastery;

@end

@interface UserInfoModelCardSubCell : UITableViewCell
-(void)reloadUIWithModel:(WorksModel*)model;

@end

NS_ASSUME_NONNULL_END
