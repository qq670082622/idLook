//
//  AuthCellA.h
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthModel.h"


@interface AuthCellA : UITableViewCell
@property(nonatomic,copy)void(^textFielChangeBlock)(NSString *text);
@property(nonatomic,copy)void(^BeginEdit)(void);  //开始编辑

-(void)reloadUIWithModel:(AuthStructModel*)model;
@end
