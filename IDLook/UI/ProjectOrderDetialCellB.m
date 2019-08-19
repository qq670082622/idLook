//
//  ProjectOrderDetialCellB.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderDetialCellB.h"

@interface ProjectOrderDetialCellB ()
@property(nonatomic,strong)UILabel *titleLabel;  //标题
@property(nonatomic,strong)UILabel *nameLabel;    //项目名称
@property(nonatomic,strong)MLLabel *briefLabel;   //项目简介
@property(nonatomic,strong)UILabel *cityLabel;    //拍摄城市
@property(nonatomic,strong)UILabel *dayLabel;       //拍摄天数
@property(nonatomic,strong)UILabel *shotTimeLabel;  //预拍周期
@property(nonatomic,strong)UILabel *cycleLabel;      //肖像周期
@property(nonatomic,strong)UILabel *regionLabel;   //肖像范围

@property(nonatomic,strong)UIView *scriptV;  //脚本图片view

@end

@implementation ProjectOrderDetialCellB

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor=Public_Text_Color;
        _titleLabel.text=@"项目信息";
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(12);
        }];
    }
    return _titleLabel;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:13];
        _nameLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(43);
        }];
    }
    return _nameLabel;
}

-(MLLabel*)briefLabel
{
    if (!_briefLabel) {
        _briefLabel=[[MLLabel alloc]init];
        _briefLabel.numberOfLines=0;
        _briefLabel.lineSpacing=3;
        _briefLabel.font=[UIFont systemFontOfSize:13];
        _briefLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_briefLabel];
        [_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-9);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        }];
    }
    return _briefLabel;
}

-(UIView*)scriptV
{
    if (!_scriptV) {
        _scriptV = [[UIView alloc]init];
        [self.contentView addSubview:_scriptV];
//        _scriptV.backgroundColor=[UIColor redColor];
        [_scriptV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.briefLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(100);
        }];
    }
    return _scriptV;
}

-(UILabel*)cityLabel
{
    if (!_cityLabel) {
        _cityLabel=[[UILabel alloc]init];
        _cityLabel.font=[UIFont systemFontOfSize:13];
        _cityLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_cityLabel];
        [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.scriptV.mas_bottom).offset(5);
        }];
    }
    return _cityLabel;
}

-(UILabel*)dayLabel
{
    if (!_dayLabel) {
        _dayLabel=[[UILabel alloc]init];
        _dayLabel.font=[UIFont systemFontOfSize:13];
        _dayLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_dayLabel];
        [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.cityLabel.mas_bottom).offset(5);
        }];
    }
    return _dayLabel;
}

-(UILabel*)shotTimeLabel
{
    if (!_shotTimeLabel) {
        _shotTimeLabel=[[UILabel alloc]init];
        _shotTimeLabel.font=[UIFont systemFontOfSize:13];
        _shotTimeLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_shotTimeLabel];
        [_shotTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.dayLabel.mas_bottom).offset(5);
        }];
    }
    return _shotTimeLabel;
}

-(UILabel*)cycleLabel
{
    if (!_cycleLabel) {
        _cycleLabel=[[UILabel alloc]init];
        _cycleLabel.font=[UIFont systemFontOfSize:13];
        _cycleLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_cycleLabel];
        [_cycleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.shotTimeLabel.mas_bottom).offset(5);
        }];
    }
    return _cycleLabel;
}

-(UILabel*)regionLabel
{
    if (!_regionLabel) {
        _regionLabel=[[UILabel alloc]init];
        _regionLabel.font=[UIFont systemFontOfSize:13];
        _regionLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_regionLabel];
        [_regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.cycleLabel.mas_bottom).offset(5);
        }];
    }
    return _regionLabel;
}

