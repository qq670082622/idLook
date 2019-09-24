//
//  CollectionActorCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CollectionActorCell.h"
@interface CollectionActorCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UILabel *workCount;
@property (weak, nonatomic) IBOutlet UILabel *workDesc;
@property (weak, nonatomic) IBOutlet UILabel *gradeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@end
@implementation CollectionActorCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"CollectionActorCell";
    CollectionActorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionActorCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
-(void)setModel:(ActorSearchModel *)model
{
    _model = model;
    [self.icon sd_setImageWithUrlStr:model.headPorUrl placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.icon.layer.cornerRadius = 27;
    self.icon.layer.masksToBounds = YES;
    self.name1.text = model.nikeName;
    if (model.expert) {
        self.name2.text = [NSString stringWithFormat:@"带货达人 • %@毕业生",model.academy];
    }else{
        self.name2.text = model.academy;
    }
    
    [self.name1 sizeToFit];
    self.name2.x = _name1.right+10;
    self.workCount.text = [NSString stringWithFormat:@"%ld视频作品",model.works];
    self.workDesc.text = model.representativeWork;
    self.gradeTitle.text = model.comment;
    if (model.isSelected) {
        _selectImg.image = [UIImage imageNamed:@"icon_select"];
    }else{
        _selectImg.image = [UIImage imageNamed:@"icon_unSelect"];
    }
}
-(void)setNoSystem:(BOOL)noSystem
{
    if (noSystem) {
        _selectImg.image = [UIImage imageNamed:@"customized_pupup_default_unclick"];
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

@end
