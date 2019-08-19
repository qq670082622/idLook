//
//  MyOrderListCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/5.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "MyOrderListCellA.h"
#import "ProjectOrderInfoM.h"
#import "MyOrderActorInfoViewA.h"

@interface MyOrderListCellA ()

@property(nonatomic,strong)UIView *bgV;   //背景view
@property(nonatomic,strong)UILabel *titleLab;   //标题
@property(nonatomic,strong)UIImageView *icon;    //
@property(nonatomic,strong)UIImageView *arrow;    //
@property(nonatomic,strong)UIButton *selectBtn;  //选择按钮
@property(nonatomic,strong)UIView *orderView;   //订单view

@end

@implementation MyOrderListCellA

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

-(UIView*)orderView
{
    if (!_orderView) {
        _orderView=[[UIView alloc]init];
        [self.bgV addSubview:_orderView];
        [_orderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV);
            make.centerX.mas_equalTo(self.bgV);
            make.bottom.mas_equalTo(self.bgV);
            make.top.mas_equalTo(self.bgV).offset(30);
        }];
    }
    return _orderView;
}

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_selectBtn];
        [_selectBtn setImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(0);
            make.size.mas_equalTo(CGSizeMake(46, 45));
        }];
//        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.bgV addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(15);
            make.top.mas_equalTo(self.bgV).offset(15);
        }];
    }
    return _icon;
}


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.userInteractionEnabled=YES;
        _titleLab.font=[UIFont boldSystemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        [self.bgV addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon).offset(0);
            make.left.mas_equalTo(self.icon.mas_right).offset(3);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookProjectDetial)];
        [_titleLab addGestureRecognizer:tap];
    }
    return _titleLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.bgV addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
        }];
    }
    return _arrow;
}


-(void)reloadUIWithDic:(NSDictionary*)dic
{
    if (dic==nil) return;
    NSDictionary *projectInfo = dic[@"projectInfo"];
    NSDictionary *orderInfo = dic[@"orderInfo"];
    NSArray *orders = orderInfo[@"orders"];
    NSInteger orderType = [orderInfo[@"orderType"]integerValue];

    self.icon.image=[UIImage imageNamed:orderType==3?@"order_audition":@"order_shot"];
    self.titleLab.text=projectInfo[@"projectName"];
    [self arrow];
    
    for (UIView *view in self.orderView.subviews) {
        [view removeFromSuperview];
    }
    
    WeakSelf(self);
    for (int i=0; i<orders.count; i++) {
        ProjectOrderInfoM *info = orders[i];
        
        MyOrderActorInfoViewA *orderV = [[ MyOrderActorInfoViewA alloc]init];
        [self.orderView addSubview:orderV];
        [orderV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.orderView);
            make.right.mas_equalTo(self.orderView);
            make.top.mas_equalTo(self.orderView).offset(112*i);
            make.height.mas_equalTo(112);
        }];
        [orderV reloadUIWithInfo:info];
        orderV.btnActionBlock = ^(NSInteger type) {
            if (weakself.buttonClickBlock) {
                weakself.buttonClickBlock(type, info);
            }
        };
        orderV.lookOrderDetialBlock = ^{
            if (weakself.MyOrderlookOrderDetialBlock) {
                weakself.MyOrderlookOrderDetialBlock(info);
            }
        };
    }
    
}

//查看项目详情
-(void)lookProjectDetial
{
    if (self.lookProjectdetialBlock) {
        self.lookProjectdetialBlock();
    }
}

@end
