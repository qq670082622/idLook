//
//  ScheduleLockCellB.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockCellB.h"

@interface ScheduleLockCellB ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *askBtn;

@end

@implementation ScheduleLockCellB

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
        _titleLab.text=@"项目服务费：￥600";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(UIButton*)askBtn
{
    if (!_askBtn) {
        _askBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_askBtn setBackgroundImage:[UIImage imageNamed:@"project_expain"] forState:UIControlStateNormal];
        [self.contentView addSubview:_askBtn];
        [_askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.bgV).offset(-15);
        }];
        [_askBtn addTarget:self action:@selector(askAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askBtn;
}


-(void)reloadUIWithPrice:(NSInteger)price
{
    [self bgV];
    self.titleLab.text=[NSString stringWithFormat:@"项目服务费：￥%ld",price];
    [self askBtn];
}


-(void)askAction
{
    if (self.lookServiceExpainBlock) {
        self.lookServiceExpainBlock();
    }
}

@end
