//
//  ActorTopCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorTopCell.h"
@interface ActorTopCell()
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UIImageView *topIcon;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *praise;
@property (weak, nonatomic) IBOutlet UILabel *focus;
@property (weak, nonatomic) IBOutlet UILabel *fans;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
@implementation ActorTopCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"ActorTopCell";
    ActorTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActorTopCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
-(void)setModel:(ActorTopModel *)model
{
    _model = model;
    [self.pic sd_setImageWithUrlStr:model.userHeadPortrait placeholderImage:[UIImage imageNamed:@"leaderboard_list_default_bg"]];
    self.pic.layer.cornerRadius = 8;
    self.pic.layer.masksToBounds = YES;
    
    if (model.index==0) {
        self.topIcon.image = [UIImage imageNamed:@"leaderboard_level1"];
    }else if (model.index==1){
        self.topIcon.image = [UIImage imageNamed:@"leaderboard_level2"];
    }else if (model.index==2){
        self.topIcon.image = [UIImage imageNamed:@"leaderboard_level3"];
    }else{
        NSString *topStr = [NSString stringWithFormat:@"%ld",model.index+1];
        self.topIcon.image = [UIImage imageNamed:@"leaderboard_level4"];
        self.topLabel.text = topStr;
    }
    
    self.title.text = model.title;
    
    NSDictionary *dic1 = [model.tags objectAtIndex:0];
    NSString *count1 = dic1[@"tagValue"];
    NSString *units1 = dic1[@"tagUnits"];
     NSString *name1 = dic1[@"name"];
    NSString *priseStr = [NSString stringWithFormat:@"%@%@%@",count1,units1,name1];
    NSMutableAttributedString * attpriseStr = [[NSMutableAttributedString alloc] initWithString:priseStr];
    [attpriseStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ff4a57"],NSFontAttributeName:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]} range:NSMakeRange(0,priseStr.length-2)];
    self.praise.attributedText=attpriseStr;
    
    NSDictionary *dic2 = [model.tags objectAtIndex:1];
    NSString *count2 = dic2[@"tagValue"];
    NSString *units2 = dic2[@"tagUnits"];
    NSString *name2 = dic2[@"name"];
    NSString *focusStr = [NSString stringWithFormat:@"%@%@%@",count2,units2,name2];
  NSMutableAttributedString * attfocusStr = [[NSMutableAttributedString alloc] initWithString:focusStr];
    [attfocusStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ff4a57"],NSFontAttributeName:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]} range:NSMakeRange(0,focusStr.length-2)];
    self.focus.attributedText=attfocusStr;
    
    NSDictionary *dic3 = [model.tags objectAtIndex:2];
    NSString *count3 = dic3[@"tagValue"];
    NSString *units3 = dic3[@"tagUnits"];
    NSString *name3 = dic3[@"name"];
    NSString *fansStr = [NSString stringWithFormat:@"%@%@%@",count3,units3,name3];
   NSMutableAttributedString * attfansStr = [[NSMutableAttributedString alloc] initWithString:fansStr];
    [attfansStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ff4a57"],NSFontAttributeName:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]} range:NSMakeRange(0,fansStr.length-2)];
    self.fans.attributedText=attfansStr;
    
    [self.praise sizeToFit];
    [self.focus sizeToFit];
    [self.fans sizeToFit];
    CGFloat mergin =  (UI_SCREEN_WIDTH-110-25-_praise.width-_focus.width-_fans.width)/2;//25是右间距 mergin是label之间的间距
    _praise.x = 110;
    _focus.x = _praise.right + mergin;
    _fans.x = _focus.right + mergin;
    self.userAvatar.layer.cornerRadius = 8;
    self.userAvatar.layer.masksToBounds = YES;
    [self.userAvatar sd_setImageWithUrlStr:model.userHeadPortrait placeholderImage:[UIImage imageNamed:@"default_home"]];
    
    self.userName.text = model.userName;
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
