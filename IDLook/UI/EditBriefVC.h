//
//  EditBriefVC.h
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditMainM.h"

@interface EditBriefVC : UIViewController
@property(nonatomic,copy)void(^saveRefreshUI)(void);
@property(nonatomic,assign)EditCellType type;

@end