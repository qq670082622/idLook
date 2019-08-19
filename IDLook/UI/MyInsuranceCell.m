//
//  MyInsuranceCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/17.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyInsuranceCell.h"
@interface MyInsuranceCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *insuranceNum;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *ticketBtn;
- (IBAction)tikectAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)checkAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *compensateBtn;
- (IBAction)compensateAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *statuesLabel;

@end
@implementation MyInsuranceCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"MyInsuranceCell";
    MyInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyInsuranceCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.backView.layer.cornerRadius = 8;
    cell.backView.layer.masksToBounds = YES;
    
    cell.checkBtn.layer.cornerRadius = 4;
    cell.checkBtn.layer.masksToBounds = YES;
    cell.checkBtn.layer.borderColor = [UIColor colorWithHexString:@"bcbcbc"].CGColor;
    cell.checkBtn.layer.borderWidth = 1;
    
    cell.compensateBtn.layer.cornerRadius = 4;
    cell.compensateBtn.layer.masksToBounds = YES;
    cell.compensateBtn.layer.borderColor = [UIColor colorWithHexString:@"bcbcbc"].CGColor;
    cell.compensateBtn.layer.borderWidth = 1;
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
-(void)setModel:(InsuranceModel *)model
{
    _model = model;
//    @property(nonatomic,copy)NSString *effectiveTime; //生效时间
//    @property(nonatomic,copy)NSString *expireTime; //失效时间
//    @property(nonatomic,copy)NSString *policyNum; //保单号
//    @property(nonatomic,assign)NSInteger status; //保单状态 11:已出单；13:保障中；10:承保失败
//    @property(nonatomic,strong)NSArray *userList;
    NSDictionary *userDic = [model.userList objectAtIndex:0];
    NSString *name = userDic[@"policyUserName"];
    self.name.text = name;
    self.insuranceNum.text = [NSString stringWithFormat:@"保单号：%@",model.policyNum.length>2?model.policyNum:@"生成中"];
    self.time.text = [NSString stringWithFormat:@"保障日期：%@至%@",model.effectiveTime,model.expireTime];
    if (model.status==13) {
        self.statuesLabel.text = @"进行中";
    }else{
        self.statuesLabel.text = @"已完成 ";
    }
    
    if (model.planType==0) {
        self.title.text = @"平安意外伤害保险 - 20万版";
    }else{
        self.title.text = @"平安意外伤害保险 - 30万版";
    }
    
    self.price.text = [NSString stringWithFormat:@"￥%ld",(long)model.amount];
}
- (IBAction)tikectAction:(id)sender {
    [self.delegate ticketWithModel:_model];
}
- (IBAction)checkAction:(id)sender {
    [self.delegate checkWithModel:_model];
}
- (IBAction)compensateAction:(id)sender {
    [self.delegate compensateWithModel:_model];
}
@end
