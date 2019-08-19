//
//  SorceCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "SorceCell.h"
@interface SorceCell()
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *sorce;
@property (weak, nonatomic) IBOutlet UILabel *statues;

@end
@implementation SorceCell
//@property(nonatomic,copy)NSString *reason;
//@property(nonatomic,copy)NSString *time;
//@property(nonatomic,assign)NSInteger type;//增减
//@property(nonatomic,assign)NSInteger sorce;//积分数量
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"SorceCell";
    SorceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SorceCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
       }
    
    return cell;
}
-(void)setModel:(SorceModel *)model
{

    _model = model;
    self.reason.text = model.title;
    self.time.text = model.datetime;
  
    if (model.status.length>0) {//减。红色
        self.statues.hidden = NO;
        self.sorce.y = 15;
        self.statues.text = model.status;
        self.statues.y = 40;
       }
    self.sorce.text = [NSString stringWithFormat:@"%ld",(long)model.point];
    if (model.point>0) {
        self.sorce.text = [NSString stringWithFormat:@"+%ld",(long)model.point];
    }
    if (model.point>0) {
        self.sorce.textColor = [UIColor colorWithHexString:@"#464646"];
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
