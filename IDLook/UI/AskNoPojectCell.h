//
//  AskNoPojectCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/9.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AskNoPojectCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)void(^addProject)(void);
@end

NS_ASSUME_NONNULL_END
