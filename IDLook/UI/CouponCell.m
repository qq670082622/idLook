//
//  CouponCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()
@property(nonatomic,strong)UIImageView *bg;
@property(nonatomic,strong)UIImageView *rightV;
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *rateLab;  //折扣
@property(nonatomic,strong)UILabel *stateLab;  //状态
@property(nonatomic,strong)UILabel *descLab;  //描述
@property(nonatomic,strong)UILabel *dateLab;  //时间
@property(nonatomic,strong)UILabel *phoneLab;  //分享人
@property(nonatomic,strong)UIButton *selectBtn;  //选择按钮
@property(nonatomic,strong)UILabel *btnLab;  //优先使用文字
@end

@implementation CouponCell

-(UIImageView*)bg
{
    if (!_bg) {
        _bg=[[UIImageView alloc]init];
        _bg.userInteractionEnabled=YES;
        [self.contentView addSubview:_bg];
//        _bg.contentMode=UIViewContentModeScaleAspectFill;
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
        }];
        _bg.image=[UIImage imageNamed:@"me_coupon_list_bg_w"];
    }
    return _bg;
}

-(UIImageView*)rightV
{
    if (!_rightV) {
        _rightV=[[UIImageView alloc]init];
        _rightV.userInteractionEnabled=YES;
        [self.bg addSubview:_rightV];
//        _rightV.contentMode=UIViewContentModeScaleAspectFill;
        [_rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bg);
            make.top.mas_equalTo(self.bg);
        }];
        _rightV.image=[UIImage imageNamed:@"me_coupon_list_bg_o"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAction)];
        [_rightV addGestureRecognizer:tap];
    }
    return _rightV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(110);
            make.top.mas_equalTo(self.bg).offset(18);
        }];
    }
    return _titleLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        _descLab.font=[UIFont systemFontOfSize:12];
        _descLab.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(4);
        }];
    }
    return _descLab;
}

-(UILabel*)dateLab
{
    if (!_dateLab) {
        _dateLab=[[UILabel alloc]init];
        _dateLab.font=[UIFont systemFontOfSize:12];
        _dateLab.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_dateLab];
        [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.descLab.mas_bottom).offset(4);
        }];
    }
    return _dateLab;
}

-(UILabel*)phoneLab
{
    if (!_phoneLab) {
        _phoneLab=[[UILabel alloc]init];
        _phoneLab.font=[UIFont systemFontOfSize:12];
        _phoneLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_phoneLab];
        [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.dateLab.mas_bottom).offset(8);
        }];
    }
    return _phoneLab;
}

-(UILabel*)rateLab
{
    if (!_rateLab) {
        _rateLab=[[UILabel alloc]init];
        _rateLab.font=[UIFont boldSystemFontOfSize:25];
        _rateLab.textColor=Public_Red_Color;
        [self.contentView addSubview:_rateLab];
        [_rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.stateLab);
            make.top.mas_equalTo(self.contentView).offset(24);
        }];
    }
    return _rateLab;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc]init];
        _stateLab.font=[UIFont systemFontOfSize:10];
        _stateLab.textAlignment=NSTextAlignmentCenter;
        _stateLab.textColor=Public_DetailTextLabelColor;
        _stateLab.backgroundColor=[UIColor colorWithHexString:@"#E6E6E6"];
        [self.contentView addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(20);
            make.bottom.mas_equalTo(self.bg).offset(-24);
            make.size.mas_equalTo(CGSizeMake(55, 17));
        }];
    }
    return _stateLab;
}

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"me_coupon_list_radio_n"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"me_coupon_list_radio_s"] forState:UIControlStateSelected];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"me_coupon_list_radio_e"] forState:UIControlStateDisabled];

        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.rightV);
            make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-3);
        }];
        [_selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UILabel*)btnLab
{
    if (!_btnLab) {
        _btnLab=[[UILabel alloc]init];
        _btnLab.font=[UIFont systemFontOfSize:12];
        _btnLab.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_btnLab];
        _btnLab.text=@"优先使用";
        [_btnLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.rightV);
            make.top.mas_equalTo(self.contentView.mas_centerY).offset(3);
        }];
    }
    return _btnLab;
}

-(void)reloadUIWithModel:(CouponModel *)model
{
    [self bg];
    [self rightV];
    self.titleLab.text=@"下单立减返现券";
    self.descLab.text=@"仅限拍摄下单时使用";
    self.dateLab.text=[NSString stringWithFormat:@"%@至%@",model.useStartDate,model.useEndDate];
    self.phoneLab.text= [NSString stringWithFormat:@"分享人：%@",model.sharePhone];
    
    NSString *state =@"";
    switch (model.status) {
        case 1:
            state=@"待使用";
            break;
        case 2:
            state=@"已使用";
            break;
        case 10:
            state=@"已失效";
            break;
            
        default:
            break;
    }

    if (model.status==1) {
        self.stateLab.textColor=Public_Red_Color;
        self.stateLab.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
        self.btnLab.textColor=[UIColor whiteColor];
        self.selectBtn.enabled=YES;
    }
    else
    {
        self.stateLab.textColor=Public_DetailTextLabelColor;
        self.stateLab.backgroundColor=[UIColor colorWithHexString:@"#E6E6E6"];
        self.btnLab.textColor=[[UIColor whiteColor]colorWithAlphaComponent:0.4];
        self.selectBtn.enabled=NO;
    }
    self.stateLab.text=state;
    
    NSString *rate = [NSString stringWithFormat:@"%ld",(NSInteger)([model.rate floatValue]*100)];
    NSString *str=[NSString stringWithFormat:@"%@%%",rate];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:40]} range:NSMakeRange(0,rate.length)];
    self.rateLab.attributedText=attStr;
    
    if (model.status==10) {
        self.rightV.image=[UIImage imageNamed:@"me_coupon_list_bg_b"];
        self.rateLab.textColor=[UIColor colorWithHexString:@"#E6E6E6"];
        self.titleLab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
        self.descLab.textColor=[UIColor colorWithHexString:@"#E6E6E6"];
        self.dateLab.textColor=[UIColor colorWithHexString:@"#E6E6E6"];
        self.phoneLab.textColor=[UIColor colorWithHexString:@"#E6E6E6"];
    }
    else
    {
        self.rightV.image=[UIImage imageNamed:@"me_coupon_list_bg_o"];
        self.rateLab.textColor=Public_Red_Color;
        self.titleLab.textColor=Public_Text_Color;
        self.descLab.textColor=Public_DetailTextLabelColor;
        self.dateLab.textColor=Public_DetailTextLabelColor;
        self.phoneLab.textColor=Public_Text_Color;
    }
    self.selectBtn.selected=model.firstPriority;
}

-(void)selectAction
{
    if (self.selectBtn.enabled==NO) {
        return;
    }
    if (self.selectBtn.selected==YES) {
        return;
    }
    if (self.getFirstBlock) {
        self.getFirstBlock();
    }
}

@end
