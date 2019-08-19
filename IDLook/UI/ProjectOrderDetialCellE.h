//
//  ProjectOrderDetialCellE.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//   询档信息,试镜信息，拍摄信息，定妆信息

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

@interface ProjectOrderDetialCellE : UITableViewCell

@property(nonatomic,copy)void(^lookLastPhotoBlock)(NSInteger tag);  //查看图片

-(void)reloadUIWithInfo:(ProjectOrderInfoM*)info withDic:(NSDictionary*)dic;

@end


