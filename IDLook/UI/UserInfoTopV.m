//
//  UserInfoHeadV.m
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoTopV.h"
#import "UinfoEvaluateView.h"
#import "UinfoSubVA.h"

@interface UserInfoTopV ()
@property (nonatomic,strong)UIImageView *bg;  //背景图
@property (nonatomic,strong)UinfoSubVA *centerView;  //中间视图
@property (nonatomic,strong)UinfoEvaluateView *evaluateView;  //评价视图

@end

@implementation UserInfoTopV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        
        [self bg];
        [self initUI];
        [self centerView];
    }
    return self;
}

-(UIImageView*)bg
{
    if (!_bg) {
        _bg=[[UIImageView alloc]initWithFrame:CGRectMake(0,-SafeAreaTopHeight, UI_SCREEN_WIDTH, SafeAreaTopHeight+144)];
        [self addSubview:_bg];
        _bg.contentMode=UIViewContentModeScaleAspectFill;
        _bg.clipsToBounds=YES;
        
        //虚化
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.userInteractionEnabled=YES;
        [_bg addSubview:effectview];
        [effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bg).insets(UIEdgeInsetsZero);
        }];
        
        UIView *bgV = [[UIView alloc]init];
        bgV.backgroundColor=[[UIColor colorWithHexString:@"#A0A0A0"]colorWithAlphaComponent:0.4];
        [_bg addSubview:bgV];
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bg).insets(UIEdgeInsetsZero);
        }];
    }
    return _bg;
}

-(UinfoSubVA*)centerView
{
    if (!_centerView) {
        _centerView=[[UinfoSubVA alloc]init];
        [self addSubview:_centerView];
        _centerView.backgroundColor=[UIColor whiteColor];
        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self.bg.mas_bottom);
            make.height.mas_equalTo(144);
        }];
        WeakSelf(self);
        _centerView.lookMoreinfo = ^{
            if (weakself.UserInfoTopVDetialInfo) {
                weakself.UserInfoTopVDetialInfo();
            }
        };
        _centerView.vipApplyfor = ^{
            if (weakself.UserInfoTopVvipApplyfor) {
                weakself.UserInfoTopVvipApplyfor();
            }
        };
        _centerView.chooseOffer = ^{
            [weakself lookPrice];
        };
    }
    return _centerView;
}

-(UinfoEvaluateView*)evaluateView
{
    if (!_evaluateView) {
        _evaluateView=[[UinfoEvaluateView alloc]init];
        [self addSubview:_evaluateView];
        _evaluateView.backgroundColor=[UIColor whiteColor];
        [_evaluateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self.centerView.mas_bottom).offset(10);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
        WeakSelf(self);
        _evaluateView.lookAllEvaluate = ^{
            if (weakself.lookAllEvaluateBlock) {
                weakself.lookAllEvaluateBlock();
            }
        };
    }
    return _evaluateView;
}

-(void)initUI
{
    //头像
    UIImageView *icon = [[UIImageView alloc]init];
    [self addSubview:icon];
    icon.layer.cornerRadius=47;
    icon.layer.masksToBounds=YES;
    icon.tag=1000;
    icon.contentMode=UIViewContentModeScaleAspectFill;
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bg).offset(-28);
        make.right.mas_equalTo(self).offset(-30);
        make.size.mas_equalTo(CGSizeMake(94, 94));
    }];
    
    //工作室图标
    UIImageView *studioIcon=[[UIImageView alloc]init];
    [self addSubview:studioIcon];
    studioIcon.tag=1001;
    studioIcon.image=[UIImage imageNamed:@"u_info_studio"];
    studioIcon.contentMode=UIViewContentModeScaleAspectFill;
    [studioIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(icon).offset(0);
        make.top.mas_equalTo(icon.mas_bottom).offset(-10);
    }];

    //名字
    UILabel *name = [[UILabel alloc]init];
    [self addSubview:name];
    name.font=[UIFont boldSystemFontOfSize:20];
    name.textColor=[UIColor whiteColor];
    name.tag=1002;
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(16);
        make.top .mas_equalTo(icon);
    }];
    
    //认证图标
    UIButton *authBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:authBtn];
    authBtn.tag=1003;
    authBtn.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.3];
    authBtn.layer.cornerRadius=8.0;
    authBtn.layer.masksToBounds=YES;
    [authBtn setImage:[UIImage imageNamed:@"u_info_auth"] forState:UIControlStateDisabled];
    [authBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    authBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [authBtn setTitle:@"已认证" forState:UIControlStateNormal];
    //粗体
    if (IsBoldSize()) {
        authBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2);
    }
    [authBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(name.mas_right).offset(5);
        make.centerY.mas_equalTo(name);
        make.size.mas_equalTo(CGSizeMake(56, 16));
    }];
    authBtn.enabled=NO;
    
    //性别图标
    UIImageView *sexIcon = [[UIImageView alloc]init];
    [self addSubview:sexIcon];
    sexIcon.tag=1004;
    sexIcon.contentMode=UIViewContentModeScaleAspectFill;
    [sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(16);
        make.centerY.mas_equalTo(icon);
    }];
    
    //地点，职业
    UILabel *occupationLab = [[UILabel alloc]init];
    [self addSubview:occupationLab];
    occupationLab.font=[UIFont systemFontOfSize:13];
    occupationLab.textColor=[UIColor whiteColor];
    occupationLab.tag=1005;
    [occupationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sexIcon.mas_right).offset(5);
        make.centerY.mas_equalTo(icon);
    }];
    
    //表演类型
    UILabel *performLab = [[UILabel alloc]init];
    [self addSubview:performLab];
    performLab.font=[UIFont systemFontOfSize:13];
    performLab.textColor=[UIColor whiteColor];
    performLab.tag=1006;
    [performLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(18);
        make.top .mas_equalTo(occupationLab.mas_bottom).offset(5);
    }];
    
    //收藏点赞量
    UILabel *collectNum = [[UILabel alloc]init];
    [self addSubview:collectNum];
    collectNum.font=[UIFont systemFontOfSize:12];
    collectNum.textColor=[[UIColor whiteColor]colorWithAlphaComponent:0.8];
    collectNum.tag=1007;
    [collectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(18);
        make.bottom.mas_equalTo(self.bg).offset(-13);
    }];

    
}


