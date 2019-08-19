//
//  AddCardCell.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddCardCell : UITableViewCell
@property(nonatomic,copy)void(^textFielChangeBlock)(NSString *text);
@property(nonatomic,strong)UITextField *textField;

-(void)reloadUIWithDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
