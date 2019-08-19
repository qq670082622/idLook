//
//  SelectConditionV.m
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SelectConditionV.h"

@interface SelectConditionV ()
@property(nonatomic,strong)UIView *conditV;
@property(nonatomic,strong)NSString *selectStr;
@property(nonatomic,strong)NSArray *dataS;
@property(nonatomic,assign)SearchConditionType subType;
@end

@implementation SelectConditionV

-(void)layoutIfNeeded
{
    [super layoutIfNeeded];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0,0 ,UI_SCREEN_WIDTH,0.5)];
    [self addSubview:lineV];
    lineV.backgroundColor=Public_LineGray_Color;
    
    UIView *conditV = [[UIView alloc]init];
    [self addSubview:conditV];
    conditV.backgroundColor=[UIColor whiteColor];
    [conditV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(0.5);
        make.bottom.mas_equalTo(self).offset(-45.5);
    }];
    self.conditV=conditV;
    
    UIButton *resetBtn=[[UIButton alloc]init];
    [self addSubview:resetBtn];
    resetBtn.layer.borderColor=Public_LineGray_Color.CGColor;
    resetBtn.layer.borderWidth=0.5;
    resetBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 45));
    }];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn=[[UIButton alloc]init];
    [self addSubview:confirmBtn];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor=Public_Red_Color;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 45));
    }];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    

    
}

//重置
-(void)resetAction
{
    for (id obj in self.conditV.subviews) {
        if ([[obj class] isEqual:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            [button setBackgroundColor:[UIColor whiteColor]];
            button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
            button.selected=NO;
        }
    }
    self.selectStr=@"";
}

//确定
-(void)confirmAction
{
    self.hidden=YES;
    self.SelectConditionVBlock(self.selectStr,self.subType);
}

-(void)reloadUIWithArtistType:(ArtistType)type withSearchConditionType:(SearchConditionType)subType withSCM:(SearchStrucM*)scm
{
    self.dataS = [scm getConditionArrayWithType:type withSearchConditionType:subType];
    self.subType=subType;
    
    for (UIView *view in self.conditV.subviews) {
        [view removeFromSuperview];
    }
    
    if (subType == SearchConditionTypeType) {
        [self initUIPart2];
    }
    else
    {
        [self initUIPart1];
    }
}

-(void)initUIPart1
{
    CGFloat width = 0;
    NSInteger count=0;
    CGFloat spacX = 0;
    
    switch (self.subType) {
        case SearchConditionTypeAge:
            count = 3;
            spacX=15;
            width = (UI_SCREEN_WIDTH - 30 -12*2)/3;
            break;
        case SearchConditionTypePrice:
            count=2;
            spacX=40;
            width= (UI_SCREEN_WIDTH - 80 - 12)/2;
            break;
        case SearchConditionTypeCity:
            count=4;
            spacX=15;
            width = (UI_SCREEN_WIDTH -30 - 12*3)/4;
            break;
        case SearchConditionTypeType:
            break;
        default:
            break;
    }
    
    
    for (int i = 0; i<self.dataS.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self.conditV addSubview:button];
        button.layer.cornerRadius=3.0;
        button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:self.dataS[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(spacX+(width+12)*(i%count));
            make.top.mas_equalTo(self).offset(30+(i/count)*44);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickType:(UIButton*)sender
{
    
    for (int i = 0; i<self.dataS.count; i++) {
        UIButton * button = (UIButton*)[self viewWithTag:100+i];
        if (i==sender.tag-100) {
            [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            button.layer.borderColor=Public_Red_Color.CGColor;

            button.selected=YES;
        }
        else
        {
            [button setBackgroundColor:[UIColor whiteColor]];
            button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;

            button.selected=NO;
        }
    }
    
    self.selectStr=sender.titleLabel.text;
}

-(void)initUIPart2
{
    CGFloat width = (UI_SCREEN_WIDTH - 30 -12*2)/3;
    
    CGFloat Vheight = 0;
    
    for (int i =0; i<self.dataS.count; i++) {
        NSArray *array = self.dataS[i][@"type"];
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor=[UIColor redColor];
        [self.conditV addSubview:view];
        CGFloat height = ((array.count-1)/3+1)*44 + 50;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(Vheight);
            make.height.mas_equalTo(height);
        }];
        Vheight = Vheight + height;
        
        UILabel *title=[[UILabel alloc]init];
        [view addSubview:title];
        title.font=[UIFont systemFontOfSize:13.0];
        title.textColor=Public_Text_Color;
        title.text=self.dataS[i][@"title"];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.top.mas_equalTo(view).offset(30);
        }];
        
        for (int j =0; j<array.count; j++) {
            UIButton *button=[[UIButton alloc]init];
            [self.conditV addSubview:button];
            button.layer.cornerRadius=3.0;
            button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;
            button.layer.borderWidth=0.5;
            button.tag=1000+100*i+j;
            button.titleLabel.font=[UIFont systemFontOfSize:13.0];
            [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitle:array[j] forState:UIControlStateNormal];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(15+(width+12)*(j%3));
                make.top.mas_equalTo(title.mas_bottom).offset(12+(j/3)*44);
                make.size.mas_equalTo(CGSizeMake(width, 32));
            }];
            [button addTarget:self action:@selector(clickType3:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void)clickType3:(UIButton*)sender
{
    for (int i = 0; i<self.dataS.count; i++) {
         NSArray *array = self.dataS[i][@"type"];
        for (int j = 0 ; j<array.count; j++) {
            UIButton * button = (UIButton*)[self viewWithTag:1000+100*i+j];
            if (i==(sender.tag-1000)/100 && j == (sender.tag-100)%100) {
                [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
                button.layer.borderColor=Public_Red_Color.CGColor;
                button.selected=YES;
            }
            else
            {
                [button setBackgroundColor:[UIColor whiteColor]];
                button.layer.borderColor=[UIColor colorWithHexString:@"#E6E6E6"].CGColor;

                button.selected=NO;
            }
        }
    }
    
    self.selectStr=sender.titleLabel.text;
}

@end