//查看报价
-(void)lookPrice
{
    self.UserInfoTopVLookPrice();
}

-(void)reloadUIWithInfo:(UserDetialInfoM *)info
{
    [self.bg sd_setImageWithUrlStr:info.avatar placeholderImage:[UIImage imageNamed:@"default_video"]];
    
    UIImageView *icon =[self viewWithTag:1000];          //头像
    UIImageView *studioIcon =[self viewWithTag:1001];    //工作室图标
    UILabel *name = [self viewWithTag:1002];     //名字
    UIButton *authBtn =[self viewWithTag:1003];   //认证图标
    UIImageView *sexIcon =[self viewWithTag:1004];          //性别图标
    UILabel *occupationLab = [self viewWithTag:1005];     //地点，职业
    UILabel *performLab = [self viewWithTag:1006];     //表演类型
    UILabel *collectNum = [self viewWithTag:1007];     //收藏点赞量


    [icon sd_setImageWithUrlStr:info.avatar placeholderImage:[UIImage imageNamed:@"default_icon"]];
    studioIcon.hidden=info.actorStudio==1?NO:YES;
    name.text=info.nickName;
    authBtn.hidden = info.authentication==1?NO:YES;

    if (info.sex==1) {
        sexIcon.image=[UIImage imageNamed:@"u_info_man"];
    }
    else if (info.sex==2)
    {
        sexIcon.image=[UIImage imageNamed:@"u_info_woman"];
    }
    
    NSString *occupationStr=@"";
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"masteryType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if (info.mastery == [dic[@"attrid"] integerValue]) {
            occupationStr=dic[@"attrname"];
        }
    }
    
    if (occupationStr.length>0) {
        occupationStr=[NSString stringWithFormat:@"• %@",occupationStr];
    }
    
    NSString *region = @"";
    if (info.region.length>0) {
        region = [NSString stringWithFormat:@"• %@",info.region];
    }
    
    occupationLab.text=[NSString stringWithFormat:@"%@%@",region,occupationStr];
    
    NSArray *performArr = [info.performType componentsSeparatedByString:@"|"];
    NSMutableArray  *performArray = [NSMutableArray new];
    
    for (int i=0; i<performArr.count; i++) {
        if (i<3&&([performArr[i] length]>0)) {
            [performArray addObject:performArr[i]];
        }
    }
    
    performLab.text=[performArray componentsJoinedByString:@"/"];
    collectNum.text=  [NSString stringWithFormat:@"%ld收藏  |  %ld点赞",info.collect,info.praise];
    
    if (info.lastComment!=nil) {
        NSInteger count = [info.commentInfo[@"count"]integerValue];
        [self.evaluateView reloadUIWithDic:info.lastComment withCount:count];
    }
    
    [self.centerView reloadUIWithInfo:info];
    
    CGFloat height = 44;   //简介高度
    if (info.commentInfo!=nil) {  //评分高度
        height+=44;
    }
    
    if ([UserInfoManager getUserType]!=UserTypeResourcer) {  //报价一栏高度
        height+=44;
    }
    
    //vip申请一栏
    if ([UserInfoManager getUserType]==UserTypePurchaser&&([UserInfoManager getUserStatus]<=200&&[UserInfoManager getUserStatus]!=105)) {
        height+=40;
    }
    
    [self.centerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}


-(void)changeImageFrameWithOffY:(CGFloat)offY
{
    self.bg.frame=CGRectMake(0,offY,self.frame.size.width, 144-offY);
}

//刷新价格的ui
-(void)reloadTopPriceUIWithDic:(NSDictionary*)dic withDay:(NSInteger)day
{
    [self.centerView reloadPriceUIWithDic:dic withDay:day];
}

@end
