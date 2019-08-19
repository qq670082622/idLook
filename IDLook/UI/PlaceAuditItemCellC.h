//
//  PlaceAuditItemCellC.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceAuditItemCellC : UITableViewCell
-(void)reloadUIWithModel:(ProjectModel*)model;

@end

NS_ASSUME_NONNULL_END
