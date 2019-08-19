//
//  AuditionPOCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditionPOCellA.h"
#import "AuditPOSubV.h"

@interface AuditionPOCellA ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UIImageView *icon;   //头像
@property(nonatomic,strong)UILabel *nameLab;  //名称
@property(nonatomic,strong)UIImageView *sexIcon;   //性别
@property(nonatomic,strong)UILabel *regionLab;  //所在地
@property(nonatomic,strong)UILabel *priceLab;  //价格
@property(nonatomic,strong)UIView *bottomV;  //
@property(nonatomic,strong)UIButton *remiderView; //提示
@end

@implementation AuditionPOCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self bgV];
    }
    return  self;
}

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
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return _bgV;
}

-(UIView*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[UIView alloc]init];
        _bottomV.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV);
            make.centerX.mas_equalTo(self.bgV);
            make.bottom.mas_equalTo(self.bgV);
            make.top.mas_equalTo(self.bgV).offset(93);
        }];
    }
    return _bottomV;
}


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"试镜艺人";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(12);
        }];
    }
    return _titleLab;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=16;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgV).offset(46);
            make.left.mas_equalTo(self.bgV).offset(12);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
    }
    return _icon;
}

-(UILabel*)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:16.0];
        _nameLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _nameLab;
}

-(UIImageView*)sexIcon
{
    if (!_sexIcon) {
        _sexIcon=[[UIImageView alloc]init];
        [self.contentView addSubview:_sexIcon];
        [_sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLab.mas_right).offset(2);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _sexIcon;
}

-(UILabel*)regionLab
{
    if (!_regionLab) {
        _regionLab=[[UILabel alloc]init];
        _regionLab.font=[UIFont systemFontOfSize:13];
        _regionLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_regionLab];
        [_regionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sexIcon.mas_right).offset(2);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _regionLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont systemFontOfSize:16.0];
        _priceLab.textColor=Public_Red_Color;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-12);
            make.centerY.mas_equalTo(self.icon);
        }];
        _priceLab.text=@"￥0";
    }
    return _priceLab;
}

-(UIButton*)remiderView
{
    if (!_remiderView) {
        _remiderView=[UIButton buttonWithType:UIButtonTypeCustom];
        [_remiderView setImage:[UIImage imageNamed:@"project_prompt"] forState:UIControlStateNormal];
        _remiderView.titleLabel.font=[UIFont systemFontOfSize:11];
        [_remiderView setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
        [self.contentView addSubview:_remiderView];
        [_remiderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(12);
            make.bottom.mas_equalTo(self.contentView).offset(-8);
        }];
        _remiderView.enabled=NO;
        _remiderView.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0,-5);
    }
    return _remiderView;
}


-(void)reloadUIWithProjectOrderInfo:(ProjectOrderInfoM *)info withArray:(NSArray *)array withType:(NSInteger)type
{
    if (info==nil) return;

    [self bgV];
    self.titleLab.text = type==0?@"试镜艺人":@"定妆艺人";
    
    [self.icon sd_setImageWithUrlStr:info.actorInfo[@"actorHead"] placeholderImage:[UIImage imageNamed:@"head_default"]];
    self.nameLab.text=info.actorInfo[@"actorName"];
    NSInteger sex = [info.actorInfo[@"sex"]integerValue];
    self.sexIcon.image = [UIImage imageNamed:sex==1?@"icon_male":@"icon_female"];
    self.regionLab.text=[NSString stringWithFormat:@"• %@",info.actorInfo[@"region"]];
    [self priceLab];
    
    for (UIView *view in self.bottomV.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i=0; i<array.count; i++) {
        OrderStructM *model  = array[i];
        AuditPOSubV *cell = [[AuditPOSubV alloc]init];
        [self.bottomV addSubview:cell];
        cell.tag=100+i;
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bottomV);
            make.right.mas_equalTo(self.bottomV);
            make.top.mas_equalTo(self.bottomV).offset(48*i);
            if ([model.title isEqualToString:@"最晚上传作品日期"]) {
                make.height.mas_equalTo(69);
            }
            else
            {
                make.height.mas_equalTo(48);
            }
        }];
        [cell reloadUIWithModel:model];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [cell addGestureRecognizer:tap];
        
        if (i==1) {
            self.priceLab.text=[NSString stringWithFormat:@"￥%@",model.price];
        }
        WeakSelf(self);
        cell.textFieldChangeBlock = ^(NSString *text) {
            weakself.AuditionPOCellAtextFieldChangeBlock(text,i);
        };
        cell.BeginEdit = ^{
            weakself.AuditionPOCellABeginEdit(i);
        };
    }
    
    if (type==0) { //试镜
        OrderStructM *model1 = array[1];
        if (model1.type==1) {  //自备
            [self.remiderView setTitle:@"如果下单后需要变更试镜时间和场地，可发布试镜通告重新告知演员" forState:UIControlStateNormal];;
            self.remiderView.hidden=NO;
            [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.contentView).offset(-30);
            }];
        }
        else
        {
            self.remiderView.hidden=YES;
            [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.contentView).offset(0);
            }];
        }
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap
{
    if (self.typeClickBlock) {
        self.typeClickBlock(tap.view.tag-100);
    }
}

@end

