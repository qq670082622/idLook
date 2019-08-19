//
//  AskOtherCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AskOtherCell.h"
#import "DatePickPopV.h"
@interface AskOtherCell()
@property (weak, nonatomic) IBOutlet UIView *time_backView;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
- (IBAction)testAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *adornBtn;
- (IBAction)adornAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *photo_backView;
@property (weak, nonatomic) IBOutlet UISwitch *swith;
- (IBAction)switchAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *price_backView;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
- (IBAction)priceAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceReason;

@property (weak, nonatomic) IBOutlet UIView *tipView;

@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
- (IBAction)ensureAction:(id)sender;

@end
@implementation AskOtherCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"AskOtherCell";
    AskOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AskOtherCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.time_backView.layer.cornerRadius = 8;
    cell.time_backView.layer.masksToBounds = YES;
    
    cell.photo_backView.layer.cornerRadius = 8;
    cell.photo_backView.layer.masksToBounds = YES;
    
    cell.price_backView.layer.cornerRadius = 8;
    cell.price_backView.layer.masksToBounds = YES;
    
    cell.swith.onTintColor = [UIColor colorWithHexString:@"ff4a57"];
    
    cell.ensureBtn.layer.cornerRadius = 8;
    cell.ensureBtn.layer.masksToBounds = YES;
    return cell;
}


- (IBAction)testAction:(id)sender {
    WeakSelf(self);
    DatePickPopV *popV = [[DatePickPopV alloc]init];
     NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
    [popV showWithMinDate:[NSDate date] maxDate:maximumDate];
    popV.dateString = ^(NSString * _Nonnull str) {
        [weakself.testBtn setTitle:str forState:0];
        weakself.testTimeBlock(str);
    };
}

- (IBAction)adornAction:(id)sender {
    WeakSelf(self);
    DatePickPopV *popV = [[DatePickPopV alloc]init];
    NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
    [popV showWithMinDate:[NSDate date] maxDate:maximumDate];
    popV.dateString = ^(NSString * _Nonnull str) {
        [weakself.adornBtn setTitle:str forState:0];
        weakself.adornTimeBlock(str);
    };
}

- (IBAction)switchAction:(id)sender {
    if (_swith.isOn==YES) {
        [_swith setOn:NO];
    }else{
        [_swith setOn:YES];
    }
  self.switchAction(_swith.isOn);
}

- (IBAction)priceAction:(id)sender {
    self.priceAction();
}

-(void)setTestTime:(NSString *)testTime
{
   [self.testBtn setTitle:testTime forState:0];
}
-(void)setAdornTime:(NSString *)adornTime
{
    [self.adornBtn setTitle:adornTime forState:0];
}
- (void)setNeedNewPhoto:(BOOL)needNewPhoto
{
    if (needNewPhoto) {
        [self.swith setOn:YES];
    }else{
          [self.swith setOn:NO];
    }
}
-(void)loadUIWithPrice:(NSInteger)price andReason:(NSString *)reason
{
    //1行49的高，多行就是+理由的高度
    if (price>0) {
        [self.priceBtn setTitle:[NSString stringWithFormat:@"￥ %ld",price] forState:0];
        [self.priceBtn setTitleColor:[UIColor colorWithHexString:@"#464646"] forState:0];
         self.priceReason.text = reason;
        [self.priceReason sizeToFit];
        self.priceReason.frame = CGRectMake(12, 45, _price_backView.width-40, _priceReason.height);
        self.price_backView.height = _priceReason.bottom+14;
       
    }else{
        [self.priceBtn setTitle:@"请填写预算及议价理由(可选填)" forState:0];
        [self.priceBtn setTitleColor:[UIColor colorWithHexString:@"#bcbcbc"] forState:0];
        self.priceReason.hidden = YES;
        self.price_backView.height = _priceBtn.height+17;
    }
     self.tipView.y = _price_backView.bottom;
    self.ensureBtn.y = self.tipView.bottom+30;//autoresizing对代码约束有影响
    self.otherCellHeight = _ensureBtn.bottom+30;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)ensureAction:(id)sender {
    [self.delegate askDate];
}
@end
