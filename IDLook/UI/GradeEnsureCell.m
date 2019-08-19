//
//  GradeEnsureCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "GradeEnsureCell.h"

@implementation GradeEnsureCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"GradeEnsureCell";
    GradeEnsureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GradeEnsureCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ensureBtn.layer.cornerRadius=8;
        cell.ensureBtn.layer.masksToBounds = YES;
     //   cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)enSure:(id)sender {
    [self.delegate ensureGrade];
}
@end
