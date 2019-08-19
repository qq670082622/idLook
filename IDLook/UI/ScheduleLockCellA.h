//
//  ScheduleLockCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//  锁档项目信息cell

#import <UIKit/UIKit.h>

@interface ScheduleLockCellA : UITableViewCell
@property(nonatomic,copy)void(^lookProjectDetialBlock)(void);  //查看详情

-(void)reloadUIWithProjectInfo:(NSDictionary*)dic;

@end


