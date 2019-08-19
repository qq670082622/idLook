//
//  ProjectOptionsCell2.m
//  IDLook
//
//  Created by 吴铭 on 2019/7/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOptionsCell2.h"
@interface ProjectOptionsCell2()
@property (weak, nonatomic) IBOutlet UILabel *shotCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *shotDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *shotDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *chotCycleLabel;

@property (weak, nonatomic) IBOutlet UIView *checkView;//"查看"状态需要盖住右角标
@property (weak, nonatomic) IBOutlet UIView *checkView2;
@property (weak, nonatomic) IBOutlet UIView *checkView3;
@property (weak, nonatomic) IBOutlet UILabel *selectedRegion;//查看模式直接显示范围

@property (weak, nonatomic) IBOutlet UIButton *mainLandBtn;
- (IBAction)mainLandAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *gatBtn;
- (IBAction)gatAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *globalBtn;
- (IBAction)globalAction:(id)sender;

- (IBAction)cityAction:(id)sender;
- (IBAction)dayMinusAction:(id)sender;
- (IBAction)dayAddAction:(id)sender;
- (IBAction)dateAction:(id)sender;
- (IBAction)cycleMinusAction:(id)sender;
- (IBAction)cycleAddAction:(id)sender;

@end

@implementation ProjectOptionsCell2
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectOptionsCell2";
    ProjectOptionsCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectOptionsCell2" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.mainLandBtn.layer.borderWidth=0.5;
   cell.gatBtn.layer.borderWidth=0.5;
  cell.globalBtn.layer.borderWidth=0.5;
    
    return cell;
}

-(void)setModel:(ProjectModel2 *)model
{
    _model = model;

    self.shotDayLabel.text = [NSString stringWithFormat:@"%ld天",model.shotDays];

    if (model.projectCity.length>0) {

        self.shotCityLabel.text = model.projectCity;
        self.shotCityLabel.textColor = [UIColor colorWithHexString:@"464646"];
    }
    if (model.projectCity.length==0) {

        self.shotCityLabel.text = @"请选择拍摄城市(可多选）";
        self.shotCityLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    }
    if (model.projectStart.length>0) {

        self.shotDateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.projectStart,model.projectEnd];
          self.shotDateLabel.textColor = [UIColor colorWithHexString:@"464646"];
    }
    if (model.projectStart.length==0) {

        self.shotDateLabel.text = @"请选择预拍周期";
        self.shotDateLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    }

    if (model.shotCycle.length>0) {
        self.chotCycleLabel.text = [NSString stringWithFormat:@"%@年",model.shotCycle];
         self.chotCycleLabel.textColor = [UIColor colorWithHexString:@"464646"];
}
    
    if (model.shotCycle.length==0) {
        self.chotCycleLabel.text = @"0年";
        self.chotCycleLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    }
    
    self.mainLandBtn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    [self.mainLandBtn setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:0];
    self.gatBtn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
     [self.gatBtn setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:0];
    self.globalBtn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
     [self.globalBtn setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:0];
    if ([model.shotRegion containsString:@"大陆"]) {
        self.mainLandBtn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
        [self.mainLandBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
    }else if ([model.shotRegion containsString:@"港澳"]) {
        self.gatBtn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
        [self.gatBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
    }else if ([model.shotRegion containsString:@"海外"]) {
        self.globalBtn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
        [self.globalBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
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

- (IBAction)mainLandAction:(id)sender {
    [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeUseRange andObj:@"中国大陆"];
}
- (IBAction)gatAction:(id)sender {
    [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeUseRange andObj:@"港澳台"];
}
- (IBAction)globalAction:(id)sender {
    [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeUseRange andObj:@"海外全球"];
}

- (IBAction)cityAction:(id)sender {
     [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeCity andObj:@""];
}

- (IBAction)dayMinusAction:(id)sender {
   
  NSString *day =  [self.shotDayLabel.text stringByReplacingOccurrencesOfString:@"天" withString:@""];
      NSInteger day_int = [day integerValue];
    if (day_int==0) {
        return ;
    }else{
       day_int--;
    }
     [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeDays andObj:@(day_int)];//控制器改数据 刷UI，这边不能刷，因为华滑动后就没了
}

- (IBAction)dayAddAction:(id)sender {
    NSString *day =  [self.shotDayLabel.text stringByReplacingOccurrencesOfString:@"天" withString:@""];
    NSInteger day_int = [day integerValue];
    if (day_int==5) {
        return ;
    }else{
        day_int++;
    }
    [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeDays andObj:@(day_int)];//控制器改数据 刷UI，这边不能刷，因为华滑动后就没了
}

- (IBAction)dateAction:(id)sender {
     [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypedate andObj:@""];
}

- (IBAction)cycleMinusAction:(id)sender {
    NSString *day =  [self.chotCycleLabel.text stringByReplacingOccurrencesOfString:@"年" withString:@""];
    NSInteger day_int = [day integerValue];
    if (day_int==0) {
        return ;
    }else{
        day_int--;
    }
    [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeUseTime andObj:@(day_int)];//控制器改数据 刷UI，这边不能刷，因为华滑动后就没了
}

- (IBAction)cycleAddAction:(id)sender {
    NSString *day =  [self.chotCycleLabel.text stringByReplacingOccurrencesOfString:@"年" withString:@""];
    NSInteger day_int = [day integerValue];
    if (day_int==3) {
        [SVProgressHUD showImage:nil status:@"超过3年肖像价格需要面议，暂不支持在线下单"];
        return ;
    }else{
        day_int++;
    }
    [self.delegate ProjectOptionsCell2SelectOptionWithType:optioncellActionTypeUseTime andObj:@(day_int)];//控制器改数据 刷UI，这边不能刷，因为华滑动后就没了
}
-(void)setCheckStyle:(BOOL)checkStyle
{
    _checkStyle = checkStyle;
    if (checkStyle) {
        self.checkView.hidden = NO;
        self.checkView2.hidden = NO;
        self.checkView3.hidden = NO;
        self.selectedRegion.hidden = NO;
        self.selectedRegion.text = _model.shotRegion;
        self.mainLandBtn.hidden = YES;
        self.gatBtn.hidden = YES;
        self.globalBtn.hidden = YES;
    }
}

@end
