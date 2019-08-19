//
//  EditBriefCell.h
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditMainM.h"

@interface EditBriefCell : UITableViewCell
@property (nonatomic,strong) UITextView * textView;
-(void)reloadUIWithType:(EditCellType)type;

@end
