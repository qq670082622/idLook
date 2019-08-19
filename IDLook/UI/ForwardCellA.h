//
//  ForwardCellA.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForwardCellA : UITableViewCell
@property(nonatomic,strong)CustomTextField *textField;

-(void)reloadUIWithTotal:(CGFloat)total;

@end
