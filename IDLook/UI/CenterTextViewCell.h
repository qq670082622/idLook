//
//  CenterTextViewCell.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditStructM.h"

@interface CenterTextViewCell : UITableViewCell
@property(nonatomic,copy)void(^textViewChangeBlock)(NSString *text);
@property(nonatomic,copy)void(^BeginEdit)(void);  //开始编辑

-(void)reloadUIWithModel:(EditStructM*)model;

@end
