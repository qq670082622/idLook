//
//  CastingCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/10.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "CastingCell.h"
@interface CastingCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *type;
- (IBAction)action:(id)sender;

@end
@implementation CastingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"CastingCell";
    CastingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CastingCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
//    cell.name.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
//    cell.sex.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
//    cell.age.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    return cell;
}
-(void)setModel:(CastingModel *)model
{
    _model = model;
    self.name.text = [NSString stringWithFormat:@"%@",model.roleName];
    if (model.sex!=0) {
          self.sex.text = [NSString stringWithFormat:@"性别:%@",model.sex==1?@"男":@"女"];
    }else{
          self.sex.text = [NSString stringWithFormat:@"性别:暂未选择"];
    }
    if (model.ageMax>0) {
         self.age.text = [NSString stringWithFormat:@"年龄:%d-%d岁",model.ageMin,model.ageMax];
    }else{
         self.age.text = [NSString stringWithFormat:@"年龄:暂未选择"];
    }
    if (model.heightMax>0) {
         self.height.text = [NSString stringWithFormat:@"身高:%d-%dcm",model.heightMin,model.heightMax];
    }else{
        self.height.text = [NSString stringWithFormat:@"身高:暂未选择"];
    }
    if (model.typeName.length>0) {
           self.type.text = [NSString stringWithFormat:@"类型:%@",model.typeName];
    }else{
        self.type.text = [NSString stringWithFormat:@"类型:暂未选择"];
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

- (IBAction)action:(id)sender {
    self.cellAction(_model);
}
@end
