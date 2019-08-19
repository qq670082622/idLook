//
//  MsgMainCell.h
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"
#import "OrderModel.h"

@interface MsgMainCellA : UITableViewCell

-(void)reloadUIWithModel:(OrderProjectModel*)projectModel;
-(void)initUI;
@end
