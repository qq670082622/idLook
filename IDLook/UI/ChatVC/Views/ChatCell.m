//
//  ChatCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/10/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ChatCell.h"
@interface ChatCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UILabel *mesage;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation ChatCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"ChatCell";
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
-(void)setModel:(ChatModel *)model
{
    _model = model;
    self.time.text = model.createTime;
    if (model.type==1) {
         self.mesage.text = model.message;
        [self.mesage sizeToFit];
          _mesage.y = 62;
//        if (_mesage.height==16) {
//            CGFloat bgWid = _mesage.width+30;
//             self.bgImg.frame = CGRectMake(63,47,bgWid,_mesage.height+30);
//        }else{
        self.bgImg.frame = CGRectMake(63,47,UI_SCREEN_WIDTH-103,_mesage.height+30);
//        }
    }else if (model.type==2){
        self.mesage.hidden = YES;
//[self.bgImg sd_setImageWithUrlStr:model.message];
           [self.bgImg sd_setImageWithUrlStr:model.message placeholderImage:[UIImage imageNamed:@"default_video"]];
        self.bgImg.contentMode = UIViewContentModeScaleAspectFill;
   self.bgImg.clipsToBounds = YES;
        self.bgImg.frame = CGRectMake(63, 47, 165, 98);
        self.bgImg.layer.cornerRadius = 12;
        self.bgImg.layer.masksToBounds = YES;
        self.bgImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPic)];
        ges.numberOfTapsRequired = 1;
        [self.bgImg addGestureRecognizer:ges];
}
   
    _cellHei = _bgImg.bottom;
}
-(void)tapPic
{
    self.tapImg(_model.message);
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
