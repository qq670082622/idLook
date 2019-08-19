//
//  PriceMainCell.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceMainCell.h"

@interface PriceMainCell ()
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@end

@implementation PriceMainCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
  
    NSString *cellID = @"PriceMainCell";
    PriceMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PriceMainCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}
-(void)setModel:(PriceModel *)model
{
    _model = model;
    _bg.layer.cornerRadius=5.0;
    _bg.layer.shadowOffset = CGSizeMake(8, 8);
    _bg.layer.shadowOpacity = 1.0;
    _bg.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.08].CGColor;
    _bg.backgroundColor=[UIColor whiteColor];
    _titleLab.font=[UIFont boldSystemFontOfSize:15.0];
    _titleLab.textColor=Public_Text_Color;
    _priceLab.font=[UIFont systemFontOfSize:15.0];
    _priceLab.textColor=[UIColor colorWithHexString:@"#666666"];
    _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
    //新增审核label
   
    _tipLab.textColor = [UIColor colorWithHexString:@"FF6600"];
    _tipLab.font = [UIFont systemFontOfSize:13];
    _tipLab.textAlignment = 0;
    if(model.advertType == 1){
        self.icon.image=[UIImage imageNamed:@"icon_video"];
        self.titleLab.text = @"视频";
    }else if (model.advertType == 2){
        self.icon.image=[UIImage imageNamed:@"icon_print"];
        self.titleLab.text = @"平面";
    }else{
       self.icon.image=[UIImage imageNamed:@"price_icon"];
        self.titleLab.text = @"套拍";
    }
//    self.icon.image=[UIImage imageNamed:[NSString stringWithFormat:@"price_icon_%ld",(long)model.subType]];
//    NSString *str = [NSString stringWithFormat:@"￥%ld/天",(long)model.price];
//
//    if (model.waitPrice>0) {
//        str = [NSString stringWithFormat:@"￥%ld/天",(long)model.waitPrice];
//    }
   
    NSDictionary *pdic = [model.detailInfoList firstObject];
    NSString *str = [NSString stringWithFormat:@"￥%d/天",[pdic[@"actorPrice"]integerValue]];

    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]} range:NSMakeRange(0,str.length-2)];
    self.priceLab.attributedText=attStr;
//    self.titleLab.text = model.title;
#warning 规则：新增审核不能再修改。只有修改报价审核中可以修改
    //需求一共“1.新增审核 2.修改审核 3.删除审核 4正常  其中2、4可修改
    //1:price无值，ex=1  2:price有值 ex=1 3:state=1
//    if (model.waitPrice == 0 && model.examinestate == 1) {//增加审核中
//        self.tipLab.text = [NSString stringWithFormat:@"您新增的报价为¥%ld/天，正在审核中。",(long)model.price];
//        self.priceLab.hidden = YES;
//
//    }else if (model.waitPrice > 0 && model.examinestate == 1){//修改审核
//        self.arrow.hidden = NO;
//        self.tipLab.text = [NSString stringWithFormat:@"您修改后的报价为¥%ld/天，正在审核中。",(long)model.price];
//
//    }else if (model.status==1){//删除审核
//        self.tipLab.text = [NSString stringWithFormat:@"删除正在审核中。"];
//    }else{//正常
//        //隐藏审核tip 修改title和price到中间
//        self.titleLab.y = self.contentView.center.y-7.5;
//        self.priceLab.y = self.titleLab.y;
//        self.tipLab.hidden = YES;
//        self.arrow.hidden = NO;
//    }
    
//状态11=新建报价审核中；12=修改报价审核中；13=删除报价审核中；21=新建报价审核通过；22=修改报价审核完成；23=删除报价审核通过；31=新建报价审核失败；32=修改报价审核失败；33=删除报价审核失败
    if (model.examineState==11) {//增加审核中
        self.tipLab.text = [NSString stringWithFormat:@"您新增的报价为¥%ld/天，正在审核中。",[pdic[@"examPrice"]integerValue]];
        self.priceLab.hidden = YES;
        
    }else if (model.examineState==12){//修改审核
        self.arrow.hidden = NO;
        self.tipLab.text = [NSString stringWithFormat:@"您修改后的报价为¥%ld/天，正在审核中。",[pdic[@"examPrice"]integerValue]];
        
    }else if (model.examineState==13){//删除审核
        self.tipLab.text = [NSString stringWithFormat:@"删除正在审核中。"];
    }else{//正常
        //隐藏审核tip 修改title和price到中间
        self.titleLab.y = self.contentView.center.y-7.5;
        self.priceLab.y = self.titleLab.y;
        self.tipLab.hidden = YES;
        self.arrow.hidden = NO;
    }
}
@end
