//
//  InsuranceQuestionsCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceQuestionsCell.h"
@interface InsuranceQuestionsCell()
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UILabel *label0;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@end
@implementation InsuranceQuestionsCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"InsuranceQuestionsCell";
    InsuranceQuestionsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InsuranceQuestionsCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.label0.text=@"建议只买一份，因为保额不叠加，即使您购买了20万版和30万版，也只能享受30万的最高保险额度";
    cell.label1.text=@"1.因被保险人挑衅或故意行为而导致的打斗、被袭击或被谋杀 \n2.被保险人妊娠、流产、分娩、疾病、药物过敏、中暑、猝死 \n3.被保险人未遵医嘱，私自服用、涂用、注射药物 \n4.被保险人醉酒或受毒品、管制药物的影响期间 \n5.被保险人酒后驾车、无有效驾驶证驾驶或驾驶无有效行驶证的机动车期间 \n6.被保险人从事高风险运动或参加职业或半职业体育运动";
    cell.label2.text=@"高风险运动指比一般常规性的运动风险等级更高、更容易发生人身伤害的运动，在进行此类运动前需有充分的心理准备和行动上的准备，必须具备一般人不具备的相关知识和技能或者必须在接受专业人士提供的培训或训练之后方能掌握。被保险人进行此类运动时须具备相关防护措施或设施，以避免发生损失或减轻损失，包括但不限于潜水，滑水，滑雪，滑冰，驾驶或乘坐滑翔翼、滑翔伞，跳伞，攀岩运动，探险活动，武术比赛，摔跤比赛，柔道，空手道，跆拳道，马术，拳击，特技表演，驾驶卡丁车，赛马，赛车，各种车辆表演,蹦极。";
    cell.label3.text=@"被保险人进行此类运动时须具备相关防护措施或设施，以避免发生损失或减轻损失，包括但不限于潜水，滑水，滑雪，滑冰";
    cell.label4.text=@"被保险人进行此类运动时须具备相关防护措施或设施，以避免发生损失或减轻损失，包括但不限于潜水，滑水，滑雪，滑冰";
   [cell.label0 sizeToFit];
    [cell.label1 sizeToFit];
 
     [cell.label2 sizeToFit];
     [cell.label3 sizeToFit];
     [cell.label4 sizeToFit];
    cell.view0.height = cell.label0.height+20;
       cell.view1.height = cell.label1.height+20;
       cell.view2.height = cell.label2.height+20;
       cell.view3.height = cell.label3.height+20;
       cell.view4.height = cell.label4.height+20;
    
    cell.btn1.y = cell.view0.bottom+15;
    cell.view1.y = cell.btn1.bottom+5;
    
    cell.btn2.y = cell.view1.bottom+15;
    cell.view2.y = cell.btn2.bottom+5;
    
    cell.btn3.y = cell.view2.bottom+15;
    cell.view3.y = cell.btn3.bottom+5;
    
    cell.btn4.y = cell.view3.bottom+15;
    cell.view4.y = cell.btn4.bottom+5;
    
    cell.cellHeight = cell.view2.bottom + 60;
   return cell;
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
