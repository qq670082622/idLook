//
//  PayWayCell.h
//  IDLook
//
//  Created by HYH on 2018/7/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayWayCell : UITableViewCell
@property(nonatomic,strong)UIButton *selectBtn;
-(void)realoadUIWithDic:(NSDictionary*)dic;
@end
