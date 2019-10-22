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
@property (weak, nonatomic) IBOutlet UIButton *msBg;

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
    _model = model;
    self.time.text = model.createTime;
      if (model.type==1) {//文字
          self.bgImg.hidden = YES;
           self.mesage.text = model.message;
          [self.mesage sizeToFit];
          _mesage.y = 62;
          UIImage *buttonImageNormal = [self resizableImageWithName:@"message_dialogue_right.png"];
          self.msBg.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
          [self.msBg setBackgroundImage:buttonImageNormal forState:0];
          float line = _mesage.height/_mesage.font.lineHeight;
          line = line>1.5?2.5:1;
          CGFloat bgWid;
//          if (!public_isX) {
//                bgWid = _mesage.width+27*line;
//          }else{
               bgWid = _mesage.width+27;
//          }
          if (bgWid<41) {
              bgWid = 41;
          }
          
          if ( _mesage.height+22<41) {
              _mesage.height = 19;
          }
          _msBg.frame = CGRectMake(UI_SCREEN_WIDTH-67-bgWid,47,bgWid,_mesage.height+22);
          _mesage.x = _msBg.x+15;
          _mesage.y = _msBg.y+11;
      
 _cellHei = _msBg.bottom;
      }else if (model.type==2){//图片
          self.mesage.hidden = YES;

          [self.bgImg sd_setImageWithUrlStr:model.message placeholderImage:[UIImage imageNamed:@"default_video"]];
           self.bgImg.contentMode = UIViewContentModeScaleAspectFill;//mode在frame前面 不然会失效
           self.bgImg.frame = CGRectMake(UI_SCREEN_WIDTH-67-165, 47, 165, 98);
        self.bgImg.layer.cornerRadius = 12;
          self.bgImg.layer.masksToBounds = YES;
           self.bgImg.clipsToBounds = YES;
           self.bgImg.userInteractionEnabled = YES;
         
          UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPic)];
          ges.numberOfTapsRequired = 1;
          [self.bgImg addGestureRecognizer:ges];
        _cellHei = _bgImg.bottom;
      }
    [self.icon sd_setImageWithUrlStr:[UserInfoManager getUserHead]];
   
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
//     _cellHei = _bgImg.bottom;
   
}
-(void)tapPic
{
    self.tapImg(_model.message);
}
-(void)layoutSubviews
{//这里主要适配ios12以下 消息体不对的情况
    [super layoutSubviews];
    if (_model.type==1) {
        if (_mesage.right>_msBg.right) {
               float line = _mesage.height/_mesage.font.lineHeight;
                       
                        CGFloat bgWid;
            bgWid = _mesage.width;
            if (line>1.5) {
                 bgWid = _mesage.width+23;
            }
                      
                        
                        if (bgWid<41) {
                            bgWid = 41;
                        }
                        
                        if ( _mesage.height+22<41) {
                            _mesage.height = 19;
                        }
                        _msBg.frame = CGRectMake(UI_SCREEN_WIDTH-67-bgWid,47,bgWid,_mesage.height+22);
                        _mesage.x = _msBg.x+15;
                        _mesage.y = _msBg.y+11;
                    
               _cellHei = _msBg.bottom;
          }
    }
  
//    if (_model.type==2){
//     self.bgImg.contentMode = UIViewContentModeScaleAspectFill;
//    }
}
-(UIImage *)resizableImageWithName:(NSString *)imageName{
      UIImage *image = [UIImage imageNamed:imageName];
   // 设置端盖的值--其它方向不需要拉伸，只拉伸头部
//    CGFloat left = image.size.width * 0.2;
   UIEdgeInsets edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
   // 设置拉伸的模式
   UIImageResizingMode mode = UIImageResizingModeStretch;
   // 拉伸图片
   UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
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
