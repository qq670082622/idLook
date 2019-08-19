//
//  InsuranceCompensateCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceCompensateCell.h"
@interface InsuranceCompensateCell()
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnaction:(id)sender;

@end
@implementation InsuranceCompensateCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"InsuranceCompensateCell";
    InsuranceCompensateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InsuranceCompensateCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"点击下载"];
//   //在某个范围内增加下划线
//    [str addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#98C8F7"],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, [str length])];
//    [cell.btn setAttributedTitle:str forState:0];
    
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

- (IBAction)btnaction:(id)sender {
    self.download();
}
@end
