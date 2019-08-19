//
//  AnnunciateCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateCell.h"
@interface AnnunciateCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *city;
@property (weak, nonatomic) IBOutlet UIButton *price;
@property (weak, nonatomic) IBOutlet UIButton *role;
- (IBAction)apply:(id)sender;
- (IBAction)cellSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@end
@implementation AnnunciateCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"AnnunciateCell";
    AnnunciateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnnunciateCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.backView.layer.cornerRadius=8;
    cell.backView.layer.masksToBounds=YES;
    return cell;
}
-(void)setModel:(AnnunciateModel *)model
{
    _model = model;
    self.name.text = model.title;
    [self.time setTitle:[NSString stringWithFormat:@"   %@至%@",model.shotStartDate,model.shotEndDate] forState:0];
    [self.city setTitle:[NSString stringWithFormat:@"   %@",model.shotCity] forState:0];
    [self.price setTitle:[NSString stringWithFormat:@"   %ld-%ld元",model.priceStart,model.priceEnd] forState:0];
    [self.lookBtn setTitle:[NSString stringWithFormat:@"  %ld次",model.browseCount] forState:0];
    [self.applyBtn setTitle:[NSString stringWithFormat:@"  %ld人",model.applyCount] forState:0];
    [self.lookBtn sizeToFit];
    [self.applyBtn sizeToFit];
   
    self.applyBtn.frame = CGRectMake(self.backView.width-5-_applyBtn.width, 15, _applyBtn.width, 20);
     self.lookBtn.frame = CGRectMake(_applyBtn.x-_lookBtn.width-5, 15, _lookBtn.width, 20);
    if (model.priceStart==0) {
        [self.price setTitle:@"   自己申报" forState:0];
    }
    [self.role setTitle:[NSString stringWithFormat:@"   %@",model.roleListString] forState:0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)apply:(id)sender {
    self.apply(_model);
}

- (IBAction)cellSelect:(id)sender {
    self.cellSelect(_model);
}
@end
