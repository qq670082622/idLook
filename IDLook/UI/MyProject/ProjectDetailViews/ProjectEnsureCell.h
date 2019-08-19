//
//  ProjectEnsureCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/4.
//  Copyright © 2019年 HYH. All rights reserved.
//最后的按钮

#import <UIKit/UIKit.h>
@protocol ProjectEnsureCellDelegate <NSObject>

-(void)ProjectEnsureCellClicked;

@end
NS_ASSUME_NONNULL_BEGIN

@interface ProjectEnsureCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)NSString *btnTitle;
@property(nonatomic,weak)id<ProjectEnsureCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
