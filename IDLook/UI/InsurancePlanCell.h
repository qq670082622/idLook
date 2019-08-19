//
//  InsurancePlanCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/11.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InsurancePlanCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)void(^slectType)(NSInteger type);//1：20万 2：30万
@property(nonatomic,copy)void(^check)(void);
@end

NS_ASSUME_NONNULL_END
