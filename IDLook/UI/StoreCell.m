//
//  StoreCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "StoreCell.h"
@interface StoreCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *icon_price;
@property (weak, nonatomic) IBOutlet UILabel *icon_name;
@property (weak, nonatomic) IBOutlet UILabel *icon_cantBuy;


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;
- (IBAction)convertAction:(id)sender;
- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
- (IBAction)minusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *number;


@end
@implementation StoreCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"StoreCell";
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.convertBtn.layer.masksToBounds=YES;
        cell.convertBtn.layer.cornerRadius=15.0;
        cell.bgView.layer.cornerRadius=5.0;
        cell.bgView.layer.shadowOffset = CGSizeMake(0, 0);
        cell.bgView.layer.shadowOpacity = 1.0;
        cell.bgView.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.2].CGColor;
    }
  
    return cell;
}
-(void)setModel:(StoreModel *)model
{
    _model = model;
    [self.icon sd_setImageWithUrlStr:model.picture placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.name.text = model.itemName;
    self.icon_name.text = model.itemName;
    self.price.text = [NSString stringWithFormat:@"%ld积分",model.point];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld元",model.point]];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(attStr.length-1,1)];
    self.icon_price.attributedText=attStr;
    if (_totalSorce<model.point) {
        self.icon_cantBuy.hidden = YES;
    }else{
             self.icon_cantBuy.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)convertAction:(id)sender {
    if ([_number.text integerValue]==0) {
        [SVProgressHUD showImage:nil status:@"请选择数量"];
        return;
    }
    _model.number = [self.number.text integerValue];
    [self.delegate selectWithModel:_model];
}

- (IBAction)add:(id)sender {
    NSInteger num = [self.number.text integerValue];
    num++;
    if (_model.point*num>_totalSorce) {
        [SVProgressHUD showErrorWithStatus:@"您的积分不足"];
        num--;
        return;
    }
    self.number.text = [NSString stringWithFormat:@"%ld",num];
    if ([_number.text integerValue]==1) {
        self.minusBtn.userInteractionEnabled = YES;
        [self.minusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
    }
    
}
- (IBAction)minusAction:(id)sender {
    NSInteger num = [self.number.text integerValue];
    num--;
    self.number.text = [NSString stringWithFormat:@"%ld",num];
    if ([_number.text integerValue]==0) {
        self.minusBtn.userInteractionEnabled = NO;
        [self.minusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
    }
}
@end
