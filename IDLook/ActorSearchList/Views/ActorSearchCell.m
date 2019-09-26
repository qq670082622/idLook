//
//  ActorSearchCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorSearchCell.h"
@interface ActorSearchCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UILabel *workCount;
@property (weak, nonatomic) IBOutlet UILabel *workDesc;
@property (weak, nonatomic) IBOutlet UILabel *gradeTitle;

@end
@implementation ActorSearchCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"ActorSearchCell";
    ActorSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActorSearchCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
-(void)setModel:(ActorSearchModel *)model
{
//    @property(nonatomic,copy)NSString *nikeName;
//    @property(nonatomic,assign)BOOL expert;//是否带货达人
//    @property(nonatomic,copy)NSString *academy;//学校
//    @property(nonatomic,copy)NSString *headPorUrl;
//    @property(nonatomic,assign)NSInteger works;//视频数量
//    @property(nonatomic,copy)NSString *representativeWork;//代表作品
//    @property(nonatomic,copy)NSString *comment;//底部标签
    _model = model;
    [self.icon sd_setImageWithUrlStr:model.headPorUrl placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.icon.layer.cornerRadius = 27;
    self.icon.layer.masksToBounds = YES;
    self.name1.text = model.nikeName;
    
   // if (model.expert) {
    if (model.academy.length>0) {
         self.name2.text = [NSString stringWithFormat:@"带货达人 • %@毕业生",model.academy];
    }else{
        self.name2.text = @"带货达人";
    }
    
//    }else{
//        self.name2.text = model.academy;
//    }
   
    [self.name1 sizeToFit];
    self.name2.x = _name1.right+10;
    NSInteger level = [UserInfoManager getUserVip];
    if (level != 301) {
        _name1.hidden = YES;;
        _name2.x = 81;
    }
    self.workCount.text = [NSString stringWithFormat:@"%ld视频作品",model.works];
    self.workDesc.text = model.representativeWork;
    self.gradeTitle.text = model.comment;
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
