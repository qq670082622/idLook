//
//  ProjectNumberCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectNumberCell.h"

@implementation ProjectNumberCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectNumberCell";
    ProjectNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectNumberCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}
-(void)setModel:(ProjectModel2 *)model
{
    _model = model;
  
    self.projectNumLab.text = model.projectId;//[NSString stringWithFormat:@"%ld",model.id];
}
-(void)setCanEdit:(BOOL)canEdit
{
    if (canEdit) {
         self.tipsView.hidden = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
