//
//  MyOrderHeadView.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderHeadView.h"
#import "OrderModel.h"

@interface MyOrderHeadView ()
@property(nonatomic,strong)UILabel *titleLab;   //标题
@property(nonatomic,strong)UIImageView *icon;    //
@property(nonatomic,strong)UIImageView *arrow;    //
@property(nonatomic,strong)UIButton *selectBtn;  //选择按钮
@end

@implementation MyOrderHeadView

-(id)init
{
    if (self=[super init]) {
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
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
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _icon;
}


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).offset(0);
            make.left.mas_equalTo(self.icon.mas_right).offset(3);
        }];
    }
    return _titleLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-15);
        }];
    }
    return _arrow;
}


-(void)reloadUIWithModel:(OrderProjectModel *)model
{
    self.icon.image=[UIImage imageNamed:model.type==1?@"order_audition":@"order_shot"];
    self.titleLab.text=model.name;
    [self arrow];
    
    BOOL isShowSelect=NO;  //是否显示选择按钮
    if (model.ordeState!=OrderStateTypeAll) {
        for (int i=0; i<model.orderlist.count; i++) {
            OrderModel *orderModel = model.orderlist[i];
            if (model.type==1&&[orderModel.orderstate isEqualToString:@"new"]) {  //试镜订单，未付款
                isShowSelect=YES;
            }
            else if (model.type==2&&([orderModel.orderstate isEqualToString:@"acceptted"]||[orderModel.orderstate isEqualToString:@"paiedone"]))  //拍摄，未付首款和尾款
            {
                isShowSelect=YES;
            }
        }
    }

    self.selectBtn.selected=model.isChoose;
    if (isShowSelect==YES) { //进行中，可以选择
        self.selectBtn.hidden=NO;
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(46);
        }];
    }
    else
    {
        self.selectBtn.hidden=YES;
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
        }];
    }
}

-(void)selectAction:(UIButton*)sender
{
    if (self.HeadclickOrderBlock) {
        self.HeadclickOrderBlock(!sender.selected);
    }
}

@end
