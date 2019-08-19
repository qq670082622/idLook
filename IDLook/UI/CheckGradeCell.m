//
//  CheckGradeCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "CheckGradeCell.h"
@interface CheckGradeCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;

@property (weak, nonatomic) IBOutlet UILabel *checkTime;
@property (weak, nonatomic) IBOutlet UILabel *levelString;
@property (weak, nonatomic) IBOutlet UILabel *tipString;
@property (weak, nonatomic) IBOutlet UIImageView *tipIcon;

@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIView *actorView;
@property (weak, nonatomic) IBOutlet UIImageView *actorHead;
@property (weak, nonatomic) IBOutlet UILabel *actorName;
@property (weak, nonatomic) IBOutlet UILabel *actorDesc;
@property (weak, nonatomic) IBOutlet UIImageView *actorSex;
@property (weak, nonatomic) IBOutlet UILabel *actorTypes;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
- (IBAction)moreAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *grayLine;
- (IBAction)userInfoAction:(id)sender;

@end
@implementation CheckGradeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"CheckGradeCell";
    CheckGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CheckGradeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
    }
    cell.actorView.layer.cornerRadius = 6;
    cell.actorView.layer.masksToBounds = YES;
    cell.actorHead.layer.cornerRadius = 3;
    cell.actorHead.layer.masksToBounds = YES;
    return cell;
}
-(void)setCheckModel:(CheckGradeModel *)checkModel
{
    _checkModel = checkModel;
    NSDictionary *actorInfo = checkModel.actorInfo;
    NSString *userIcon = [UserInfoManager getUserHead];
     [_userIcon sd_setImageWithUrlStr:userIcon placeholderImage:[UIImage imageNamed:@"icon_gradeHead"]];
    _userName.text = [UserInfoManager getUserNick];
    if (checkModel.anonymous==2) {
        _userName.text = @"匿名用户";
        _userIcon.image = [UIImage imageNamed:@"icon_gradeHead"];
    }
    [_userName sizeToFit];
    
    _vipIcon.x = _userName.right+10;
    _vipIcon.y = _userName.y + 3;
    NSInteger status = [UserInfoManager getUserStatus];
    if (status<201){
        _vipIcon.hidden = YES;
    }
    _checkTime.text = checkModel.inputTime;
    _levelString.text = [NSString stringWithFormat:@"性价比:%ld星 表演力:%ld星 配合度:%ld星 好感度:%ld星",(long)checkModel.coordination,(long)checkModel.actingPower,(long)checkModel.performance,(long)checkModel.favor];
    _tipString.text = [checkModel.gradeStrings componentsJoinedByString:@","];
    [_tipString sizeToFit];
    _tipString.y = _tipIcon.y;
    _remark.text = checkModel.comment;
    [_remark sizeToFit];
      _remark.y = _tipString.bottom+10;
    if (_tipString.text.length==0) {
        _tipIcon.hidden = YES;
         _remark.y = 63;
    }
  
  
    if (checkModel.comment.length==0) {
        _remark.height = 1;
        _actorView.y = _remark.y+10;
    }else{
    _actorView.y = _remark.bottom+10;
    }
    [_actorHead sd_setImageWithUrlStr:actorInfo[@"actorHead"] placeholderImage:[UIImage imageNamed:@"default_photo"]];
   _actorName.text = actorInfo[@"actorName"];
    NSInteger sex = [actorInfo[@"sex"] integerValue];
    if (sex==1) {
        _actorSex.image = [UIImage imageNamed:@"icon_male"];
    }else{
        _actorSex.image = [UIImage imageNamed:@"icon_female"];
    }
    
    NSString *region = actorInfo[@"region"];
    NSString *masteryName = actorInfo[@"masteryName"];
    _actorDesc.text = [NSString stringWithFormat:@"· %@ · %@",region,masteryName];
    [_actorName sizeToFit];
    _actorSex.x = _actorName.right+10;
    [_actorDesc sizeToFit];
    _actorDesc.x = _actorSex.right+5;
    _actorTypes.text =actorInfo[@"performType"];
    if (_actorTypes.text.length>0) {
         NSString *first = [_actorTypes.text substringWithRange:NSMakeRange(0, 1)];
        if ([first isEqualToString:@"|"]) {//后端type首字符容易传|,所以做个替换
            NSString *newS = [[NSString stringWithFormat:@"123%@",_actorTypes.text] stringByReplacingOccurrencesOfString:@"123|" withString:@""];
            _actorTypes.text = newS;
        }
    }
 
   
    _moreBtn.y = _actorView.bottom+10;
    _grayLine.y = _moreBtn.bottom+10;
       NSLog(@"~~~~~~~~~~~~~avtoeView's  bottom is  %f~~~~~~~~~~`moreBtn's y is  %f~~~~~~~~~~~",_actorView.bottom,_moreBtn.y);
     [self layoutSubviews];
    _cellHeight = _grayLine.bottom;
    //    CGFloat buttonX = 57;//按钮x
//      CGFloat buttonX2 = 57;//按钮x
//    for(int i = 0;i<checkModel.gradeStrings.count;i++){//x=57 y=64
//        if (i<3) {
//            UIButton *tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            NSString *gdString = checkModel.gradeStrings[i];
//            tipBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//            [tipBtn setTitle:gdString forState:0];
//            tipBtn.userInteractionEnabled = NO;
//            tipBtn.width = gdString.length*10+20;
//            tipBtn.y =  64;
//            tipBtn.x = buttonX;
//            tipBtn.height = 26;
//            buttonX+=(tipBtn.width+10);//1 :0  2:110 3:220
//            [self setTipButtonWithSelectStatue:tipBtn];
//            [self.contentView addSubview:tipBtn];
//        }else if (i>2){
//            UIButton *tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            NSString *gdString = checkModel.gradeStrings[i];
//            tipBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//            [tipBtn setTitle:gdString forState:0];
//            tipBtn.userInteractionEnabled = NO;
//            tipBtn.width = gdString.length*10+20;
//            tipBtn.y =  95;
//            tipBtn.x = buttonX2;
//            tipBtn.height = 26;
//            buttonX2+=(tipBtn.width+10);//1 :0  2:110 3:220
//            [self setTipButtonWithSelectStatue:tipBtn];
//            [self.contentView addSubview:tipBtn];
//        }
//
//    }
//    if (checkModel.level==1) {//好
//        [self.gradeBtn setImage:[UIImage imageNamed:@"icon_good_select"] forState:0];
//    }else if (checkModel.level==2){
//        [self.gradeBtn setImage:[UIImage imageNamed:@"icon_normal_select"] forState:0];
//    }else{//差
//            [self.gradeBtn setImage:[UIImage imageNamed:@"icon_bad_select"] forState:0];
//    }
}
-(void)setTipButtonWithSelectStatue:(UIButton *)tipBtn
{
    tipBtn.layer.cornerRadius=3.0;
    tipBtn.layer.masksToBounds=YES;
    tipBtn.layer.borderWidth=0.5;
    tipBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    [tipBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
    tipBtn.backgroundColor = [UIColor colorWithHexString:@"fbedee"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreAction:(id)sender {
    self.moreAction();
}
- (IBAction)userInfoAction:(id)sender {
    self.userInfoAction();
}
@end
