//
//  UinfoSubVA.m
//  IDLook
//
//  Created by Mr Hu on 2019/3/6.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "UinfoSubVA.h"

@interface UinfoSubVA ()
@property(nonatomic,strong)UIView *scroeView;  //评分view
@property(nonatomic,strong)UIView *priceView;  //价格一栏view
@property (nonatomic,strong)UILabel *weightLab;
@property (nonatomic,strong)UILabel *salePriceVipLab;  //vip价格
@property (nonatomic,strong)UILabel *salePriceLab;   //原价格
@property (nonatomic,strong)UIButton *priceBtn;
@property (nonatomic,strong)UILabel *priceDeacLab;
@property (nonatomic,strong)UIView *vipApplyView;  //vip申请一栏
@property (nonatomic,strong)UILabel *vipLab;

@end

@implementation UinfoSubVA

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIView *scroeView = [[UIView alloc]init];
    [self addSubview:scroeView];
    scroeView.layer.borderColor=Public_LineGray_Color.CGColor;
    scroeView.layer.borderWidth=0.5;
    scroeView.clipsToBounds=YES;
    [scroeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    self.scroeView=scroeView;
    
    CGFloat width = UI_SCREEN_WIDTH/5;
    NSArray *array = @[@"总分",@"性价比",@"表演力",@"配合度",@"好感度"];
    for (int i=0; i<array.count; i++) {
        UILabel *lab = [[UILabel alloc]init];
        [scroeView addSubview:lab];
        lab.tag=1000+i;
        lab.font=[UIFont systemFontOfSize:13];
        lab.textColor=Public_DetailTextLabelColor;
        lab.textAlignment=NSTextAlignmentCenter;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width*i);
            make.centerY.mas_equalTo(scroeView);
            make.size.mas_equalTo(CGSizeMake(width, 44));
        }];
        lab.text=array[i];
        if (i==0) {
            lab.textColor=[UIColor colorWithHexString:@"#FFB200"];
        }
    }

    //报价一栏
    UIView *view1 = [[UIView alloc]init];
    [self addSubview:view1];
    view1.clipsToBounds=YES;
    view1.userInteractionEnabled=YES;
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scroeView.mas_bottom);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(48);
    }];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOfferAction)];
    [view1 addGestureRecognizer:tap1];
    self.priceView=view1;
    
    //报价图标
    UIButton *offerIcon=[UIButton buttonWithType:UIButtonTypeCustom];
    [view1 addSubview:offerIcon];
    [offerIcon setImage:[UIImage imageNamed:@"u_info_offer"] forState:UIControlStateDisabled];
    [offerIcon setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    offerIcon.titleLabel.font=[UIFont systemFontOfSize:14];
    [offerIcon setTitle:@"报价" forState:UIControlStateNormal];
    //粗体
    if (IsBoldSize()) {
        offerIcon.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 13);
    }
    [offerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scroeView.mas_bottom).offset(15);
        make.left.mas_equalTo(self).offset(15);
    }];
    offerIcon.enabled=NO;
    offerIcon.titleEdgeInsets=UIEdgeInsetsMake(0,10, 0,-10);
    
    //价格
    UILabel *priceDescLab = [[UILabel alloc]init];
    [view1 addSubview:priceDescLab];
    priceDescLab.font=[UIFont systemFontOfSize:14];
    priceDescLab.textColor=Public_Text_Color;
    [priceDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(offerIcon.mas_right).offset(20);
        make.centerY.mas_equalTo(offerIcon);
    }];
    if ([UserInfoManager getUserLoginType]!=UserLoginTypeTourist) {
        priceDescLab.text=@"请选择";
    }
    self.priceDeacLab=priceDescLab;
    
    //箭头
    UIButton *arrow=[UIButton buttonWithType:UIButtonTypeCustom];
    [view1 addSubview:arrow];
    [arrow setImage:[UIImage imageNamed:@"center_arror_icon"] forState:UIControlStateNormal];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(offerIcon);
        make.right.mas_equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    [arrow addTarget:self action:@selector(chooseOfferAction) forControlEvents:UIControlEventTouchUpInside];
    
    //价格
    UILabel *salePriceLab = [[UILabel alloc]init];
    [view1 addSubview:salePriceLab];
    salePriceLab.font=[UIFont systemFontOfSize:11];
    salePriceLab.textColor=[UIColor colorWithHexString:@"#999999"];
    [salePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-33);
        make.centerY.mas_equalTo(offerIcon);
    }];
    self.salePriceLab=salePriceLab;
    
    //vip价格
    UILabel *salePriceVipLab = [[UILabel alloc]init];
    [view1 addSubview:salePriceVipLab];
    salePriceVipLab.font=[UIFont boldSystemFontOfSize:16];
    salePriceVipLab.textColor=Public_Red_Color;
    [salePriceVipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(salePriceLab.mas_left).offset(-5);
        make.centerY.mas_equalTo(offerIcon);
    }];
    salePriceVipLab.text=@"￥3000/天起";
  [salePriceVipLab addGestureRecognizer:tap1];
    salePriceVipLab.userInteractionEnabled = YES;
    self.salePriceVipLab=salePriceVipLab;
    
    //vipt标示
    UILabel *vipLab = [[UILabel alloc]init];
    [view1 addSubview:vipLab];
    vipLab.font=[UIFont systemFontOfSize:9];
    vipLab.textColor=[UIColor colorWithHexString:@"#E8D397"];
    vipLab.backgroundColor=Public_Text_Color;
    vipLab.layer.cornerRadius=1.0;
    vipLab.layer.masksToBounds=YES;
    vipLab.textAlignment=NSTextAlignmentCenter;
    vipLab.text=@"VIP价";
    [vipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(salePriceVipLab.mas_left).offset(-5);
        make.centerY.mas_equalTo(offerIcon);
        make.size.mas_equalTo(CGSizeMake(27, 12));
    }];
    self.vipLab=vipLab;
    
    //vip申请一栏
    UIView *vipApplyView = [[UIView alloc]init];
    [self addSubview:vipApplyView];
    vipApplyView.clipsToBounds=YES;
    vipApplyView.userInteractionEnabled=YES;
    vipApplyView.backgroundColor=[UIColor colorWithHexString:@"#FFF7DE"];
    [vipApplyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceView.mas_bottom);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(40);
    }];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vipAction)];
    [vipApplyView addGestureRecognizer:tap2];
    self.vipApplyView=vipApplyView;
    
    //钻石图标
    UIImageView *icon1=[[UIImageView alloc]init];
    [vipApplyView addSubview:icon1];
    icon1.image=[UIImage imageNamed:@"u_info_vip_02"];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(vipApplyView);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    //vip说明
    UILabel *vipDescLab = [[UILabel alloc]init];
    [vipApplyView addSubview:vipDescLab];
    vipDescLab.font=[UIFont systemFontOfSize:12];
    vipDescLab.textColor=Public_Text_Color;
    [vipDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(37);
        make.centerY.mas_equalTo(vipApplyView);
    }];
    vipDescLab.text=@"VIP尊享9折优惠";
    
    //vip申请
    UILabel *vipLab1 = [[UILabel alloc]init];
    [vipApplyView addSubview:vipLab1];
    vipLab1.font=[UIFont systemFontOfSize:12];
    vipLab1.textColor=[UIColor colorWithHexString:@"#AD903C"];
    [vipLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-17);
        make.centerY.mas_equalTo(vipApplyView);
    }];
    vipLab1.text=@"立即申请";
    
    
    //简介一栏
    UIView *view2 = [[UIView alloc]init];
    [self addSubview:view2];
    view2.userInteractionEnabled=YES;
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreInfoAction)];
    [view2 addGestureRecognizer:tap3];
    
    //简介图标
    UIButton *introIcon=[UIButton buttonWithType:UIButtonTypeCustom];
    [view2 addSubview:introIcon];
    [introIcon setImage:[UIImage imageNamed:@"u_info_intro"] forState:UIControlStateDisabled];
    [introIcon setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    introIcon.titleLabel.font=[UIFont systemFontOfSize:14];
    [introIcon setTitle:@"简介" forState:UIControlStateNormal];
    //粗体
    if (IsBoldSize()) {
        introIcon.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 13);
    }
    [introIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view2);
        make.left.mas_equalTo(self).offset(15);
    }];
    introIcon.enabled=NO;
    introIcon.titleEdgeInsets=UIEdgeInsetsMake(0,10, 0,-10);
    
    //身高，体重
    UILabel *weightLab = [[UILabel alloc]init];
    [view2 addSubview:weightLab];
    weightLab.font=[UIFont systemFontOfSize:14];
    weightLab.textColor=Public_Text_Color;
    [weightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(introIcon.mas_right).offset(20);
        make.centerY.mas_equalTo(introIcon);
    }];
    weightLab.text=@"身高：178cm    体重：65kg";
    self.weightLab=weightLab;
    
    //进入个人信息
    UIImageView *moreInfoV=[[UIImageView alloc]init];
    [view2 addSubview:moreInfoV];
    moreInfoV.image=[UIImage imageNamed:@"center_arror_icon"];
    [moreInfoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(introIcon);
        make.right.mas_equalTo(self).offset(-15);
    }];
}

