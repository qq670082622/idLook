//
//  ShotStepCellB.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ShotStepCellB.h"

@interface ShotStepCellB ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)MLLabel *descLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIImageView *selectV;
@end

@implementation ShotStepCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(UIImageView*)selectV
{
    if (!_selectV) {
        _selectV=[[UIImageView alloc]init];
        [self.contentView addSubview:_selectV];
        _selectV.image=[UIImage imageNamed:@"works_noChoose"];
        [_selectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        
    }
    return _selectV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(47);
            make.top.mas_equalTo(self.contentView).offset(17);
        }];
    }
    return _titleLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:16.0];
        _priceLab.textColor=Public_Red_Color;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.titleLab);
        }];
    }
    return _priceLab;
}

-(MLLabel*)descLab
{
    if (!_descLab) {
        _descLab=[[MLLabel alloc]init];
        _descLab.numberOfLines=0;
        _descLab.lineSpacing=5.0;
        _descLab.font=[UIFont systemFontOfSize:12.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(47);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _descLab;
}

-(void)reloadUIWithModel:(OrderStructM *)model withRow:(NSInteger)row
{
    if (model==nil) {
        return;
    }
    
    NSString *title = @"";
    NSString *desc =@"";
    if (row==0) {
        desc=@"/3小时";
    }
    else
    {
        title=@"(或无需定妆)";
    }
    
    if (model.isChoose) {
        self.selectV.image=[UIImage imageNamed:@"works_choose"];
    }
    else
    {
        self.selectV.image=[UIImage imageNamed:@"works_noChoose"];

    }
    
    NSString *str1=[NSString stringWithFormat:@"%@%@",model.title,title];
    NSMutableAttributedString * attStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [attStr1 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(model.title.length,title.length)];
    self.titleLab.attributedText=attStr1;
    
    NSString *str2=[NSString stringWithFormat:@"¥%@%@",model.price,desc];
    NSMutableAttributedString * attStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attStr2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(model.price.length+1,desc.length)];
    self.priceLab.attributedText=attStr2;
    
    
    self.descLab.text=model.desc;
    
    if (model.desc.length==0) {
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(47);
            make.centerY.mas_equalTo(self.contentView).offset(0);
        }];
    }
    else
    {
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(47);
            make.top.mas_equalTo(self.contentView).offset(17);
        }];
    }
}

@end
