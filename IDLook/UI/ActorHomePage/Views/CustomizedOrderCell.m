//
//  CustomizedOrderCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CustomizedOrderCell.h"
@interface CustomizedOrderCell()
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *palnName;
@property (weak, nonatomic) IBOutlet UILabel *serviceType;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UIView *bg;

@end
@implementation CustomizedOrderCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"CustomizedOrderCell";
    CustomizedOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomizedOrderCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.bg.layer.cornerRadius = 8;
    cell.bg.layer.masksToBounds = YES;
    return cell;
}
-(void)setModel:(CustomizedOrderModel *)model
{
    _model = model;

    self.companyName.text = [NSString stringWithFormat:@"%@",model.companyName];
    self.orderTime.text = [NSString stringWithFormat:@"下单日期: %@",model.createTime];
    self.contactName.text = [NSString stringWithFormat:@"联系人: %@",model.linkmanName];
    self.palnName.text = model.projectName;
    self.serviceType.text = model.serviceType;
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
