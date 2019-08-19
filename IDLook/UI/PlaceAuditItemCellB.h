//
//  PlaceAuditItemCellB.h
//  IDLook
//
//  Created by Mr Hu on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceAuditItemCellB : UITableViewCell
@property(nonatomic,copy)void(^isExpendBlock)(BOOL isExpend);   //是否展开

-(void)reloadUIModel:(ProjectModel*)model;
@end

NS_ASSUME_NONNULL_END
