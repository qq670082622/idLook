//
//  ActorGradeCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/6.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorGradeCell.h"
@interface ActorGradeCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;
@property (weak, nonatomic) IBOutlet UILabel *checkTime;
@property (weak, nonatomic) IBOutlet UILabel *levelString;
@property (weak, nonatomic) IBOutlet UILabel *tipString;
@property (weak, nonatomic) IBOutlet UIImageView *tipIcon;

@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIView *grayLine;
@end
@implementation ActorGradeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"ActorGradeCell";
    ActorGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActorGradeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userIcon.layer.cornerRadius = 14;
        cell.userIcon.layer.masksToBounds = YES;
    }
   return cell;
}

-(void)setCheckModel:(CheckGradeModel *)checkModel
{
    _checkModel = checkModel;
    NSDictionary *userBriefInfo = checkModel.userBriefInfo;
    [_userIcon sd_setImageWithUrlStr:userBriefInfo[@"avatar"] placeholderImage:[UIImage imageNamed:@"icon_gradeHead"]];
    _userName.text = userBriefInfo[@"userName"];
    if (checkModel.anonymous==2) {
        _userName.text = @"匿名用户";
        _userIcon.image = [UIImage imageNamed:@"icon_gradeHead"];
    }
    [_userName sizeToFit];
    
    _vipIcon.x = _userName.right+10;
    _vipIcon.y = _userName.y + 2;
   BOOL isVip = [userBriefInfo[@"isVIP"] boolValue];
    if (!isVip){
        _vipIcon.hidden = YES;
    }
    _checkTime.text = checkModel.inputTime;
    _levelString.text = [NSString stringWithFormat:@"性价比:%ld星  表演力:%ld星  配合度:%ld星  好感度:%ld星",(long)checkModel.coordination,(long)checkModel.actingPower,(long)checkModel.performance,(long)checkModel.favor];
    _tipString.text = [checkModel.gradeStrings componentsJoinedByString:@","];
    [_tipString sizeToFit];
    _tipString.y = _tipIcon.y;
    _remark.text = checkModel.comment;
    [_remark sizeToFit];
    _remark.y = _tipString.bottom+10;//91;
    if (_tipString.text.length==0) {
        _tipIcon.hidden = YES;
        _remark.y = 66;
    }
    
    
    if (checkModel.comment.length==0) {
        _remark.height = 1;
        _grayLine.y = _remark.y+10;
    }else{
        _grayLine.y = _remark.bottom+10;
    }
  
//    _remark.y = _tipString.bottom+15;
    _grayLine.y = _remark.bottom+10;
 _cellHeight = _grayLine.bottom;
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
