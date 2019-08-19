//
//  PlayRoleView.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "PlayRoleView.h"

@interface PlayRoleView ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *nameLabel;    //名称
@property(nonatomic,strong)UILabel *sexLabel;   //性别
@property(nonatomic,strong)UILabel *heightLabel;    //身高
@property(nonatomic,strong)UILabel *ageLabel;       //年龄
@property(nonatomic,strong)UILabel *typeLabel;  //类型
@property(nonatomic,strong)UILabel *remarkLabel;      //备注
@end

@implementation PlayRoleView

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:13];
        _titleLab.textColor=Public_DetailTextLabelColor;
        _titleLab.text=@"饰演角色：";
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(5);
        }];
    }
    return _titleLab;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:13];
        _nameLabel.textColor=Public_Text_Color;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(80);
            make.right.mas_equalTo(self.mas_centerX).offset(30);
            make.top.mas_equalTo(self).offset(5);
        }];
    }
    return _nameLabel;
}

-(UILabel*)sexLabel
{
    if (!_sexLabel) {
        _sexLabel=[[UILabel alloc]init];
        _sexLabel.font=[UIFont systemFontOfSize:13];
        _sexLabel.textColor=Public_Text_Color;
        [self addSubview:_sexLabel];
        [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX).offset(40);
            make.centerY.mas_equalTo(self.nameLabel);
        }];
    }
    return _sexLabel;
}


-(UILabel*)heightLabel
{
    if (!_heightLabel) {
        _heightLabel=[[UILabel alloc]init];
        _heightLabel.font=[UIFont systemFontOfSize:13];
        _heightLabel.textColor=Public_Text_Color;
        [self addSubview:_heightLabel];
        [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(80);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(3);
        }];
    }
    return _heightLabel;
}

-(UILabel*)ageLabel
{
    if (!_ageLabel) {
        _ageLabel=[[UILabel alloc]init];
        _ageLabel.font=[UIFont systemFontOfSize:13];
        _ageLabel.textColor=Public_Text_Color;
        [self addSubview:_ageLabel];
        [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX).offset(40);
            make.centerY.mas_equalTo(self.heightLabel);
        }];
    }
    return _ageLabel;
}

-(UILabel*)typeLabel
{
    if (!_typeLabel) {
        _typeLabel=[[UILabel alloc]init];
        _typeLabel.font=[UIFont systemFontOfSize:13];
        _typeLabel.textColor=Public_Text_Color;
        [self addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(80);
            make.top.mas_equalTo(self.heightLabel.mas_bottom).offset(3);
        }];
    }
    return _typeLabel;
}

-(UILabel*)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel=[[UILabel alloc]init];
        _remarkLabel.font=[UIFont systemFontOfSize:13];
        _remarkLabel.textColor=Public_Text_Color;
        [self addSubview:_remarkLabel];
        [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(80);
            make.top.mas_equalTo(self.typeLabel.mas_bottom).offset(3);
        }];
    }
    return _remarkLabel;
}


-(void)reloadUIWithDic:(NSDictionary *)dic
{
    [self titleLab];
    
    NSString *roleName = (NSString*)safeObjectForKey(dic, @"roleName");
    NSInteger sex = [(NSNumber*)safeObjectForKey(dic, @"sex")integerValue];
    NSInteger heightMin = [(NSNumber*)safeObjectForKey(dic, @"heightMin")integerValue];
    NSInteger heightMax = [(NSNumber*)safeObjectForKey(dic, @"heightMax")integerValue];
    NSInteger ageMin = [(NSNumber*)safeObjectForKey(dic, @"ageMin")integerValue];
    NSInteger ageMax = [(NSNumber*)safeObjectForKey(dic, @"ageMax")integerValue];
    NSString *typeName = (NSString*)safeObjectForKey(dic, @"typeName");
    NSString *remark = (NSString*)safeObjectForKey(dic, @"remark");
    self.nameLabel.text = [NSString stringWithFormat:@"名称：%@",roleName];
    self.sexLabel.text = [NSString stringWithFormat:@"性别：%@",sex==1?@"男":@"女"];
    self.heightLabel.text = [NSString stringWithFormat:@"身高：%ld至%ldcm",heightMin,heightMax];
    self.ageLabel.text = [NSString stringWithFormat:@"年龄：%ld至%ld岁",ageMin,ageMax];
    self.typeLabel.text = [NSString stringWithFormat:@"类型：%@",typeName];
    self.remarkLabel.text = [NSString stringWithFormat:@"备注：%@",remark];

}

@end
