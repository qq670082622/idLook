//
//  GradeEnsureCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//评价确定按钮

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GradeEnsureCellDelegate <NSObject>

-(void)ensureGrade;

@end
@interface GradeEnsureCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property(nonatomic,weak)id<GradeEnsureCellDelegate>delegate;
- (IBAction)enSure:(id)sender;
@end

NS_ASSUME_NONNULL_END
