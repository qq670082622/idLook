//
//  AnnunciateListCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateListCell.h"

@interface AnnunciateListCell ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *stateLabel;  //状态
@property(nonatomic,strong)UILabel *shotCityLabel;  //拍摄城市
@property(nonatomic,strong)UILabel *shotDateLabel;  //拍摄日期
@property(nonatomic,strong)UILabel *rewardLabel;  //期待片酬
@property(nonatomic,strong)UILabel *roleLabel;  //角色

@end

@implementation AnnunciateListCell

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
            make.centerY.mas_equalTo(self.titleLab);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
        }];
        _icon.image = [UIImage imageNamed:@"home_more_arrow"];
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
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(12);
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
            make.top.mas_equalTo(self.bgV).offset(48);
        }];
    }
    return _stateLabel;
}


-(UILabel*)shotCityLabel
{
    if (!_shotCityLabel) {
        _shotCityLabel=[[UILabel alloc]init];
        _shotCityLabel.font=[UIFont systemFontOfSize:12];
        _shotCityLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_shotCityLabel];
        [_shotCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(48);
        }];
    }
    return _shotCityLabel;
}

-(UILabel*)shotDateLabel
{
    if (!_shotDateLabel) {
        _shotDateLabel=[[UILabel alloc]init];
        _shotDateLabel.font=[UIFont systemFontOfSize:12];
        _shotDateLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_shotDateLabel];
        [_shotDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.shotCityLabel.mas_bottom).offset(5);
        }];
    }
    return _shotDateLabel;
}

-(UILabel*)rewardLabel
{
    if (!_rewardLabel) {
        _rewardLabel=[[UILabel alloc]init];
        _rewardLabel.font=[UIFont systemFontOfSize:12];
        _rewardLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_rewardLabel];
        [_rewardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.shotDateLabel.mas_bottom).offset(5);
        }];
    }
    return _rewardLabel;
}

-(UILabel*)roleLabel
{
    if (!_roleLabel) {
        _roleLabel=[[UILabel alloc]init];
        _roleLabel.font=[UIFont systemFontOfSize:13];
        _roleLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_roleLabel];
        [_roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.bottom.mas_equalTo(self.bgV).offset(-15);
        }];
    }
    return _roleLabel;
}

-(void)reloadUIWithModel:(AnnunciateListModel *)model
{
    [self bgV];
    [self icon];
    self.titleLab.text=model.title;
    self.shotCityLabel.text=[NSString stringWithFormat:@"拍摄城市：%@",model.shotCity];
    self.shotDateLabel.text=[NSString stringWithFormat:@"拍摄日期：%@至%@",model.shotStartDate,model.shotEndDate];
    self.rewardLabel.text=[NSString stringWithFormat:@"片酬：%@元",model.price];
    
    NSString *str=[NSString stringWithFormat:@"入选角色：%@",model.roleName];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]} range:NSMakeRange(5,str.length-5)];
    self.roleLabel.attributedText=attStr;
    
    NSString *status = @"";
    switch (model.status) {
        case 1:
            status=@"已选中";
            break;
        case 2:
            status=@"未入选";
            break;
        case 3:
            status=@"进行中";
            break;
        default:
            break;
    }
    
    self.stateLabel.text=status;;


}



@end
