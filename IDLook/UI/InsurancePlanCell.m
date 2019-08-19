//
//  InsurancePlanCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/11.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsurancePlanCell.h"
@interface InsurancePlanCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
- (IBAction)twoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *threBtn;
- (IBAction)threAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;


- (IBAction)chek:(id)sender;

@end
@implementation InsurancePlanCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"InsurancePlanCell";
    InsurancePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InsurancePlanCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.backView.layer.cornerRadius = 8;
    cell.backView.layer.masksToBounds = YES;
    cell.backView.layer.borderColor = [UIColor colorWithHexString:@"e6e6e6"].CGColor;
    cell.backView.layer.borderWidth = 1;
  
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
-(void)setType:(NSInteger)type
{
    if (type==2) {
        self.label1.text = @"30万元";
        self.label2.text = @"30万*伤残比例";
        self.label3.text = @"3万元";
        [self.threBtn setBackgroundColor:Public_Red_Color];
        [self.threBtn setTitleColor:[UIColor whiteColor] forState:0];
        [self.twoBtn setBackgroundColor:[UIColor whiteColor]];
        [self.twoBtn setTitleColor:[UIColor colorWithHexString:@"909090"] forState:0];
        
     
        self.twoBtn.layer.borderColor = [UIColor colorWithHexString:@"e6e6e6"].CGColor;
        self.twoBtn.layer.borderWidth = 1;
        
    
        self.threBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
        self.threBtn.layer.borderWidth = 1;
    }else{
        self.label1.text = @"20万元";
        self.label2.text = @"20万*伤残比例";
        self.label3.text = @"2万元";
        [self.twoBtn setBackgroundColor:Public_Red_Color];
        [self.twoBtn setTitleColor:[UIColor whiteColor] forState:0];
        [self.threBtn setBackgroundColor:[UIColor whiteColor]];
        [self.threBtn setTitleColor:[UIColor colorWithHexString:@"909090"] forState:0];
        
  
        self.twoBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
        self.twoBtn.layer.borderWidth = 1;
        
  
        self.threBtn.layer.borderColor = [UIColor colorWithHexString:@"e6e6e6"].CGColor;
        self.threBtn.layer.borderWidth = 1;
    }
}
- (IBAction)twoAction:(id)sender {
//    self.label1.text = @"20万元";
//     self.label2.text = @"20万*伤残比例";
//     self.label3.text = @"2万元";
     self.slectType(1);
//    [self.twoBtn setBackgroundColor:Public_Red_Color];
//    [self.twoBtn setTitleColor:[UIColor whiteColor] forState:0];
//    [self.threBtn setBackgroundColor:[UIColor whiteColor]];
//    [self.threBtn setTitleColor:[UIColor colorWithHexString:@"909090"] forState:0];
}

- (IBAction)threAction:(id)sender {
//    self.label1.text = @"30万元";
//    self.label2.text = @"30万*伤残比例";
//    self.label3.text = @"3万元";
    self.slectType(2);
//    [self.threBtn setBackgroundColor:Public_Red_Color];
//    [self.threBtn setTitleColor:[UIColor whiteColor] forState:0];
//    [self.twoBtn setBackgroundColor:[UIColor whiteColor]];
//    [self.twoBtn setTitleColor:[UIColor colorWithHexString:@"909090"] forState:0];
}

- (IBAction)chek:(id)sender {
    self.check();
}
@end
