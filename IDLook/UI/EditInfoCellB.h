//
//  EditInfoCellB.h
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoCellB : UITableViewCell
@property(nonatomic,strong)UILabel *detialLab;

-(void)reloadUIWithType:(NSIndexPath*)indexPath;



@end
