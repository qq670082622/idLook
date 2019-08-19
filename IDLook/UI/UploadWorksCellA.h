//
//  UploadWorksCellA.h
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadWorksCellA : UITableViewCell
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);

-(void)reloadUIWithDic:(NSDictionary *)dic;

@end
