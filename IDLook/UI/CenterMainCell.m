//
//  CenterMainCell.m
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CenterMainCell.h"

@interface CenterMainCell ()

@end

@implementation CenterMainCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *bg = [[UIView alloc]init];
    [self.contentView addSubview:bg];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=4;
    bg.backgroundColor=[UIColor whiteColor];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    NSArray *array;
    if ([UserInfoManager getUserType]==UserTypePurchaser) {
        array = @[@{@"title":@"我的项目",@"image":@"center_project",@"prompt":@"",@"type":@(CenterMainTypeMyProject)},
                  @{@"title":@"实名认证",@"image":@"center_auth",@"prompt":@"去认证",@"type":@(CenterMainTypeAuth)},
                  @{@"title":@"资产管理",@"image":@"center_assets",@"prompt":@"",@"type":@(CenterMainTypeAssets)},
                 //  @{@"title":@"我的保险",@"image":@"me_insurance_icon",@"prompt":@"",@"type":@(CenterMainTypeInsurance)},
                 @{@"title":@"选角服务",@"image":@"center_role",@"prompt":@"",@"type":@(CenterMainTypeRole)},
                   @{@"title":@"我的VIP",@"image":@"icon_07vip",@"prompt":@"未开通",@"type":@(CenterMainTypeVIP)},
                  @{@"title":@"积分商城",@"image":@"icon_store",@"prompt":@"",@"type":@(CenterMainTypeStore)},
                 // @{@"title":@"返现码兑换",@"image":@"center_coupon",@"prompt":@"",@"type":@(CenterMainTypeCoupon)},
                   @{@"title":@"我的评价",@"image":@"me_evaluate_icon",@"prompt":@"",@"type":@(CenterMainTypeGrade)},
                  @{@"title":@"联系脸探肖像",@"image":@"center_contact",@"prompt":@"",@"type":@(CenterMainTypeContact)},
                  @{@"title":@"分享脸探",@"image":@"center_share",@"prompt":@"",@"type":@(CenterMainTypeShare)},
                   @{@"title":@"项目管理",@"image":@"common_me_pm_icon",@"prompt":@"",@"type":@(CenterMainTypeProjectManage)},
                   @{@"title":@"带货达人订单",@"image":@"common_me_daren_icon",@"prompt":@"",@"type":@(CenterMainTypeCustomizedOrders)},
                  //@{@"title":@"子账号管理",@"image":@"center_subAcoount",@"prompt":@"",@"type":@(CenterMainTypeSubAccounts)},
//                  @{@"title":@"脸探攻略",@"image":@"center_Strategy",@"prompt":@"",@"type":@(CenterMainTypeStrategy)}
                  ];
    }
    else if ([UserInfoManager getUserType]==UserTypeResourcer)
    {
        array = @[@{@"title":@"个人中心",@"image":@"center_user",@"prompt":@"去完善",@"type":@(CenterMainTypePersonal)},
                  @{@"title":@"作品上传",@"image":@"center_workUpload",@"prompt":@"去上传",@"type":@(CenterMainTypeWorksUpload)},
                  @{@"title":@"实名认证",@"image":@"center_auth",@"prompt":@"去认证",@"type":@(CenterMainTypeAuth)},
                  @{@"title":@"资产管理",@"image":@"center_assets",@"prompt":@"",@"type":@(CenterMainTypeAssets)},
                  @{@"title":@"报价管理",@"image":@"center_price",@"prompt":@"填报价",@"type":@(CenterMainTypePrice)},
                  @{@"title":@"个人工作室",@"image":@"center_studio",@"prompt":@"去申请",@"type":@(CenterMainTypeStudio)},
                  @{@"title":@"通告报名",@"image":@"me_icon_notice",@"prompt":@"",@"type":@(CenterMainTypeAnnunciate)},
                  @{@"title":@"我的评价",@"image":@"me_evaluate_icon",@"prompt":@"",@"type":@(CenterMainTypeGrade)},
                  @{@"title":@"分享脸探",@"image":@"center_share",@"prompt":@"",@"type":@(CenterMainTypeShare)},
                  @{@"title":@"返现码分享",@"image":@"center_coupon",@"prompt":@"",@"type":@(CenterMainTypeReturnShare)}, // [返现码分享]
//                  @{@"title":@"我的授权书",@"image":@"center_certificate",@"type":@(CenterMainTypeCertificate)}
//                  @{@"title":@"脸探攻略",@"image":@"center_Strategy",@"prompt":@"",@"type":@(CenterMainTypeStrategy)}
                  ];
    }
    

    CGFloat width = (UI_SCREEN_WIDTH-20)/4;
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        NSInteger type = [dic[@"type"]integerValue];
        CenterSubCell *cell = [[CenterSubCell alloc]init];
        cell.userInteractionEnabled=YES;
        [bg addSubview:cell];
        cell.tag=100+type;
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bg).offset(i%4*width);
            make.top.mas_equalTo(bg).offset(i/4*85);
            make.size.mas_equalTo(CGSizeMake(width, 85));
        }];
        [cell reloadUIWithDic:dic];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttionClick:)];
        [cell addGestureRecognizer:tap];
    }
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
    [self.contentView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(85);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *lineV1=[[UIView alloc]init];
    lineV1.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
    [self.contentView addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(170);
        make.height.mas_equalTo(0.5);
    }];

