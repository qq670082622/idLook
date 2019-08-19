//
//  AnnunRoleCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunRoleCell.h"
#import "WriteFileManager.h"
@interface AnnunRoleCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *desc2;

@property (weak, nonatomic) IBOutlet UIView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
- (IBAction)check:(id)sender;

- (IBAction)apply:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@end
@implementation AnnunRoleCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"AnnunRoleCell";
    AnnunRoleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnnunRoleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.backView.layer.cornerRadius=8;
    cell.backView.layer.masksToBounds=YES;
    return cell;
}
-(void)setIndex:(NSInteger)index
{
    _index = index;
    [self.numBtn setTitle:[NSString stringWithFormat:@"角色%ld",index+1] forState:0];
}
-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    NSInteger sex = [dic[@"sex"] integerValue];
    self.roleName.text = [NSString stringWithFormat:@"%@",dic[@"roleName"]];
    [self.roleName sizeToFit];
    
    self.numBtn.x = _roleName.right+10;
    NSInteger budget = [dic[@"budget"] integerValue];
    if (budget>0) {
        self.price.text = [NSString stringWithFormat:@"￥%ld/天",budget];
    }else{
        self.price.text = @"自己申报";
    }
    NSString *remark = dic[@"remark"];
     remark = remark.length>0?[NSString stringWithFormat:@"2.%@",remark]:@"";
   
    NSInteger ageMax = [dic[@"ageMax"] integerValue];
     NSInteger ageMin = [dic[@"ageMin"] integerValue];
    
    NSInteger heightMax = [dic[@"heightMax"] integerValue];
    NSInteger heightMin = [dic[@"heightMin"] integerValue];
    
    NSString *sexStr;
    NSString *ageStr;
    NSString *heightStr;
    
    if (sex>0) {
        sexStr =   sex==1?@"男":@"女";
    }else{
        sexStr = @"性别不限";
    }
    
    if (ageMax>0) {
        ageStr = [NSString stringWithFormat:@"年龄%ld-%ld",ageMin,ageMax];
    }else{
        ageStr = @"年龄不限";
    }
  
    if (heightMax>0) {
        heightStr = [NSString stringWithFormat:@"身高%ld-%ld",heightMin,heightMax];
    }else{
        heightStr = @"身高不限";
    }
    
    self.desc.text = [NSString stringWithFormat:@"角色要求:\n1.%@,%@,%@",sexStr,ageStr,heightStr];
    self.desc2.text = remark;
    [_desc2 sizeToFit];
    self.imgView.y = _desc2.bottom+9;
    self.applyBtn.y = self.imgView.y;
    self.backView.height = _imgView.bottom+15;
    self.cellHeight = _backView.height+10;
    NSString *pic = dic[@"referPicture"];
    if (pic.length>0) {
        [self.img sd_setImageWithUrlStr:pic];
    }else{
        self.imgView.hidden = YES;
    }
//    ageMax = 20;
//    ageMin = 30;
//    budget = 0;
//    heightMax = 160;
//    heightMin = 170;
//    referPicture = "<null>";
//    remark = remark;
//    roleId = 9;
//    roleName = "\U5973\U4e3b";
//    sex = 2;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)check:(id)sender {
    NSString *pic = _dic[@"referPicture"];
    self.checkImg(pic);
}

- (IBAction)apply:(id)sender {
    self.apply(_dic);
}
@end
