//
//  AddSubAccountCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AddSubCellType)
{
    AddSubCellTypeNick,    //昵称
    AddSubCellTypePhone,   //电话
    AddSubCellTypeCode,   //验证码
    AddSubCellTypePassword  //密码
};

@interface AddSubAccountCell : UITableViewCell
@property(nonatomic,copy)void(^getVerificationCodeBlock)(void);
@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);

//开始计时
-(void)beganTimerAction;

-(void)reloadUIWithDic:(NSDictionary*)dic;
@end

