//
//  ScheduleLockCellD.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockCellD.h"

@interface ScheduleLockCellD ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *title2Lab;
@property(nonatomic,strong)UIButton *askBtn;
@property(nonatomic,strong)UIView *descV;
@property(nonatomic,strong)UILabel *priceLab;

@end

@implementation ScheduleLockCellD

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        _bgV.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_bgV];
        _bgV.layer.masksToBounds=YES;
        _bgV.layer.cornerRadius=6.0;
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(12);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
        }];
    }
    return _bgV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"档期保障";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(12);
        }];
    }
    return _titleLab;
}

-(UIView*)descV
{
    if (!_descV) {
        _descV=[[UIView alloc]init];
        [self.contentView addSubview:_descV];
        _descV.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
        [_descV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV);
            make.centerX.mas_equalTo(self.bgV);
            make.height.mas_equalTo(54);
            make.top.mas_equalTo(self.bgV).offset(45);
        }];
        
        MLLabel *lab=[[MLLabel alloc]init];
        lab.numberOfLines=2;
        lab.lineSpacing=5.0;
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont systemFontOfSize:12.0];
        lab.textColor=[UIColor colorWithHexString:@"#FF6600"];
        [_descV addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_descV).offset(10);
            make.centerX.mas_equalTo(_descV);
            make.top.mas_equalTo(_descV).offset(10);
        }];
        lab.text=@"预先支付档期预约金，锁定艺人档期，演员单方面解约，将向您赔偿双倍预约金，并退还预约金，拍摄完成后可抵总费用。";
    }
    return _descV;
}

-(UILabel*)title2Lab
{
    if (!_title2Lab) {
        _title2Lab=[[UILabel alloc]init];
        _title2Lab.font=[UIFont systemFontOfSize:15.0];
        _title2Lab.textColor=Public_Text_Color;
        _title2Lab.text=@"档期预约金";
        [self.contentView addSubview:_title2Lab];
        [_title2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.bottom.mas_equalTo(self.bgV).offset(-18);
        }];
    }
    return _title2Lab;
}

-(UIButton*)askBtn
{
    if (!_askBtn) {
        _askBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_askBtn setBackgroundImage:[UIImage imageNamed:@"project_expain"] forState:UIControlStateNormal];
        [self.contentView addSubview:_askBtn];
        [_askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.title2Lab);
            make.left.mas_equalTo(self.title2Lab.mas_right).offset(3);
        }];
        [_askBtn addTarget:self action:@selector(askAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askBtn;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:16.0];
        _priceLab.textColor=Public_Red_Color;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-12);
            make.bottom.mas_equalTo(self.bgV).offset(-17);
        }];
    }
    return _priceLab;
}

-(void)reloadUIWithPrice:(NSInteger)price
{
    [self bgV];
    [self titleLab];
    [self descV];
    [self title2Lab];
    [self askBtn];
    self.priceLab.text=[NSString stringWithFormat:@"￥%ld",price];
    
}

//档期预约金说明
-(void)askAction
{
    if (self.lookProtocolBlock) {
        self.lookProtocolBlock();
    }
}

@end
