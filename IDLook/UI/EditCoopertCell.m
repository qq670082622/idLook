//
//  EditCoopertCell.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditCoopertCell.h"

@interface EditCoopertCell ()
@property(nonatomic,strong)UIView *topV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)NSArray *dataS;
@end

@implementation EditCoopertCell

-(NSMutableArray*)selectArray
{
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _selectArray;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataS:(NSArray*)dataS
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
        
        [self selectArray];
        
        self.dataS=dataS;
        
        [self titleLab];
        [self initUI];
    }
    return self;
}

-(UIView*)topV
{
    if (!_topV) {
        _topV=[[UIView alloc]init];
        _topV.layer.borderColor=Public_LineGray_Color.CGColor;
        _topV.layer.borderWidth=0.5;
        [self.contentView addSubview:_topV];
        [_topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH, 48));
        }];
        
        UILabel *title=[[UILabel alloc]init];
        title.font=[UIFont systemFontOfSize:15.0];
        title.textColor=[UIColor colorWithHexString:@"#666666"];
        title.text=@"身份/年龄段";
        [_topV addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_topV);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        
        UILabel *desc=[[UILabel alloc]init];
        desc.font=[UIFont systemFontOfSize:15.0];
        desc.textColor=Public_Text_Color;
        [_topV addSubview:desc];
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_topV);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
        
        NSDictionary *dic =[UserInfoManager getPublicConfig];
        NSArray *array1 = dic[@"categoryType"];
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dicA = array1[i];
            NSInteger cateid =[[dicA objectForKey:@"cateid"] integerValue];
            if (cateid==[UserInfoManager getUserAgeType]) {
                NSString *age= dicA[@"attribute"][@"ageGroupType"][@"attrname"];
                 desc.text=[NSString stringWithFormat:@"%@（%@岁）",dicA[@"catename"],age];
            }
        }
    }
    return _topV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        _titleLab.text=@"擅长表演类型";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.topV.mas_bottom).offset(30);
        }];
    }
    return _titleLab;
}

-(void)initUI
{
    CGFloat width = (UI_SCREEN_WIDTH-30-12*3)/4;
    
    for (int i =0; i<self.dataS.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=3.0;
        button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:self.dataS[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15+(width+12)*(i%4));
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(20+i/4*44);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        
        NSArray* array = [[UserInfoManager getPerformingTypes] componentsSeparatedByString:@"|"];
        if ([array containsObject:self.dataS[i]]) {
            button.selected=YES;
            button.layer.borderColor=Public_Red_Color.CGColor;
            [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            [self.selectArray addObject:self.dataS[i]];
        }
    }
}

-(void)clickType:(UIButton*)sender
{
    
    if (self.selectArray.count>=3&&sender.selected==NO) {
        [SVProgressHUD showImage:nil status:@"最多只能选择三种表演类型!"];
        return;
    }
    
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        sender.layer.borderColor=Public_Red_Color.CGColor;
        [sender setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
        [self.selectArray addObject:self.dataS[sender.tag-100]];
    }
    else
    {
        sender.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
        [sender setBackgroundColor:[UIColor whiteColor]];
        
        if ([self.selectArray containsObject:self.dataS[sender.tag-100]]) {
            [self.selectArray removeObject:self.dataS[sender.tag-100]];
        }
    }
}


@end
