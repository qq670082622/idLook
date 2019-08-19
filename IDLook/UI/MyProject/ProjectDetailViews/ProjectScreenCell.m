//
//  ProjectScreenCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/4.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectScreenCell.h"
@interface ProjectScreenCell()
@property (weak, nonatomic) IBOutlet UIButton *lastedDatBtn;
- (IBAction)lastedBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shootDayBtn;
- (IBAction)shootDayAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
- (IBAction)cityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
- (IBAction)startAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
- (IBAction)endAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *startLab;
@property (weak, nonatomic) IBOutlet UILabel *endLab;
@property (weak, nonatomic) IBOutlet UILabel *line;


@end
@implementation ProjectScreenCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectScreenCell";
    ProjectScreenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectScreenCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}
-(void)setModel:(ProjectModel *)model
{
    BOOL isBold = [_endBtn.titleLabel.font.fontName containsString:@"bold"];
  
    _model = model;
    self.line.x -= isBold?10:15;
    if (model.auditionend.length>0) {
        [self.lastedDatBtn setTitle:model.auditionend forState:0];
        self.lastedDatBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.auditionend.length==0) {
        [self.lastedDatBtn setTitle:@"" forState:0];
        self.lastedDatBtn.backgroundColor = [UIColor clearColor];
    }
    if (model.auditiondays>0) {
        [self.shootDayBtn setTitle:[NSString stringWithFormat:@"%ld天",model.auditiondays] forState:0];
        self.shootDayBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.auditiondays==0) {
        [self.shootDayBtn setTitle:@"" forState:0];
        self.shootDayBtn.backgroundColor = [UIColor clearColor];
    }
    if (model.city.length>0) {
        [self.cityBtn setTitle:model.city forState:0];
        self.cityBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.city.length==0) {
        [self.cityBtn setTitle:@"" forState:0];
        self.cityBtn.backgroundColor = [UIColor clearColor];
    }
    if (model.start.length>0) {
        [self.startBtn setTitle:model.start forState:0];
        self.startBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.start.length==0) {
        [self.startBtn setTitle:@"" forState:0];
        self.startBtn.backgroundColor = [UIColor clearColor];
    }
    if (model.end.length>0) {
        [self.endBtn setTitle:model.end forState:0];
        self.endBtn.backgroundColor = [UIColor whiteColor];
    }
    if (model.end.length==0) {
        [self.endBtn setTitle:@"" forState:0];
        self.endBtn.backgroundColor = [UIColor clearColor];
    }
    if (model.start.length>0 && model.end.length>0) {
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
        _lastedDatBtn.width+=43;
        _cityBtn.width+=43;
        _endBtn.width+=73;
        _shootDayBtn.width+=43;
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

- (IBAction)lastedBtnAction:(id)sender {
    [self.delegate ProjectScreenCellSelectOptionWithType:TypeLatestDay];
}
- (IBAction)shootDayAction:(id)sender {
    [self.delegate ProjectScreenCellSelectOptionWithType:TypeShootDays];
}
- (IBAction)cityAction:(id)sender {
    [self.delegate ProjectScreenCellSelectOptionWithType:TypeCity];
}
- (IBAction)startAction:(id)sender {
    if (_model.auditiondays==0) {
        [SVProgressHUD showImage:nil status:@"请先选择拍摄天数"];
        return;
    }
    [self.delegate ProjectScreenCellSelectOptionWithType:TypeStartDay];
}
- (IBAction)endAction:(id)sender {
    if (_model.auditiondays==0) {
        [SVProgressHUD showImage:nil status:@"请先选择拍摄天数"];
           return;
    }
    if (_model.start.length==0) {
        [SVProgressHUD showImage:nil status:@"请先选择开始日期"];
        return;
    }
    [self.delegate ProjectScreenCellSelectOptionWithType:TypeEndDay];
}
@end
