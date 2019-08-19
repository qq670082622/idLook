//
//  HistoryCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "HistoryCell.h"
@interface HistoryCell()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *editContent;
@end
@implementation HistoryCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"HistoryCell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    return cell;
}
-(void)setModel:(historyModel *)model
{
    self.time.text = model.changeTime;
    NSMutableString *contentStr = [NSMutableString new];
    if (model.changeDetailList.count>1) {
        for ( int i = 0;i<model.changeDetailList.count;i++) {
            NSDictionary *changeDic = model.changeDetailList[i];
            NSString *content = changeDic[@"content"];
            if (i>0) {
                [contentStr appendString:[NSString stringWithFormat:@"\n%@",content]];
            }else if(i==0){
                [contentStr appendString:content];
            }
        }
    }else{
        NSDictionary *changeDic = [model.changeDetailList firstObject];
         NSString *content = changeDic[@"content"];
         [contentStr appendString:content];
    }
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [contentStr length])];
    [self.editContent setAttributedText:attributedString1];
    [self.editContent sizeToFit];
   _cellHeight = _editContent.bottom+15;
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
