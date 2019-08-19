//
//  GradeCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/21.
//  Copyright © 2019年 HYH. All rights reserved.
//评价cell

#import <UIKit/UIKit.h>
#import "GradeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol GradeCellDelegate <NSObject>
//匿名
-(void)cellAnonymity:(BOOL)anonymity withIndexPath:(NSIndexPath *)indexPath;
//评总分（差好坏）
-(void)cellGrade:(NSInteger)grade withIndexPath:(NSIndexPath *)indexPath;
//选或者取消标签
-(void)cellClickTip:(NSString *)tip withSelect:(BOOL)select withIndexPath:(NSIndexPath *)indexPath;
//评单项星星
//price_starType,  //性价比
//act_starType,  //表演力
//match_starType,       //配合度
//feeling_starType,   //好感度
-(void)cellSroce:(NSInteger)scorce withType:(NSInteger)starType withIndexPath:(NSIndexPath *)indexPath;
@end
@interface GradeCell : UITableViewCell
@property(nonatomic,strong)GradeModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,weak)id<GradeCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *textTip;
@property (weak, nonatomic) IBOutlet UILabel *textCount;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *textView_SuperView;

@end

NS_ASSUME_NONNULL_END
