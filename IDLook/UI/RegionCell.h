//
//  RegionCell.h
//  IDLook
//
//  Created by HYH on 2018/8/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface RegionCell : UITableViewCell
-(void)reloadUIWithModel:(CityModel *)model;

@end
