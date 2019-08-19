//
//  OrderPJChooseCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderPJChooseCell : UITableViewCell
@property(nonatomic,copy)void(^selectProjectBlock)(void);  //选中项目的回掉

-(void)reloadUIWithModel:(ProjectModel*)model;

@end

NS_ASSUME_NONNULL_END
