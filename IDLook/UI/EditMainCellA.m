//
//  EditMainCellA.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditMainCellA.h"
#import "EditHeadV.h"

@interface EditMainCellA ()
@property(nonatomic,strong)EditHeadV *headV;
@property(nonatomic,strong)UIView *centerV;
@end

@implementation EditMainCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(EditHeadV*)headV
{
    if (!_headV) {
        _headV =[[EditHeadV alloc]init];
        [self.contentView addSubview:_headV];
        [_headV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(44);
        }];
        WeakSelf(self);
        _headV.editActionBlock = ^{
            weakself.EditMainCellAEditBlock();
        };
    }
    return _headV;
}

-(UIView *)centerV
{
    if (!_centerV) {
        _centerV=[[UIView alloc]init];
        _centerV.backgroundColor=[UIColor colorWithHexString:@"#FAFAFA"];
        _centerV.layer.masksToBounds=YES;
        _centerV.layer.cornerRadius=5.0;
        [self.contentView addSubview:_centerV];
        _centerV.clipsToBounds=YES;
        [_centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headV.mas_bottom).offset(100);
            make.height.mas_equalTo(175);
            make.centerX.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _centerV;
}

-(void)initUI
{
    NSArray *array = @[@"艺      名",@"语      言"];
    for (int i =0; i<2;i++) {
        UILabel *titleLab=[[UILabel alloc]init];
        titleLab.font=[UIFont systemFontOfSize:14.0];
        titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.headV.mas_bottom).offset(30+30*i);
        }];
        titleLab.text=array[i];
        
        UILabel *descLab=[[UILabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:14.0];
        descLab.textColor=Public_Text_Color;
        descLab.tag=1000+i;
        [self.contentView addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(137);
            make.top.mas_equalTo(self.headV.mas_bottom).offset(30+30*i);
            make.right.mas_equalTo(self).offset(-5);
        }];
    }
    
    
    CGFloat width = (UI_SCREEN_WIDTH-30)/3;
    CGFloat height = 175/2;
    for (int i = 0; i<6; i++) {
        EditBasicSubCell *cell=[[EditBasicSubCell alloc]init];
        cell.tag=100+i;
        [self.centerV addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.centerV).offset(width*(i%3));
            make.top.mas_equalTo(self.centerV).offset(height*(i/3));
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        [cell reloadUIWithType:0];
        
        UIView *lineV=[[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self.centerV addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell).offset(15);
            make.centerY.mas_equalTo(cell);
            make.width.mas_equalTo(0.5);
            make.left.mas_equalTo(cell.mas_right);
        }];
    }
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=Public_LineGray_Color;
    [self.centerV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerV);
        make.centerX.mas_equalTo(self.centerV);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(self.centerV).offset(10);
    }];
}

-(void)reloadUIWithTitle:(NSString *)title
{
    self.headV.title=title;
    
    for (int i = 0; i<6; i++) {
        EditBasicSubCell *cell = [self.contentView viewWithTag:100+i];
        [cell reloadUIWithType:i];
    }
    
    NSArray *array = @[[[UserInfoManager getUserNick]length]==0 ? @"暂未填写":[UserInfoManager getUserNick],[[UserInfoManager getUserLanguage]length]==0 ? @"暂未填写":[[UserInfoManager getUserLanguage] stringByReplacingOccurrencesOfString:@"|" withString:@"、"]];
    for (int i =0; i<2; i++) {
        UILabel *descLab = [self.contentView viewWithTag:1000+i];
        descLab.text=array[i];
    }
}

@end

@interface EditBasicSubCell ()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *value;
@end

@implementation EditBasicSubCell

-(id)init
{
    if (self=[super init]) {

    }
    return self;
}

-(UILabel*)title
{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.font=[UIFont systemFontOfSize:13.0];
        _title.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-22);
        }];
    }
    return _title;
}

-(UILabel*)value
{
    if (!_value) {
        _value=[[UILabel alloc]init];
        _value.font=[UIFont boldSystemFontOfSize:18.0];
        _value.textColor=Public_Text_Color;
        [self addSubview:_value];
        [_value mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(22);
        }];
    }
    return _value;
}

-(void)reloadUIWithType:(NSInteger)type
{
    NSArray *array = @[@"身高",@"体重",@"胸围",@"腰围",@"臀围",@"鞋码"];
    NSString *str;
    if (type==PickerTypeShoeSize) {
        str=@"码";
    }
    else if (type==PickerTypeWeight)
    {
        str=@"kg";
    }
    else
    {
        str=@"cm";
    }

    if ([UserInfoManager getUserBasicInfoWithType:type]==0) {
        self.value.text=@"未填写";
        self.value.textColor=[UIColor colorWithHexString:@"#999999"];

    }
    else
    {
        self.value.text=[NSString stringWithFormat:@"%ld%@",[UserInfoManager getUserBasicInfoWithType:type],str];
        self.value.textColor=Public_Text_Color;
    }
    
    self.title.text=array[type];
}

@end
