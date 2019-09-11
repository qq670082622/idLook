//
//  ProjectMainCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainCellA.h"
#import "ProjectOrderInfoM.h"

@interface ProjectMainCellA ()
@property(nonatomic,strong)UILabel *infoLab1;  //  拍摄类别,试镜方式，定妆类别，授权书有效期 其中一个
@property(nonatomic,strong)UILabel *infoLab2;  // 拍摄日期，最晚上传作品日期，定妆时间。其中一个
@property(nonatomic,strong)UILabel *infoLab3;  // 定妆地址

@property(nonatomic,strong)UILabel *priceLabel;  //价格

@property(nonatomic,strong)UIView *bottomV;  //底部按钮view

@end

@implementation ProjectMainCellA

-(UILabel*)infoLab1
{
    if (!_infoLab1) {
        _infoLab1=[[UILabel alloc]init];
        _infoLab1.font=[UIFont systemFontOfSize:12];
        _infoLab1.textColor=Public_Text_Color;
        [self.contentView addSubview:_infoLab1];
        [_infoLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.roleLabel.mas_bottom).offset(3);
        }];
    }
    return _infoLab1;
}

-(UILabel*)infoLab2
{
    if (!_infoLab2) {
        _infoLab2=[[UILabel alloc]init];
        _infoLab2.font=[UIFont systemFontOfSize:12];
        _infoLab2.textColor=Public_Text_Color;
        [self.contentView addSubview:_infoLab2];
        [_infoLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.infoLab1.mas_bottom).offset(1);
        }];
    }
    return _infoLab2;
}

-(UILabel*)infoLab3
{
    if (!_infoLab3) {
        _infoLab3=[[UILabel alloc]init];
        _infoLab3.font=[UIFont systemFontOfSize:12];
        _infoLab3.textColor=Public_Text_Color;
        [self.contentView addSubview:_infoLab3];
        [_infoLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
             make.right.mas_equalTo(self.bgV).offset(-10);
            make.top.mas_equalTo(self.infoLab2.mas_bottom).offset(1);
        }];
    }
    return _infoLab3;
}

-(UILabel*)priceLabel
{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.font=[UIFont boldSystemFontOfSize:14];
        _priceLabel.textColor=Public_Red_Color;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.infoLab3.mas_bottom).offset(1);
        }];
    }
    return _priceLabel;
}

-(UIView*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[UIView alloc]init];
        [self.contentView addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV);
            make.centerX.mas_equalTo(self.bgV);
            make.bottom.mas_equalTo(self.bgV);
            make.height.mas_equalTo(55);
        }];
    }
    return _bottomV;
}


-(void)reloadUIWithProjectOrderInfo:(ProjectOrderInfoM *)info
{
    if (info==nil) return;
    self.nameLabel.text=info.actorInfo[@"actorName"];
    NSInteger sex = [info.actorInfo[@"sex"]integerValue];
    self.sexIcon.image = [UIImage imageNamed:sex==1?@"icon_male":@"icon_female"];
    self.regionLabel.text = [NSString stringWithFormat:@"• %@",info.actorInfo[@"region"]];
    self.stateLabel.text=info.subStateName;
    [self.icon sd_setImageWithUrlStr:info.actorInfo[@"actorHead"] placeholderImage:[UIImage imageNamed:@"head_default"]];
    self.roleLabel.text=[NSString stringWithFormat:@"饰演角色：%@",info.roleInfo[@"roleName"]];
    self.priceLabel.text=[NSString stringWithFormat:@"￥%ld",info.totalPrice];
    if (info.orderType==0 || info.orderType==7 || info.orderType==4) {  //锁档，询档,拍摄
        self.infoLab1.text=[NSString stringWithFormat:@"拍摄类别：%@",info.shotType];
        self.infoLab2.text=[NSString stringWithFormat:@"拍摄日期：%@至%@",info.shotStart,info.shotEnd];
        self.infoLab3.text=@"";
    }
    else if (info.orderType==3)  //试镜
    {
        NSInteger auditionMode =  [info.tryVideoInfo[@"auditionMode"] integerValue];
        
        self.infoLab1.text=[NSString stringWithFormat:@"试镜方式：%@",[info getAuditionWayWithType:auditionMode]];
        if (auditionMode==1 || auditionMode==2 || auditionMode==4) {  //自备场地,影棚试镜
            self.infoLab2.text=[NSString stringWithFormat:@"试镜时间：%@",info.tryVideoInfo[@"auditionDate"]];
        }
        else if ( auditionMode==3) //手机快速
        {
            self.infoLab2.text=[NSString stringWithFormat:@"最晚上传作品日期：%@",info.tryVideoInfo[@"auditionLatestworkTime"]];
        }
//        else if(auditionMode==4)//在线试镜
//        {
//            self.infoLab2.text=[NSString stringWithFormat:@"试镜时间：%@",info.tryVideoInfo[@"auditionDate"]];
//        }
        self.infoLab3.text=@"";
    }
    else if (info.orderType==5)  //定妆
    {
        NSInteger makeupType =  [info.makeupInfo[@"makeupType"] integerValue];
        self.infoLab1.text=[NSString stringWithFormat:@"定妆类别：%@",[info getMakeupTypeWithType:makeupType]];
        self.infoLab2.text=[NSString stringWithFormat:@"定妆时间：%@",info.makeupInfo[@"makeupDate"]];
        self.infoLab3.text=[NSString stringWithFormat:@"定妆地址：%@",info.makeupInfo[@"makeupAddress"]];
    }
    else if (info.orderType==6)  //授权书
    {
        self.infoLab1.text=[NSString stringWithFormat:@"授权书有效期：%@至%@",info.authStart,info.authEnd];
        self.infoLab2.text=@"";
        self.infoLab3.text=@"";
    }
    
    if (info.orderType==3 && [info.subState isEqualToString:@"finish"]) {  //试镜已完成
        self.bottomV.hidden=YES;
    }
    else
    {
        self.bottomV.hidden=NO;
    }
    
    for (UIView *view in self.bottomV.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *array = [info ProjectGetPurBottomButtonWithOrderInfo:info];
    CGFloat offY = 2;
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        CGFloat buttonWidth = [dic[@"width"]floatValue];
        NSInteger type = [dic[@"type"]integerValue];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.bottomV addSubview:button];
        button.tag=type;
        if (type!=ProjectBtnTypeMore) {  //除更多外的其他类型按钮
            offY = offY+10;
            button.layer.cornerRadius=3;
            button.layer.masksToBounds=YES;
            button.layer.borderWidth=1.0;
            button.layer.borderColor=[UIColor colorWithHexString:@"#BCBCBC"].CGColor;
        }
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bottomV).offset(-offY);
            make.bottom.mas_equalTo(self.bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(buttonWidth, 28));
        }];
        
        offY = offY+buttonWidth;
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)btnClicked:(UIButton*)sender
{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender.tag,sender);
    }
}


@end
