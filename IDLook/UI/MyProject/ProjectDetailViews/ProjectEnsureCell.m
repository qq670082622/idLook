//
//  ProjectEnsureCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/4.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectEnsureCell.h"
@interface ProjectEnsureCell()
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnAction:(id)sender;

@end
@implementation ProjectEnsureCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectEnsureCell";
    ProjectEnsureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectEnsureCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}
-(void)setBtnTitle:(NSString *)btnTitle
{
    [self.btn setTitle:btnTitle forState:0];
    self.btn.layer.cornerRadius=5.0;
    self.btn.layer.masksToBounds=YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnAction:(id)sender {
    [self.delegate ProjectEnsureCellClicked];
}
@end
