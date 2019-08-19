//
//  UinfoEvaluateView.m
//  IDLook
//
//  Created by Mr Hu on 2019/3/6.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "UinfoEvaluateView.h"

@interface UinfoEvaluateView ()
@property(nonatomic,strong)UILabel *titleLab;    //
@property(nonatomic,strong)UIImageView *icon;   //头像
@property(nonatomic,strong)UIImageView *vip;   //vip
@property(nonatomic,strong)UILabel *nameLab;   //名字
@property(nonatomic,strong)UILabel *dataLab;   //日期
@property(nonatomic,strong)UILabel *starLab;   //星级
@property(nonatomic,strong)UIImageView *tipIcon;   //
@property(nonatomic,strong)UILabel *tagLab;   //标签
@property(nonatomic,strong)UILabel *contentLab;   //评价内容

@end

@implementation UinfoEvaluateView

-(id)init
{
    if (self=[super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UILabel *titleLab=[[UILabel alloc]init];
    [self addSubview:titleLab];
    titleLab.text=@"评价";
    titleLab.textColor=Public_Text_Color;
    titleLab.font=[UIFont systemFontOfSize:15];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(15);
        make.left.mas_equalTo(self).offset(15);
    }];
    self.titleLab=titleLab;
    
    UIButton *allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:allBtn];
    [allBtn setImage:[UIImage imageNamed:@"center_arror_icon"] forState:UIControlStateNormal];
    [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorWithHexString:@"#BCBCBC"] forState:UIControlStateNormal];
    allBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.right.mas_equalTo(self).offset(-15);
    }];
    
    allBtn.titleLabel.backgroundColor = allBtn.backgroundColor;
    allBtn.imageView.backgroundColor = allBtn.backgroundColor;
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = allBtn.titleLabel.bounds.size;
    CGSize imageSize = allBtn.imageView.bounds.size;
    CGFloat interval = 1.0;
    allBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + 5), 0, imageSize.width + 5);
    
    [allBtn addTarget:self action:@selector(entryAllAction) forControlEvents:UIControlEventTouchUpInside];
    
    //头像
    UIImageView *icon = [[UIImageView alloc]init];
    [self addSubview:icon];
    icon.layer.cornerRadius=14;
    icon.layer.masksToBounds=YES;
    icon.contentMode=UIViewContentModeScaleAspectFill;
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(50);
        make.left.mas_equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    self.icon=icon;
    
    UILabel *nameLab=[[UILabel alloc]init];
    [self addSubview:nameLab];
    nameLab.textColor=Public_Text_Color;
    nameLab.font=[UIFont systemFontOfSize:15];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(icon);
        make.left.mas_equalTo(icon.mas_right).offset(10);
    }];
    self.nameLab=nameLab;
    
    //vip
    UIImageView *vip = [[UIImageView alloc]init];
    [self addSubview:vip];
    vip.image=[UIImage imageNamed:@"icon_vip"];
    vip.contentMode=UIViewContentModeScaleAspectFill;
    [vip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLab);
        make.left.mas_equalTo(nameLab.mas_right).offset(4);
//        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    self.vip=vip;
    
    UILabel *dataLab=[[UILabel alloc]init];
    [self addSubview:dataLab];
    dataLab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
    dataLab.font=[UIFont systemFontOfSize:12];
    [dataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLab);
        make.right.mas_equalTo(self).offset(-15);
    }];
    self.dataLab=dataLab;
    
    UILabel *starLab=[[UILabel alloc]init];
    [self addSubview:starLab];
    starLab.textColor=[UIColor colorWithHexString:@"#FFB200"];
    starLab.font=[UIFont systemFontOfSize:12];
    [starLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLab.mas_bottom).offset(5);
        make.left.mas_equalTo(self).offset(53);
    }];
    self.starLab=starLab;
    
    //
    UIImageView *tipIcon = [[UIImageView alloc]init];
    [self addSubview:tipIcon];
    tipIcon.image=[UIImage imageNamed:@"icon_tip"];
    tipIcon.contentMode=UIViewContentModeScaleAspectFill;
    [tipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(starLab.mas_bottom).offset(5);
        make.left.mas_equalTo(self).offset(53);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    self.tipIcon=tipIcon;
    
    UILabel *tagLab=[[UILabel alloc]init];
    [self addSubview:tagLab];
    tagLab.numberOfLines=0;
    tagLab.textColor=Public_DetailTextLabelColor;
    tagLab.font=[UIFont systemFontOfSize:12];
    [tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipIcon);
        make.left.mas_equalTo(self).offset(70);
        make.right.mas_equalTo(self).offset(-14);
    }];
    self.tagLab=tagLab;
    
    UILabel *contentLab=[[UILabel alloc]init];
    [self addSubview:contentLab];
    contentLab.numberOfLines=3;
    contentLab.textColor=[UIColor colorWithHexString:@"#333333"];
    contentLab.font=[UIFont systemFontOfSize:14];
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-15);
        make.left.mas_equalTo(self).offset(53);
        make.right.mas_equalTo(self).offset(-14);
    }];
    self.contentLab=contentLab;
    
}

-(void)reloadUIWithDic:(NSDictionary *)dic withCount:(NSInteger)count
{
    NSString *avatar =(NSString*)safeObjectForKey(dic, @"avatar");  //头像
    NSString *userName = (NSString*)safeObjectForKey(dic, @"userName");  //名称
    NSString *commentDate = (NSString*)safeObjectForKey(dic, @"commentDate");  //日期
    NSString *tags = (NSString*)safeObjectForKey(dic, @"tags");  //标签
    NSString *content = (NSString*)safeObjectForKey(dic, @"content");  //评价内容
    BOOL isVIP = [dic[@"isVIP"]boolValue];  //是否vip
    NSInteger performance = [dic[@"performance"]integerValue];  //性价比
    NSInteger actingPower = [dic[@"actingPower"]integerValue];  //表演力
    NSInteger coordination = [dic[@"coordination"]integerValue];  //配合度
    NSInteger favor = [dic[@"favor"]integerValue];     //好感度

    self.titleLab.text=[NSString stringWithFormat:@"评价(%ld)",count];

    [self.icon sd_setImageWithUrlStr:avatar placeholderImage:[UIImage imageNamed:@"icon_gradeHead"]];
    self.nameLab.text=userName;
    self.vip.hidden=!isVIP;
    self.dataLab.text=commentDate;
    
    self.starLab.text= [NSString stringWithFormat:@"性价比:%ld星    表演力:%ld星    配合度:%ld星    好感度:%ld星",performance,actingPower,coordination,favor];
    self.tagLab.text=[tags stringByReplacingOccurrencesOfString:@"|" withString:@","];
    
    self.contentLab.text=content;
    
    if (tags.length<=0) {
        self.tipIcon.hidden=YES;
        self.tagLab.hidden=YES;
    }
}

//查看全部
-(void)entryAllAction
{
    if (self.lookAllEvaluate) {
        self.lookAllEvaluate();
    }
}



@end