-(void)reloadUIWithInfo:(UserDetialInfoM *)info
{
    self.weightLab.text=[NSString stringWithFormat:@"身高：%ldcm    体重：%ldkg",info.height,info.weight];
    
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {
        self.salePriceVipLab.text=@"登录后可查看报价";
        self.salePriceLab.text=@"";
    }
    else
    {
        //未认证成功，跳到认证界面
        if ([UserInfoManager getUserAuthState]!=1) {
            self.salePriceVipLab.text=@"查看报价";
            self.salePriceLab.text=@"";
            if (info.unlockingPrice) {
                self.salePriceVipLab.text= [NSString stringWithFormat:@"￥%ld起/天",[info.priceInfo[@"startPriceVip"]integerValue]];
            }
        }
        else
        {
            if ([UserInfoManager getUserStatus]==201 ||[UserInfoManager getUserStatus]==202) {
                self.salePriceVipLab.text= [NSString stringWithFormat:@"￥%ld起/天",[info.priceInfo[@"startPriceVip"]integerValue]];
            }
            else
            {
                self.salePriceVipLab.text= [NSString stringWithFormat:@"￥%ld起/天",[info.priceInfo[@"startPrice"]integerValue]];
            }

            if ([info.priceInfo[@"startPrice"]integerValue]==0) {
                self.salePriceVipLab.text=@"咨询价格";
                self.priceDeacLab.text=@"";
            }
        }
    }
    
    if (info.commentInfo==nil) {
        [self.scroeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    else
    {
        [self.scroeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
        NSArray *array1 = @[@"总分",@"性价比",@"表演力",@"配合度",@"好感度"];
        NSArray *array2 = @[@"0.0",@"0.0",@"0.0",@"0.0",@"0.0"];
        
        CGFloat totalScore = [(NSNumber*)safeObjectForKey(info.commentInfo, @"totalScore") floatValue];
        CGFloat performance = [(NSNumber*)safeObjectForKey(info.commentInfo, @"performance") floatValue];
        CGFloat actingPower = [(NSNumber*)safeObjectForKey(info.commentInfo, @"actingPower") floatValue];
        CGFloat coordination = [(NSNumber*)safeObjectForKey(info.commentInfo, @"coordination") floatValue];
        CGFloat favor = [(NSNumber*)safeObjectForKey(info.commentInfo, @"favor") floatValue];
        
        array2 = @[[NSString stringWithFormat:@"%.1f",totalScore],[NSString stringWithFormat:@"%.1f",performance],[NSString stringWithFormat:@"%.1f",actingPower],[NSString stringWithFormat:@"%.1f",coordination],[NSString stringWithFormat:@"%.1f",favor]];
        
        for (int i=0; i<array1.count; i++) {
            UILabel *lab = [self viewWithTag:1000+i];
            NSString *str=[NSString stringWithFormat:@"%@%@",array1[i],array2[i]];
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFB200"]} range:NSMakeRange([array1[i] length],[array2[i] length])];
            lab.attributedText=attStr;
        }
    }
    
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        [self.priceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    else
    {
        [self.priceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
        if ([UserInfoManager getUserStatus]==201 ||[UserInfoManager getUserStatus]==202) {
            self.vipLab.hidden=NO;
            
            //中划线
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%ld/天",[info.priceInfo[@"startPrice"]integerValue]] attributes:attribtDic];
            self.salePriceLab.attributedText = attribtStr;
            
            if ([info.priceInfo[@"startPrice"]integerValue]==0) {
                self.salePriceVipLab.text=@"咨询价格";
                self.vipLab.hidden=YES;
                self.salePriceLab.text=@"";
                self.priceDeacLab.text=@"";
            }
        }
        else
        {
            self.vipLab.hidden=YES;
        }
    }
    
    //购买方非vip用户
    if ([UserInfoManager getUserType]==UserTypePurchaser&&([UserInfoManager getUserStatus]<=200&&[UserInfoManager getUserStatus]!=105)) {
        self.vipApplyView.hidden=NO;
    }
    else
    {
        self.vipApplyView.hidden=YES;
    }
}

//查看更多个人信息
-(void)moreInfoAction
{
    if (self.lookMoreinfo) {
        self.lookMoreinfo();
    }
}

//选择报价
-(void)chooseOfferAction
{
    if (self.chooseOffer) {
        self.chooseOffer();
    }
}

//vip申请
-(void)vipAction
{
    if (self.vipApplyfor) {
        self.vipApplyfor();
    }
}

//刷新价格ui
-(void)reloadPriceUIWithDic:(NSDictionary*)dic withDay:(NSInteger)day
{
    NSArray *priceList = dic[@"priceList"];
    NSInteger advertType = [dic[@"advertType"]integerValue];
    NSString *advName = @"";
    NSString *salePrice = @"0";
    NSString *salePriceVip = @"0";

    for (int i=0; i<priceList.count; i++) {
        NSDictionary *dicA = priceList[i];
        if ([dicA[@"days"]integerValue]==day) {
            salePrice =dicA[@"salePrice"];
            salePriceVip =dicA[@"salePriceVip"];
        }
    }
    
    if (advertType==1) {
        advName=@"视频";
    }
    else if (advertType==2)
    {
        advName=@"平面";
    }
    else if (advertType==4)
    {
        advName=@"套拍";
    }
    
    if ([UserInfoManager getUserStatus]==201 ||[UserInfoManager getUserStatus]==202) {
        self.salePriceVipLab.text= [NSString stringWithFormat:@"¥%@",salePriceVip];
        self.priceDeacLab.text=[NSString stringWithFormat:@"%@：¥%@/%ld天",advName,[priceList firstObject][@"salePriceVip"],day];
    }
    else
    {
        self.salePriceVipLab.text= [NSString stringWithFormat:@"¥%@",salePrice];
        self.priceDeacLab.text=[NSString stringWithFormat:@"%@：¥%@/%ld天",advName,[priceList firstObject][@"salePrice"],day];
    }

    if ([UserInfoManager getUserStatus]==201 ||[UserInfoManager getUserStatus]==202) {
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",salePrice] attributes:attribtDic];
        self.salePriceLab.attributedText = attribtStr;
    }
    else
    {
        self.salePriceLab.text=@"";
    }

}

@end