//    CGFloat wid = UI_SCREEN_WIDTH/4;
//    UIView *horzLine=[[UIView alloc]init];
//    horzLine.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
//    [self.contentView addSubview:horzLine];
//    [horzLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(bg).offset(wid);
//        make.width.mas_equalTo(0.5);
//        make.top.mas_equalTo(bg);
//        make.bottom.mas_equalTo(bg);
//    }];
//
//    UIView *horzLine1=[[UIView alloc]init];
//    horzLine1.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
//    [self.contentView addSubview:horzLine1];
//    [horzLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(bg).offset(wid*2);
//        make.width.mas_equalTo(0.5);
//        make.top.mas_equalTo(bg);
//        make.bottom.mas_equalTo(bg);
//    }];
//
//    UIView *horzLine2=[[UIView alloc]init];
//    horzLine2.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
//    [self.contentView addSubview:horzLine2];
//    [horzLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(bg).offset(wid*3);
//        make.width.mas_equalTo(0.5);
//        make.top.mas_equalTo(bg);
//        make.bottom.mas_equalTo(bg);
//    }];
}

-(void)buttionClick:(UITapGestureRecognizer*)tap
{
    self.CenterMainCellBlock(tap.view.tag-100);
}

@end

@interface CenterSubCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIButton *promtBtn;
@end

@implementation CenterSubCell
-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self addSubview:_icon];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(-8);
        }];
        
    }
    return _icon;
}

-(UILabel*)name
{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont systemFontOfSize:12];
        _name.textColor=Public_Text_Color;
        [self addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.icon.mas_bottom).offset(10);
        }];
    }
    return _name;
}

-(UIButton*)promtBtn
{
    if (!_promtBtn) {
        _promtBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_promtBtn];
        [_promtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _promtBtn.titleLabel.font=[UIFont systemFontOfSize:9.0];
        [_promtBtn setBackgroundImage:[UIImage imageNamed:@"center_prompt"] forState:UIControlStateNormal];
        [_promtBtn setBackgroundImage:[UIImage imageNamed:@"center_prompt"] forState:UIControlStateHighlighted];
        [_promtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self).offset(8);
        }];
        _promtBtn.titleEdgeInsets=UIEdgeInsetsMake(-1.5,0,1.5, 0);
    }
    return _promtBtn;
}

-(void)reloadUIWithDic:(NSDictionary*)dic
{
    self.icon.image=[UIImage imageNamed:dic[@"image"]];
    self.name.text=dic[@"title"];
    
    
    CenterMainType type = [dic[@"type"] integerValue];

    if (type==CenterMainTypeAuth) {
        if ([UserInfoManager getUserAuthState]==0 || [UserInfoManager getUserAuthState]==2) { //未审核，审核不通过
            [self.promtBtn setTitle:dic[@"prompt"] forState:UIControlStateNormal];
            self.promtBtn.hidden=NO;
        }
        else if ([UserInfoManager getUserAuthState]==3) //审核中
        {
            [self.promtBtn setTitle:@"审核中" forState:UIControlStateNormal];
            self.promtBtn.hidden=NO;
        }
        else
        {
            self.promtBtn.hidden=YES;
        }
    }
    else
    {
        if (type==CenterMainTypePersonal) {
            if ([UserInfoManager getUserCompletInfoWithType:0]==0) {
                [self.promtBtn setTitle:dic[@"prompt"] forState:UIControlStateNormal];
                self.promtBtn.hidden=NO;
            }
            else
            {
                self.promtBtn.hidden=YES;
            }
        }
        else if (type==CenterMainTypeWorksUpload)
        {
            if ([UserInfoManager getUserCompletInfoWithType:1]==0&&[UserInfoManager getUserCompletInfoWithType:2]==0) {
                [self.promtBtn setTitle:dic[@"prompt"] forState:UIControlStateNormal];
                self.promtBtn.hidden=NO;
            }
            else
            {
                self.promtBtn.hidden=YES;
            }
        }
        else if (type==CenterMainTypePrice)
        {
            if ([UserInfoManager getUserCompletInfoWithType:8]==0) {
                [self.promtBtn setTitle:dic[@"prompt"] forState:UIControlStateNormal];
                self.promtBtn.hidden=NO;
            }
            else
            {
                self.promtBtn.hidden=YES;
            }
        }
        else if (type==CenterMainTypeStudio)
        {
            if ([UserInfoManager getUserStudio]==1) {
                self.promtBtn.hidden=YES;
            }
            else
            {
                [self.promtBtn setTitle:dic[@"prompt"] forState:UIControlStateNormal];
                self.promtBtn.hidden=NO;
            }
        }
        else if (type==CenterMainTypeVIP)
        {
              NSInteger status = [UserInfoManager getUserStatus];
            if (status>200) {//是vip
                self.promtBtn.hidden=YES;
            }
            else if(status==100)
            {
                [self.promtBtn setTitle:@"未开通" forState:UIControlStateNormal];//不是vip
                self.promtBtn.hidden=NO;
            }else if (status==105){
                [self.promtBtn setTitle:@"申请中" forState:UIControlStateNormal];//不是vip
                self.promtBtn.hidden=NO;
            }
        }
        else
        {
            self.promtBtn.hidden=YES;
        }
    }

}

@end