-(void)reloadUIWithInfo:(ProjectOrderInfoM *)info
{
    [self titleLabel];
    
    NSString *projectCity = (NSString*)safeObjectForKey(info.projectInfo, @"projectCity");
    NSString *projectDesc = (NSString*)safeObjectForKey(info.projectInfo, @"projectDesc");
    NSString *projectEnd = (NSString*)safeObjectForKey(info.projectInfo, @"projectEnd");
    NSString *projectId = (NSString*)safeObjectForKey(info.projectInfo, @"projectId");
    NSString *projectName = (NSString*)safeObjectForKey(info.projectInfo, @"projectName");
    NSString *projectStart = (NSString*)safeObjectForKey(info.projectInfo, @"projectStart");
    NSString *shotCycle = (NSString*)safeObjectForKey(info.projectInfo, @"shotCycle");
    NSInteger shotDays = [(NSNumber*)safeObjectForKey(info.projectInfo, @"shotDays")integerValue];
    NSString *shotRegion = (NSString*)safeObjectForKey(info.projectInfo, @"shotRegion");

    
    NSString *str1=[NSString stringWithFormat:@"项目名称：%@",projectName];
    NSMutableAttributedString * attStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [attStr1 addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
    self.nameLabel.attributedText=attStr1;
    
    NSString *str2=[NSString stringWithFormat:@"项目简介：%@",projectDesc.length>0?projectDesc:@"无"];
    NSMutableAttributedString * attStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attStr2 addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
    self.briefLabel.attributedText=attStr2;
    
    for (UIView *view in self.scriptV.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width = (UI_SCREEN_WIDTH -30-3*8)/4;
    NSInteger count = info.projectScriptList.count;
    
    [self.scriptV mas_updateConstraints:^(MASConstraintMaker *make) {
        if (count==0) {
            make.height.mas_equalTo(0);
        }
        else
        {
            make.height.mas_equalTo((width+10)*((count-1)/4+1)+10);
        }
    }];
    
    for (UIView *view in self.scriptV.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i=0; i<info.projectScriptList.count; i++) {
        
        NSDictionary *dic = info.projectScriptList[i];
        NSInteger type = [(NSNumber*)safeObjectForKey(dic, @"type")integerValue];  //脚本文件类型 1:图片; 2:视频
        NSString *url = (NSString*)safeObjectForKey(dic, @"url");
        NSString *cutUrl = (NSString*)safeObjectForKey(dic, @"cutUrl");
        int duration = [(NSNumber*)safeObjectForKey(dic, @"duration")intValue];

        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.userInteractionEnabled=YES;
        imageV.layer.cornerRadius=4.0;
        imageV.layer.masksToBounds=YES;
        imageV.tag=10000+i;
        imageV.contentMode=UIViewContentModeScaleAspectFill;
        imageV.backgroundColor=[UIColor grayColor];
        [self.scriptV addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scriptV).offset(10+(width+10)*(i/4));
            make.left.mas_equalTo(self.scriptV).offset(15+(width+8)*(i%4));
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];
        if (type==1) { //图片
            [imageV sd_setImageWithUrlStr:url placeholderImage:[UIImage imageNamed:@"default_home"]];
        }
        else if (type==2)  //视频
        {
             [imageV sd_setImageWithUrlStr:cutUrl placeholderImage:[UIImage imageNamed:@"default_home"]];
            
            UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [imageV addSubview:timeBtn];
            timeBtn.backgroundColor = [UIColor clearColor];
            timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            timeBtn.titleLabel.textColor = [UIColor whiteColor];
            [timeBtn setImage:[UIImage imageNamed:@"video_icon"] forState:UIControlStateNormal];
            [timeBtn setTitle:[PublicManager timeFormatted:duration] forState:UIControlStateNormal];
            [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(imageV).offset(5);
                make.bottom.mas_equalTo(imageV).offset(-2);
                make.size.mas_equalTo(CGSizeMake(55, 17));
            }];
            timeBtn.userInteractionEnabled = NO;
            timeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
            if (IsBoldSize()) {
                timeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 7);
            }
        }
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookScript:)];
        [imageV addGestureRecognizer:tap];
    }
    
    NSString *str3=[NSString stringWithFormat:@"拍摄城市：%@",projectCity];
    NSMutableAttributedString * attStr3 = [[NSMutableAttributedString alloc] initWithString:str3];
    [attStr3 addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
    self.cityLabel.attributedText=attStr3;
    
    NSString *str4=[NSString stringWithFormat:@"拍摄天数：%ld天",shotDays];
    NSMutableAttributedString * attStr4 = [[NSMutableAttributedString alloc] initWithString:str4];
    [attStr4 addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
    self.dayLabel.attributedText=attStr4;
    
    
    NSString *str5=[NSString stringWithFormat:@"预拍周期：%@至%@",projectStart,projectEnd];
    NSMutableAttributedString * attStr5 = [[NSMutableAttributedString alloc] initWithString:str5];
    [attStr5 addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
    self.shotTimeLabel.attributedText=attStr5;
    
    NSString *str6=[NSString stringWithFormat:@"肖像周期：%@",shotCycle];
    NSMutableAttributedString * attStr6 = [[NSMutableAttributedString alloc] initWithString:str6];
    [attStr6 addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
    self.cycleLabel.attributedText=attStr6;
    
    NSString *str7=[NSString stringWithFormat:@"肖像范围：%@",shotRegion];
    NSMutableAttributedString * attStr7 = [[NSMutableAttributedString alloc] initWithString:str7];
    [attStr7 addAttributes:@{NSForegroundColorAttributeName:Public_DetailTextLabelColor} range:NSMakeRange(0,5)];
    self.regionLabel.attributedText=attStr7;
}

-(void)lookScript:(UITapGestureRecognizer*)tap
{
    if (self.lookScriptBlock) {
        self.lookScriptBlock(tap.view.tag-10000);
    }
}

@end
