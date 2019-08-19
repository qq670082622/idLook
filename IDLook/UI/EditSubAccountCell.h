//
//  EditSubAccountCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,EditSubCellType)
{
    EditSubCellTypeNick,    //昵称
    EditSubCellTypePhone,   //电话
    EditSubCellTypePassword  //密码
};

@interface EditSubAccountCell : UITableViewCell
@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);

-(void)reloadUIWithDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
