//
//  AnnunciateListCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnunciateListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnnunciateListCell : UITableViewCell
-(void)reloadUIWithModel:(AnnunciateListModel*)model;

@end

NS_ASSUME_NONNULL_END
