//
//  AuditionServiceCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditionServiceCell.h"

@interface AuditionServiceCell ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *stateLabel;  //状态
@property(nonatomic,strong)UILabel *auditDayLabel;  //试镜天数
@property(nonatomic,strong)UILabel *auditPriceLabel;  //试镜费用
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIButton *payBtn;
@property(nonatomic,strong)UIButton *contactBtn;

@end

@implementation AuditionServiceCell

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

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgV).offset(15);
            make.left.mas_equalTo(self.bgV).offset(12);
        }];
        _icon.image = [UIImage imageNamed:@"center_role_cell"];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(3);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _titleLab;
}


-(UILabel*)stateLabel
{
    if (!_stateLabel) {
        _stateLabel=[[UILabel alloc]init];
        _stateLabel.font=[UIFont systemFontOfSize:12];
        _stateLabel.textColor=Public_Red_Color;
        [self.contentView addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-12);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _stateLabel;
}


-(UILabel*)auditDayLabel
{
    if (!_auditDayLabel) {
        _auditDayLabel=[[UILabel alloc]init];
        _auditDayLabel.font=[UIFont systemFontOfSize:13];
        _auditDayLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_auditDayLabel];
        [_auditDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(43);
        }];
    }
    return _auditDayLabel;
}

-(UILabel*)auditPriceLabel
{
    if (!_auditPriceLabel) {
        _auditPriceLabel=[[UILabel alloc]init];
        _auditPriceLabel.font=[UIFont systemFontOfSize:13];
        _auditPriceLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_auditPriceLabel];
        [_auditPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.auditDayLabel.mas_bottom).offset(5);
        }];
    }
    return _auditPriceLabel;
}

-(UIView*)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor=Public_Background_Color;
        [self.contentView addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.centerX.mas_equalTo(self.bgV);
            make.top.mas_equalTo(self.bgV).offset(100);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV;
}

-(UIButton*)payBtn
{
    if (!_payBtn) {
        _payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_payBtn];
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        _payBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        _payBtn.layer.cornerRadius=3.0;
        _payBtn.layer.masksToBounds=YES;
        _payBtn.layer.borderColor=Public_Red_Color.CGColor;
        _payBtn.layer.borderWidth=1;
        [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.bgV).offset(-10);
            make.right.mas_equalTo(self.bgV).offset(-12);
            make.size.mas_equalTo(CGSizeMake(56, 28));
        }];
        [_payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

-(UIButton*)contactBtn
{
    if (!_contactBtn) {
        _contactBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_contactBtn];
        [_contactBtn setTitle:@"联系脸探" forState:UIControlStateNormal];
        [_contactBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        _contactBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        _contactBtn.layer.cornerRadius=3.0;
        _contactBtn.layer.masksToBounds=YES;
        _contactBtn.layer.borderColor=[UIColor colorWithHexString:@"#BCBCBC"].CGColor;
        _contactBtn.layer.borderWidth=1;
        [_contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.bgV).offset(-10);
            make.right.mas_equalTo(self.bgV).offset(-78);
            make.size.mas_equalTo(CGSizeMake(68, 28));
        }];
        [_contactBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBtn;
}

-(void)reloadUIWithModel:(RoleServiceModel *)model
{
    [self bgV];
    [self icon];
    self.titleLab.text=@"选角服务";
    self.stateLabel.text=@"待支付";
    self.auditDayLabel.text=[NSString stringWithFormat:@"选角人数：%ld人",model.count];
    self.auditPriceLabel.text = [NSString stringWithFormat:@"选角费用：￥%.0f",model.totalPrice];
    [self lineV];
    [self payBtn];
    [self contactBtn];

    NSString *str=@"";
    switch (model.status) {
        case 0:
            str=@"待支付";
            break;
        case 1:
            str=@"已支付";
            break;
        case 2:
            str=@"已完成";
            break;
        case 3:
            str=@"已取消";
            break;
        default:
            break;
    }
    self.stateLabel.text=str;
    
    if (model.status==0) {
        self.payBtn.hidden=NO;
        [self.contactBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-78);
        }];
    }
    else
    {
        self.payBtn.hidden=YES;
        [self.contactBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-12);
        }];
    }

}

//去支付
-(void)payAction
{
    if (self.AuditionServiceCellPayBlock) {
        self.AuditionServiceCellPayBlock();
    }
}

//联系脸探
-(void)contactAction
{
    if (self.AuditionServiceCellContactBlock) {
        self.AuditionServiceCellContactBlock();
    }
}

@end
