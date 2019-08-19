//
//  ProjectCell.m
//  IDLook
//
//  Created by 吴铭 on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ProjectCell.h"
@interface ProjectCell()
@property (weak, nonatomic) IBOutlet UILabel *projectNum;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
- (IBAction)btnAction:(id)sender;
- (IBAction)subAction:(id)sender;

@end
@implementation ProjectCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectCell";
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
     }
    cell.actionBtn.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    cell.projectNum.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    cell.projectName.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    return cell;
}
-(void)setModel:(ProjectModel *)model
{
    
    _model = model;
    if (model.status==0) {//1，正常 2，进行中,进行中需要查看
   
    [self.actionBtn setTitle:@"查看" forState:0];
    }
    self.projectNum.text = [NSString stringWithFormat:@"项目编号：     %ld",(long)model.id];
    self.projectName.text = [NSString stringWithFormat:@"项目名称：     %@",model.name];
}
//-(void)setDic:(NSDictionary *)dic
//{
//
//    _dic = dic;
//    BOOL state = [dic[@"canDel"] boolValue];
//    if (!state) {
//         [self.actionBtn setTitle:@"查看" forState:0];
//    }
//        BOOL overtime = [dic[@"overtime"] boolValue];
//    if (overtime) {//国旗项目不能编辑不能查看
//        self.projectName.textColor = [UIColor colorWithHexString:@"#bcbcbc"];
//    }
//    self.projectNum.text = [NSString stringWithFormat:@"项目编号：     %@",dic[@"projectId"]];
//    self.projectName.text = [NSString stringWithFormat:@"项目名称：     %@",dic[@"projectName"]];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//选中
- (IBAction)btnAction:(id)sender {
//    if (_isSelectType) {
//        BOOL state = [_dic[@"projectStatus"]boolValue];
//        if (state==0) {
//            [SVProgressHUD showErrorWithStatus:@"该项目已过期"];
//            return;
//        }else{
//            self.btnClicked(@"选择");
//        }
//    }else{
//        BOOL state = [_dic[@"canDel"] boolValue];
//        if (!state)  {//1，正常 2，进行中,进行中需要查看
//            self.btnClicked(@"查看");
//        }else{
//            self.btnClicked(@"编辑");
//        }
//    }
    
    if (_model.status==0) {//1，正常 2，进行中,进行中需要查看
        
        self.btnClicked(@"查看");
    }else{
        self.btnClicked(@"编辑");
    }
}
//点击 查看或者编辑
- (IBAction)subAction:(id)sender {
//    BOOL state = [_dic[@"canDel"] boolValue];
//    if (!state)  {//1，正常 2，进行中,进行中需要查看
//        self.btnClicked(@"查看");
//    }else{
//        self.btnClicked(@"编辑");
//    }
  
    if (_model.status==0) {//1，正常 2，进行中,进行中需要查看
        
        self.btnClicked(@"查看");
    }else{
         self.btnClicked(@"编辑");
    }
}
@end
