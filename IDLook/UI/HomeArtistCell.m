//
//  HomeArtistCell.m
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeArtistCell.h"
#import "AskPriceView.h"
@interface HomeArtistCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIButton *lookPriceBtn;
@property(nonatomic,strong) UIButton *reginBtn;  //所在地
@property(nonatomic,strong)UIButton *occupationBtn; //职业
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UIView *typeView;  //表演类型view
@end

@implementation HomeArtistCell

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        self.layer.cornerRadius=5.0;
//        self.layer.masksToBounds=YES;
//            self.clipsToBounds=YES;
//            self.layer.shadowOffset = CGSizeMake(5, 5);
//            self.layer.shadowOpacity = 1.0;
//            self.layer.shadowColor = [[UIColor colorWithHexString:@"#549DD2"] colorWithAlphaComponent:0.1].CGColor;
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.userInteractionEnabled=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserHead)];
        [_icon addGestureRecognizer:tap];
        _icon.clipsToBounds=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-60);
        }];

    }
    return _icon;
}

-(UILabel*)name
{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont boldSystemFontOfSize:14.0];
        _name.textColor=Public_Text_Color;
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(10);
            make.top.mas_equalTo(self.icon.mas_bottom).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _name;
}

-(UIButton*)lookPriceBtn
{
    if (!_lookPriceBtn) {
        _lookPriceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_lookPriceBtn];
        [_lookPriceBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
      //  [_lookPriceBtn setTitleColor:Public_Text_Color forState:UIControlStateDisabled];
        _lookPriceBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_lookPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.name);
            make.right.mas_equalTo(self.contentView).offset(-5);
        }];
        [_lookPriceBtn addTarget:self action:@selector(lookUserOfferAction) forControlEvents:UIControlEventTouchUpInside];
//        _lookPriceBtn.enabled=NO;
    }
    return _lookPriceBtn;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        _bgV.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self.contentView addSubview:_bgV];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.icon);
            make.height.mas_equalTo(28);
        }];
    }
    return _bgV;
}

-(UIButton*)reginBtn
{
    if (!_reginBtn) {
        _reginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:_reginBtn];
        [_reginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reginBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
        [_reginBtn setImage:[UIImage imageNamed:@"home_postion_white"] forState:UIControlStateNormal];
        [_reginBtn setImage:[UIImage imageNamed:@"home_postion_white"] forState:UIControlStateHighlighted];
        [_reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.centerY.mas_equalTo(self.bgV);
        }];
        
        //粗体
        if (IsBoldSize()) {
            _reginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 7);
        }
    }
    return _reginBtn;
}

-(UIButton*)occupationBtn
{
    if (!_occupationBtn) {
        _occupationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:_occupationBtn];
        _occupationBtn.layer.masksToBounds=YES;
        _occupationBtn.layer.cornerRadius=9.0;
//        _occupationBtn.enabled=NO;
        _occupationBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.6];
        [_occupationBtn setTitleColor:[UIColor colorWithHexString:@"#FF177F"] forState:UIControlStateNormal];
        _occupationBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_occupationBtn setImage:[UIImage imageNamed:@"home_auth"] forState:UIControlStateNormal];
        [_occupationBtn setImage:[UIImage imageNamed:@"home_auth"] forState:UIControlStateHighlighted];
        [_occupationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(7);
            make.centerY.mas_equalTo(self.bgV);
            make.size.mas_equalTo(CGSizeMake(67, 18));
        }];
        _occupationBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 3, 0, -3);
    }
    return _occupationBtn;
}

-(UIView*)typeView
{
    if (!_typeView) {
        _typeView=[[UIView alloc]init];
        [self.contentView addSubview:_typeView];
        [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.name.mas_bottom);
        }];
    }
    return _typeView;
}

-(void)reloadUIWithModel:(UserModel *)info
{
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.head]];
//    UIImage *image = [UIImage imageWithData:data];
//    self.icon.image=image;
    _userModel = info;
    [self.icon sd_setImageWithUrlStr:info.actorHeadPorUrl placeholderImage:[UIImage imageNamed:@"default_home"]];


    if ([UserInfoManager getUserType]==UserTypeResourcer)
    {
        self.lookPriceBtn.hidden=YES;
    }
    else
    {
        if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist || [UserInfoManager getUserAuthState]!=1) {
            self.lookPriceBtn.hidden=YES;
        }
        else
        {
            [self.lookPriceBtn setTitle:[NSString stringWithFormat:@"¥ %ld/天",info.startPrice] forState:UIControlStateNormal];
            if (info.startPrice==0) {
                [_lookPriceBtn setTitleColor:Public_Red_Color forState:0];
                [_lookPriceBtn setTitle:@"咨询报价" forState:0];
            }
            self.lookPriceBtn.hidden=NO;
        }
    }
    
    self.reginBtn.hidden=info.actorRegion.length>0?NO:YES;
    [self.reginBtn setTitle:info.actorRegion forState:UIControlStateNormal];
    
    self.occupationBtn.hidden=info.mastery>0?NO:YES;
    
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"masteryType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if (info.mastery == [dic[@"attrid"] integerValue]) {
            [self.occupationBtn setTitle:dic[@"attrname"] forState:UIControlStateNormal];
        }
    }

    for (UIView *view in self.typeView.subviews) {
        [view removeFromSuperview];
    }
    
    if (info.actorPerformType.length>0) {
        NSArray  *array = [info.actorPerformType componentsSeparatedByString:@"|"];
        //performtype 会出现 ：|潮酷|阳光|青春|文艺|职场 导致array的某一个元素是空的
       
        NSMutableArray *newArr = [NSMutableArray new];
       
        for (NSString *pfm in array) {
            if (pfm.length>1) {
                [newArr addObject:pfm];
            }
        }
        array = [newArr copy];
        for (int i =0; i<array.count; i++) {
            if (i>=3) {
                break;
            }
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [self.typeView addSubview:btn];
            [btn setBackgroundImage:[UIImage imageNamed:@"home_type"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:11.0];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(10+50*i);
                make.centerY .mas_equalTo(self.typeView);
            }];
        }
    }

    NSString *sex = @"";
    if (info.sex==1) {
        sex=@"/男";
    }
    else if (info.sex==2)
    {
        sex=@"/女";
    }
    else
    {
        sex=@"  ";
    }

    
    NSString *str=[NSString stringWithFormat:@"%@%@",info.actorNickname.length>0?info.actorNickname:info.actorNickname,sex];
    
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(str.length-2,2)];
    self.name.attributedText=attStr;
}


-(void)clickUserHead
{
    if (self.clickUserInfo) {
        self.clickUserInfo();
    }
}

-(void)lookUserOfferAction
{
    if (_userModel.startPrice==0) {
        AskPriceView *ap  = [[AskPriceView alloc] init];
        [ap showWithTitle:@"咨询价格" desc:@"此演员价格受拍摄日期，脚本影响较大，无固定价格。具体价格请拨打400-833-6969咨询脸探副导。" leftBtn:@"" rightBtn:@"" phoneNum:@"4008336969"];
        return;
    }
//    if (self.lookUserOffer) {
//        self.lookUserOffer();
//    }
    if (self.clickUserInfo) {
        self.clickUserInfo();
    }
}


@end
