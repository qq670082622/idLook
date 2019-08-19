//
//  MyOrderActorInfoViewA.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/5.
//  Copyright © 2019 HYH. All rights reserved.
//


#import "MyOrderActorInfoViewA.h"

@interface MyOrderActorInfoViewA ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *nameLab;   //名字
@property(nonatomic,strong)UILabel *stateLab;   //状态lab
@property(nonatomic,strong)UILabel *desc1;      //
@property(nonatomic,strong)UILabel *desc2;      //
@property(nonatomic,strong)UIImageView *icon;    //头像
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UIView *lineV1;    //

@end

@implementation MyOrderActorInfoViewA


-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [self addSubview:_bgV];
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
//        _icon.clipsToBounds=YES;
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=25;
        [self.bgV addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }
    return _icon;
}

-(UILabel*)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont boldSystemFontOfSize:15];
        _nameLab.textColor=Public_Text_Color;
        [self.bgV addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.icon);
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
        }];
    }
    return _nameLab;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc]init];
        _stateLab.font=[UIFont systemFontOfSize:12];
        _stateLab.textColor=Public_Red_Color;
        [self.bgV addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nameLab);
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
            make.left.mas_equalTo(self.nameLab);
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(3);
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
            make.left.mas_equalTo(self.nameLab);
            make.top.mas_equalTo(self.desc1.mas_bottom).offset(3);
        }];
    }
    return _desc2;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:15];
        _priceLab.textColor=Public_Text_Color;
        [self.bgV addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLab);
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

-(void)reloadUIWithInfo:(ProjectOrderInfoM*)info
{
    [self.icon sd_setImageWithUrlStr:info.actorInfo[@"actorHead"] placeholderImage:[UIImage imageNamed:@"head_default"]];
    self.nameLab.text=info.actorInfo[@"actorName"];
    self.stateLab.text=info.subStateName;

    [self lineV1];
    
    
    if (info.orderType==0 || info.orderType==7 || info.orderType==4) {  //锁档，询档,拍摄
        self.desc1.text=[NSString stringWithFormat:@"拍摄类别：%@",info.shotType];
        self.desc2.text=[NSString stringWithFormat:@"拍摄日期：%@至%@",info.shotStart,info.shotEnd];
    }
    else if (info.orderType==3)  //试镜
    {
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
        NSInteger makeupType =  [info.makeupInfo[@"makeupType"] integerValue];
        self.desc1.text=[NSString stringWithFormat:@"定妆类别：%@",[info getMakeupTypeWithType:makeupType]];
        self.desc2.text=[NSString stringWithFormat:@"定妆时间：%@",info.makeupInfo[@"makeupDate"]];
    }
    else if (info.orderType==6)  //授权书
    {
        self.desc1.text=[NSString stringWithFormat:@"授权书有效期：%@",@""];
        self.desc2.text=@"";
    }
    self.priceLab.text=[NSString stringWithFormat:@"￥%ld",info.totalPrice];

}

-(void)lookOrderDetial
{
    if (self.lookOrderDetialBlock) {
        self.lookOrderDetialBlock();
    }
}

@end
