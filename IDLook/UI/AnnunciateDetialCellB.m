//
//  AnnunciateDetialCellB.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateDetialCellB.h"
#import "AnnunciateListModel.h"

@interface AnnunciateDetialCellB ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *nameLabel;  //名称
@property(nonatomic,strong)UILabel *dateLabel;  //时间
@property(nonatomic,strong)UILabel *cityLabel;  //地点
@property(nonatomic,strong)UILabel *cycleLabel;  //周期
@property(nonatomic,strong)UILabel *regionLabel;  //范围

@end

@implementation AnnunciateDetialCellB

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(13);
        }];
    }
    return _titleLab;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:13];
        _nameLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(43);
        }];
    }
    return _nameLabel;
}

-(UILabel*)dateLabel
{
    if (!_dateLabel) {
        _dateLabel=[[UILabel alloc]init];
        _dateLabel.font=[UIFont systemFontOfSize:13];
        _dateLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        }];
    }
    return _dateLabel;
}

-(UILabel*)cityLabel
{
    if (!_cityLabel) {
        _cityLabel=[[UILabel alloc]init];
        _cityLabel.font=[UIFont systemFontOfSize:13];
        _cityLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_cityLabel];
        [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.dateLabel.mas_bottom).offset(5);
        }];
    }
    return _cityLabel;
}

-(UILabel*)cycleLabel
{
    if (!_cycleLabel) {
        _cycleLabel=[[UILabel alloc]init];
        _cycleLabel.font=[UIFont systemFontOfSize:13];
        _cycleLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_cycleLabel];
        [_cycleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.cityLabel.mas_bottom).offset(5);
        }];
    }
    return _cycleLabel;
}

-(UILabel*)regionLabel
{
    if (!_regionLabel) {
        _regionLabel=[[UILabel alloc]init];
        _regionLabel.font=[UIFont systemFontOfSize:13];
        _regionLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_regionLabel];
        [_regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.cycleLabel.mas_bottom).offset(5);
        }];
    }
    return _regionLabel;
}

-(void)reloadUIWithDic:(NSDictionary*)dic
{
    NSDictionary *shotBroadcastBriefInfo = dic[@"shotBroadcastBriefInfo"];
    AnnunciateListModel *model = [AnnunciateListModel yy_modelWithDictionary:shotBroadcastBriefInfo];
    
    self.titleLab.text=@"项目信息";
    
    NSString *str1=[NSString stringWithFormat:@"通告名称：%@",model.title];
    NSMutableAttributedString * attStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [attStr1 addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str1.length-5)];
    self.nameLabel.attributedText=attStr1;
    
    NSString *str2=[NSString stringWithFormat:@"拍摄时间：%@至%@",model.shotStartDate,model.shotEndDate];
    NSMutableAttributedString * attStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attStr2 addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str2.length-5)];
    self.dateLabel.attributedText=attStr2;
    
    NSString *str3=[NSString stringWithFormat:@"拍摄地点：%@",model.shotCity];
    NSMutableAttributedString * attStr3 = [[NSMutableAttributedString alloc] initWithString:str3];
    [attStr3 addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str3.length-5)];
    self.cityLabel.attributedText=attStr3;
    
    NSString *str4=[NSString stringWithFormat:@"肖像周期：%ld年",model.shotCycle];
    NSMutableAttributedString * attStr4 = [[NSMutableAttributedString alloc] initWithString:str4];
    [attStr4 addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str4.length-5)];
    self.cycleLabel.attributedText=attStr4;
    
    NSString *str5=[NSString stringWithFormat:@"肖像范围：%@",model.shotRegion];
    NSMutableAttributedString * attStr5 = [[NSMutableAttributedString alloc] initWithString:str5];
    [attStr5 addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str5.length-5)];
    self.regionLabel.attributedText=attStr5;
}


@end
