//
//  ProjectCell2.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectCell2.h"
@interface ProjectCell2()
@property (weak, nonatomic) IBOutlet UILabel *projectNum;
@property (weak, nonatomic) IBOutlet UILabel *projectName;

- (IBAction)btnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *guoqiImg;


@end
@implementation ProjectCell2
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectCell2";
    ProjectCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectCell2" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
  return cell;
}
-(void)setDic:(NSDictionary *)dic
{

    _dic = dic;
//    BOOL state = [dic[@"canDel"] boolValue];
//    if (state) {
//         [self.actionBtn setTitle:@"查看" forState:0];//过期项目只能查看不能编辑
//        self.guoqiImg.hidden = NO;
//    }else{
//         [self.actionBtn setTitle:@"编辑" forState:0];//未过期项目
//         self.guoqiImg.hidden = YES;
//    }
        BOOL overtime = [dic[@"overtime"] boolValue];
    if (overtime) {//国旗项目不能编辑不能查看
        self.projectName.textColor = [UIColor colorWithHexString:@"#bcbcbc"];
        [self.actionBtn setTitle:@"查看" forState:0];//过期项目只能查看不能编辑
        self.guoqiImg.hidden = NO;
    }else{
        [self.actionBtn setTitle:@"编辑" forState:0];//未过期项目
        self.guoqiImg.hidden = YES;
    }
    self.projectNum.text = [NSString stringWithFormat:@"项目编号：     %@",dic[@"projectId"]];
    self.projectName.text = [NSString stringWithFormat:@"项目名称：     %@",dic[@"projectName"]];
    [self.projectNum sizeToFit];
    [self.projectName sizeToFit];
    self.guoqiImg.x = _projectName.right+10;
}
//选中
- (IBAction)btnAction:(id)sender {

    self.btnClicked(self.actionBtn.titleLabel.text);
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
