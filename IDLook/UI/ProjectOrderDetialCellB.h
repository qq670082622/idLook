//
//  ProjectOrderDetialCellB.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//  项目信息

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectOrderDetialCellB : UITableViewCell

@property(nonatomic,copy)void(^lookScriptBlock)(NSInteger tag);  //查看脚本

-(void)reloadUIWithInfo:(ProjectOrderInfoM*)info;

@end

NS_ASSUME_NONNULL_END
