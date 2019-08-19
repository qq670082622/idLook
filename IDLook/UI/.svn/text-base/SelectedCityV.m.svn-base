//
//  SelectedCityV.m
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SelectedCityV.h"
#import "CityModel.h"

@interface SelectedCityV()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UIView *bg;
@end

@implementation SelectedCityV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self).offset(15);
    }];
    title.text = @"已选地点";
    
    
    UIView *view = [[UIView alloc]init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(45);
    }];
    self.bg=view;
}

-(void)reloadUIWithArray:(NSArray *)array
{
    for (UIView *view in self.bg.subviews) {
        [view removeFromSuperview];
    }
    
    if (array.count==0) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont boldSystemFontOfSize:14.0];
        lab.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        [self.bg addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bg).offset(-10);
            make.centerY.mas_equalTo(self.bg);
        }];
        lab.text = @"暂无已选城市～";
    }
    
    CGFloat width = (UI_SCREEN_WIDTH-50)/4;
    for (int i =0; i<array.count; i++) {
        CityModel *model=array[i];
        UIButton *btn=[[UIButton alloc] init];
        btn.tag=100+i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"model_type_normal"] forState:UIControlStateNormal];
        [btn setTitle:model.city forState:UIControlStateNormal];
        [self.bg addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10+(i%4)*(width+10));
            make.top.mas_equalTo(self).offset(45+(i/4)*40);
            make.size.mas_equalTo(CGSizeMake(width, 30));
        }];
        
        
        //删除按钮
        UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delectBtn setTag:1000+i];
        [self.bg addSubview:delectBtn];
        [delectBtn setBackgroundImage:[UIImage imageNamed:@"modelcard_dele"] forState:UIControlStateNormal];
        [delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(btn.mas_top);
            make.right.mas_equalTo(btn.mas_right);
            CGSizeMake(20, 20);
        }];
        [delectBtn addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)delectAction:(UIButton*)sender
{
    self.delectCity(sender.tag-1000);
}

@end
