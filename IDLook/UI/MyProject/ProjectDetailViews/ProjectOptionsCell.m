//
//  ProjectOptionsCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectOptionsCell.h"
@interface ProjectOptionsCell()
@property (weak, nonatomic) IBOutlet UIButton *auditionDaysBtn;
- (IBAction)auditionDaysAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
- (IBAction)cityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startDayBtn;
- (IBAction)startDayAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *endDayBtn;
- (IBAction)endDayAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *useTimeBtn;
- (IBAction)useTimeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *useRangeBtn;
- (IBAction)useRangeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *line;


@end
@implementation ProjectOptionsCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectOptionsCell";
    ProjectOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectOptionsCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}
-(void)setModel:(ProjectModel2 *)model
{
    BOOL isBold = [_endDayBtn.titleLabel.font.fontName containsString:@"bold"];
  
 //无数据 跟lab对齐
    _model = model;
  self.line.x -= isBold?10:15;
   if (model.shotDays>0) {
//         if (model.auditiondays>0) {
        [self.auditionDaysBtn setTitle:[NSString stringWithFormat:@"%ld天",(long)model.shotDays] forState:0];
        self.auditionDaysBtn.backgroundColor = [UIColor whiteColor];
    }
//   if (model.auditiondays==0) {
       if (model.shotDays==0) {
        [self.auditionDaysBtn setTitle:@"" forState:0];
        self.auditionDaysBtn.backgroundColor = [UIColor clearColor];
    }
   if (model.projectCity.length>0) {
//       if (model.city.length>0) {
        [self.cityBtn setTitle:model.projectCity forState:0];
        self.cityBtn.backgroundColor = [UIColor whiteColor];
    }
  if (model.projectCity.length==0) {
        [self.cityBtn setTitle:@"" forState:0];
        self.cityBtn.backgroundColor = [UIColor clearColor];
        }
     if (model.projectStart.length>0) {
//         if (model.start.length>0) {
        [self.startDayBtn setTitle:model.projectStart forState:0];
        self.startDayBtn.backgroundColor = [UIColor whiteColor];
        }
    if (model.projectStart.length==0) {
        [self.startDayBtn setTitle:@"" forState:0];
        self.startDayBtn.backgroundColor = [UIColor clearColor];
    }
    if (model.projectEnd.length>0) {
//        if (model.end.length>0) {
        [self.endDayBtn setTitle:model.projectEnd forState:0];
        self.endDayBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.projectEnd.length==0) {
        [self.endDayBtn setTitle:@"" forState:0];
        self.endDayBtn.backgroundColor = [UIColor clearColor];
    }
     if (model.shotCycle.length>0) {
//         if (model.shotcycle.length>0) {
        [self.useTimeBtn setTitle:model.shotCycle forState:0];
        self.useTimeBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.shotCycle.length==0) {
        [self.useTimeBtn setTitle:@"" forState:0];
        self.useTimeBtn.backgroundColor = [UIColor clearColor];
    }
    if (model.shotRegion.length>0) {
//        if (model.shotregion.length>0) {
        [self.useRangeBtn setTitle:model.shotRegion forState:0];
        self.useRangeBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.shotRegion.length==0) {
        [self.useRangeBtn setTitle:@"" forState:0];
        self.useRangeBtn.backgroundColor = [UIColor clearColor];
    }
 
    if (model.projectStart.length>0 && model.projectEnd.length>0) {
//        if (model.start.length>0 && model.end.length>0) {
        if (isBold) {
            self.line.x += 15;
        }else{
            self.line.x += 10;
        }
    }
    }

-(void)setCheckStyle:(BOOL)checkStyle
{
    if (checkStyle) {
         self.checkBtn.hidden = NO;
        _auditionDaysBtn.width+=50;
        _cityBtn.width+=50;
        _endDayBtn.width+=70;
        _useTimeBtn.width+=50;
        _useRangeBtn.width+=50;
        _auditionDaysBtn.backgroundColor = [UIColor whiteColor];
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

- (IBAction)cityAction:(id)sender {
  [self.delegate ProjectOptionsCellSelectOptionWithType:actionTypeCity];
}
- (IBAction)startDayAction:(id)sender {
    if (_model.shotDays==0) {
//        if (_model.auditiondays==0) {
        [SVProgressHUD showImage:nil status:@"请先选择拍摄天数"];
           return;
    }
    self.actionType(actionTypeStartDay);
}
- (IBAction)endDayAction:(id)sender {
    if (_model.shotDays==0) {
//        if (_model.auditiondays==0) {
        [SVProgressHUD showImage:nil status:@"请先选择拍摄天数"];
           return;
    }
    if (_model.projectStart.length==0) {
//        if (_model.start.length==0) {
        [SVProgressHUD showImage:nil status:@"请先选择开始日期"];
        return;
    }
    self.actionType(actionTypeEndDay);
}
- (IBAction)useTimeAction:(id)sender {
    [self.delegate ProjectOptionsCellSelectOptionWithType:actionTypeUseTime];
}
- (IBAction)useRangeAction:(id)sender {
   [self.delegate ProjectOptionsCellSelectOptionWithType:actionTypeUseRange];
}
- (IBAction)auditionDaysAction:(id)sender {
    [self.delegate ProjectOptionsCellSelectOptionWithType:actionTypeDays];
}
@end
