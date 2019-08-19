//
//  EditMainCellD.h
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditMainM.h"

@interface EditMainCellD : UITableViewCell
@property(nonatomic,copy)void(^EditMainCellDEditBlock)(void);
-(void)reloadUIWithTitle:(NSString*)title withType:(EditCellType)type;
@end
