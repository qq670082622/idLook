//
//  AskCastingCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AskCastingCell.h"

@interface AskCastingCell()
- (IBAction)selectAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation AskCastingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"AskCastingCell";
    AskCastingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AskCastingCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.backView.layer.cornerRadius = 8;
    cell.backView.layer.masksToBounds = YES;
    return cell;
}
- (void)setModel:(CastingModel *)model
{
    _model = model;
   
    self.name.text = model.roleName;
    if (self.name.text.length==0) {
        [self.selectBtn setTitle:@"新建角色" forState:0];
    }
    if (model.sex>0) {
        self.sex.text = [NSString stringWithFormat:@"角色性别：%@",[NSString stringWithFormat:@"%@\n",model.sex==1?@"男":@"女"]];
    }else{
      self.sex.text = @"性别:暂无";
    }
  
    if (model.heightMin>0) {
       self.height.text = [NSString stringWithFormat:@"角色身高：%ld至%ldcm",model.heightMin,model.heightMax];
    }else{
          self.height.text = [NSString stringWithFormat:@"角色身高：暂无"];
    }
    if (model.ageMin>0) {
          self.age.text = [NSString stringWithFormat:@"角色年龄：%ld至%ld岁",model.ageMin,model.ageMax];
    }else{
         self.age.text = [NSString stringWithFormat:@"角色年龄：暂无"];
    }
    if (model.typeName.length>0) {
         self.type.text = [NSString stringWithFormat:@"角色类型：%@",model.typeName];
    }else{
         self.type.text = [NSString stringWithFormat:@"角色类型：暂无"];
    }
    if (model.remark.length>0) {
          self.remark.text = [NSString stringWithFormat:@"角色备注：%@",model.remark];
    }else{
          self.remark.text = [NSString stringWithFormat:@"角色备注：暂无"];
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

- (IBAction)selectAction:(id)sender {
    self.otherSelect();
}
@end
