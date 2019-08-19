//
//  MyOrderActorInfoViewB.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/5.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "MyOrderActorInfoViewB.h"

@interface MyOrderActorInfoViewB ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLabel;   //名字
@property(nonatomic,strong)UILabel *stateLab;   //状态lab
@property(nonatomic,strong)UILabel *desc1;      //
@property(nonatomic,strong)UILabel *desc2;      //
@property(nonatomic,strong)UIImageView *icon;    //头像
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UIView *lineV1;    //
@property(nonatomic,strong)UIView *processView;   //底部操作view

@end

@implementation MyOrderActorInfoViewB

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [self addSubview:_bgV];
        //        _bgV.backgroundColor=[UIColor redColor];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(112);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookOrderDetial)];
        [_bgV addGestureRecognizer:tap];
    }
    return _bgV;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.bgV addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.centerY.mas_equalTo(self.titleLabel);
        }];
    }
    return _icon;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.textColor=Public_Text_Color;
        [self.bgV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgV).offset(17);
            make.left.mas_equalTo(self.icon.mas_right).offset(3);
        }];
    }
    return _titleLabel;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc]init];
        _stateLab.font=[UIFont systemFontOfSize:12];
        _stateLab.textColor=Public_Red_Color;
        [self.bgV addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self).offset(-11);
        }];
    }
    return _stateLab;
}

-(UILabel*)desc1
{
    if (!_desc1) {
        _desc1=[[UILabel alloc]init];
        _desc1.font=[UIFont systemFontOfSize:12];
        _desc1.textColor=Public_DetailTextLabelColor;
        [self.bgV addSubview:_desc1];
        [_desc1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
        }];
    }
    return _desc1;
}

-(UILabel*)desc2
{
    if (!_desc2) {
        _desc2=[[UILabel alloc]init];
        _desc2.font=[UIFont systemFontOfSize:12];
        _desc2.textColor=Public_DetailTextLabelColor;
        [self.bgV addSubview:_desc2];
        [_desc2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.top.mas_equalTo(self.desc1.mas_bottom).offset(3);
        }];
    }
    return _desc2;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:13];
        _priceLab.textColor=Public_Red_Color;
        [self.bgV addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.top.mas_equalTo(self.desc2.mas_bottom).offset(3);
        }];
    }
    return _priceLab;
}

-(UIView*)lineV1
{
    if (!_lineV1) {
        _lineV1 = [[UIView alloc]init];
        _lineV1.backgroundColor=Public_LineGray_Color;
        [self.bgV addSubview:_lineV1];
        [_lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.right.mas_equalTo(self).offset(-12);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV1;
}

-(UIView*)processView
{
    if (!_processView) {
        _processView=[[UIView alloc]init];
        [self addSubview:_processView];
//        _processView.backgroundColor=[UIColor redColor];
        [_processView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(43);
        }];
    }
    return _processView;
}

-(void)reloadUIWithInfo:(ProjectOrderInfoM*)info
{
    self.titleLabel.text=info.orderTypeName;
    self.stateLab.text=info.subStateName;
    
    [self lineV1];
    [self processView];
    
    if (info.orderType==0 || info.orderType==7 || info.orderType==4) {  //询档,锁档，拍摄
        self.desc1.text=[NSString stringWithFormat:@"饰演角色：%@",info.roleInfo[@"roleName"]];
        self.desc2.text=[NSString stringWithFormat:@"拍摄日期：%@至%@",info.shotStart,info.shotEnd];
        if (info.orderType==0) {
            self.icon.image = [UIImage imageNamed:@"order_askSchedule"];
        }
        else
        {
            self.icon.image = [UIImage imageNamed:@"order_shot"];
        }
    }
    else if (info.orderType==3)  //试镜
    {
        self.icon.image = [UIImage imageNamed:@"order_tryVideo"];
        NSInteger auditionMode =  [info.tryVideoInfo[@"auditionMode"] integerValue];
        
        self.desc1.text=[NSString stringWithFormat:@"试镜方式：%@",[info getAuditionWayWithType:auditionMode]];
        
        if (auditionMode==1 || auditionMode==4) {  //自备场地 在线试镜
            self.desc2.text=[NSString stringWithFormat:@"试镜时间：%@",info.tryVideoInfo[@"auditionDate"]];
        }
        else if (auditionMode==2 || auditionMode==3) //影棚试镜，手机快速
        {
            self.desc2.text=[NSString stringWithFormat:@"最晚上传作品日期：%@",info.tryVideoInfo[@"auditionLatestworkTime"]];
        }
    }
    else if (info.orderType==5)  //定妆
    {
        self.icon.image = [UIImage imageNamed:@"order_makeup"];
        NSInteger makeupType =  [info.makeupInfo[@"makeupType"] integerValue];
        self.desc1.text=[NSString stringWithFormat:@"定妆方式：%@",[info getMakeupTypeWithType:makeupType]];
        self.desc2.text=[NSString stringWithFormat:@"定妆时间：%@",info.makeupInfo[@"makeupDate"]];
    }
    else if (info.orderType==6)  //授权书
    {
        self.desc1.text=[NSString stringWithFormat:@"授权书有效期：%@",@""];
        self.desc2.text=@"";
    }
    NSString *str=[NSString stringWithFormat:@"总价：￥%ld",info.totalPrice];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(3,str.length-3)];
    self.priceLab.attributedText=attStr;
    
    for (UIView *view in self.processView.subviews) {
        [view removeFromSuperview];
    }
    
    //已失效
    if ([info.subStateName isEqualToString:@"已失效"]) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image =[UIImage imageNamed:@"LR_promt"];
        [self.processView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.processView).offset(-18);
            make.left.mas_equalTo(self.processView).offset(12);
        }];
        
        UILabel *failureResonLab=[[UILabel alloc]init];
        failureResonLab.font=[UIFont systemFontOfSize:13];
        failureResonLab.textColor=[UIColor colorWithHexString:@"#FF6600"];
        [self addSubview:failureResonLab];
        [failureResonLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageV);
            make.left.mas_equalTo(imageV.mas_right).offset(3);
        }];
        failureResonLab.text=[NSString stringWithFormat:@"失效原因：%@",[info getFailureResonWithStatue:info.subState]];
    }
    
    NSArray *array = [info OrderGetActorBottomButtonWithOrderInfo:info];
    CGFloat offY = 12;
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        CGFloat buttonWidth = [dic[@"width"]floatValue];
        NSInteger type = [dic[@"type"]integerValue];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.processView addSubview:button];
        button.tag=type;
        button.layer.cornerRadius=3;
        button.layer.masksToBounds=YES;
        button.layer.borderWidth=1.0;
        button.layer.borderColor=[UIColor colorWithHexString:@"#BCBCBC"].CGColor;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.processView).offset(-offY);
            make.bottom.mas_equalTo(self.bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(buttonWidth, 28));
        }];
        
        offY = offY+buttonWidth+10;
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)btnClicked:(UIButton*)sender
{
    if (self.btnActionBlock) {
        self.btnActionBlock(sender.tag);
    }
}

-(void)lookOrderDetial
{
    if (self.lookOrderDetialBlock) {
        self.lookOrderDetialBlock();
    }
}

@end
