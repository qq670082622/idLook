//
//  AskNoPojectCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/9.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AskNoPojectCell.h"
@interface AskNoPojectCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)addAction:(id)sender;

@end
@implementation AskNoPojectCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"AskNoPojectCell";
    AskNoPojectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AskNoPojectCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.backView.layer.cornerRadius = 8;
    cell.backView.layer.masksToBounds = YES;
    cell.btn.layer.cornerRadius = 8;
    cell.btn.layer.masksToBounds = YES;
   
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

- (IBAction)addAction:(id)sender {
    self.addProject();
}
@end
