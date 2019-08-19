//
//  PlaceAuditCellB.m
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditCellB.h"

@interface PlaceAuditCellB ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)MLLabel *descLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *selectBtn;

@end

@implementation PlaceAuditCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        [_selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
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

-(void)reloadUIWithModel:(OrderStructM *)model
{
    if (model==nil) {
        return;
    }
    
    self.selectBtn.selected=model.isChoose;
    
    self.titleLab.text=model.title;
    self.priceLab.text=[NSString stringWithFormat:@"¥%@",model.price];
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

-(void)selectAction
{
    
}

@end
