//
//  NoticeActorCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "NoticeActorCell.h"
#import "DatePickPopV.h"
@interface NoticeActorCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *casting;
@property (weak, nonatomic) IBOutlet UILabel *calendarEnsure;
@property (weak, nonatomic) IBOutlet UILabel *dateStart;
@property (weak, nonatomic) IBOutlet UILabel *dateEnd;
- (IBAction)selectStartDate:(id)sender;
- (IBAction)selectEndDate:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *beyondTip;

@end
@implementation NoticeActorCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"NoticeActorCell";
    NoticeActorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeActorCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    return cell;
}
-(void)setModel:(NoticeActorModel *)model
{
     _model = model;
     NSDictionary *infoDic = model.actorInfo;
   //                               "actorInfo": {
    //                                   "actorHead": "string",
    //                                   "actorId": 0,
    //                                   "actorName": "string",
    //                                   "masteryName": "string",
    //                                   "performType": "如：甜美|气质|动感",
    //                                   "region": "string",
    //                                   "sex": "1=男;2=女"
    //                               },
    self.dateStart.text = model.shotStart;
    self.dateEnd.text = model.shotEnd;
    [self.icon sd_setImageWithUrlStr:infoDic[@"actorHead"] placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.name.text = infoDic[@"actorName"];
    NSInteger sex = [infoDic[@"sex"] integerValue];
    if (sex==1) {//男
        self.sexIcon.image = [UIImage imageNamed:@"icon_male"];
    }else{
        self.sexIcon.image = [UIImage imageNamed:@"icon_female"];
    }
    self.city.text = [NSString stringWithFormat:@"• %@",infoDic[@"region"]];
    self.casting.text = [NSString stringWithFormat:@"饰演角色:%@",model.roleName];
    self.calendarEnsure.text = [model.orderState isEqualToString:@"lock_schedule"]?@"已确认档期":@"未确认档期";
    self.name.width = 18*_name.text.length;
    self.sexIcon.x = self.name.x + self.name.width +7;
    self.city.x = self.sexIcon.x+23;
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    if (!model.dateBeyond) {
        self.beyondTip.hidden = YES;
    }
}
- (IBAction)selectStartDate:(id)sender
{
    WeakSelf(self);
    NSDate *minimumDate = [NSDate date];
            NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*1)];
    
            DatePickPopV *popV = [[DatePickPopV alloc]init];
            [popV showWithMinDate:minimumDate maxDate:maximumDate];
            popV.dateString = ^(NSString * _Nonnull str) {
                if ([weakself.model.shotStart isEqualToString:str]) {//选了一样的天数 不操作
    
                }else{//选择了不一样的天数
                    [weakself.delegate cellSelectStartDate:str withRow:weakself.row];
                  }
    };
}
- (IBAction)selectEndDate:(id)sender
{
    WeakSelf(self);
    NSDate *minimumDate = [self dateWithString:_model.shotStart];
    NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*1)];
    
    DatePickPopV *popV = [[DatePickPopV alloc]init];
    [popV showWithMinDate:minimumDate maxDate:maximumDate];
    popV.dateString = ^(NSString * _Nonnull str) {
        if ([weakself.model.shotEnd isEqualToString:str]) {//选了一样的天数 不操作
            
        }else{//选择了不一样的天数
            [weakself.delegate cellSelectEndDate:str withRow:weakself.row];
        }
    };
}
//将时间转化为date
-(NSDate *)dateWithString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date1 = [dateFormatter dateFromString:dateString];
    return date1;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setRow:(NSInteger)row
{
    _row = row;
}

@end
