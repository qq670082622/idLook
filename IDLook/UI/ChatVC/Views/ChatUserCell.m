//
//  ChatUserCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/10/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ChatUserCell.h"
@interface ChatUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UILabel *mesage;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end
@implementation ChatUserCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"ChatUserCell";
    ChatUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatUserCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
-(void)setModel:(ChatModel *)model
{
    self.time.text = model.createTime;
      if (model.type==1) {
           self.mesage.text = model.message;
          [self.mesage sizeToFit];
          _mesage.y = 62;
          self.bgImg.frame = CGRectMake(37,47,UI_SCREEN_WIDTH-103,_mesage.height+30);
      }else if (model.type==2){
          self.mesage.hidden = YES;
          [self.bgImg sd_setImageWithUrlStr:model.message];
           _bgImg.frame = CGRectMake(143, 47, 165, 98);
      }
    [self.icon sd_setImageWithUrlStr:[UserInfoManager getUserHead]];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
     _cellHei = _bgImg.bottom;
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
