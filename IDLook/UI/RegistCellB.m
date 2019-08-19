//
//  RegistCellB.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RegistCellB.h"

@interface RegistCellB ()
@property(nonatomic,strong)UIImageView *leftView;
@property(nonatomic,strong)UIButton *actorBtn;  //我是画演员
@property(nonatomic,strong)UIButton *buyerBtn;   //我是买家
@property(nonatomic,strong)UIButton *personBuy;   //个人购买
@property(nonatomic,strong)UIButton *companyBuy;   //公司购买
@property(nonatomic,strong)UIImageView *chooseView; //对勾
@end

@implementation RegistCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *lineV=[[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.mas_equalTo(self.contentView).offset(70);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(70);
        }];
    }
    return self;
}

-(UIImageView*)leftView
{
    if (!_leftView) {
        _leftView=[[UIImageView alloc]init];
        [self.contentView addSubview:_leftView];
        _leftView.image=[UIImage imageNamed:@"icon_usertype"];
        _leftView.contentMode=UIViewContentModeScaleAspectFill;
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_top).offset(35);
            make.left.mas_equalTo(self.contentView).offset(30);
        }];
        
        UIView *rightV=[[UIView alloc]init];
        rightV.backgroundColor=[UIColor colorWithHexString:@"#FFC4C8"];
        [self.contentView addSubview:rightV];
        [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_leftView);
            make.left.mas_equalTo(self.contentView).offset(54);
            make.size.mas_equalTo(CGSizeMake(1.5, 17));
        }];
    }
    return _leftView;
}

-(UIButton*)actorBtn
{
    if (!_actorBtn) {
        _actorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_actorBtn];
        [_actorBtn setTitle:@"我是演员" forState:UIControlStateNormal];
        [_actorBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        _actorBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_actorBtn setImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_actorBtn setImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [_actorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_top).offset(35);
            make.left.mas_equalTo(self.contentView).offset(72);
        }];
        
        _actorBtn.titleLabel.backgroundColor = _actorBtn.backgroundColor;
        _actorBtn.imageView.backgroundColor = _actorBtn.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = _actorBtn.titleLabel.bounds.size;
        CGSize imageSize = _actorBtn.imageView.bounds.size;
        CGFloat interval = 1.0;
        _actorBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        _actorBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval+10), 0, imageSize.width + interval);
        [_actorBtn addTarget:self action:@selector(actorAction:) forControlEvents:UIControlEventTouchUpInside];
        _actorBtn.selected=YES;
    }
    return _actorBtn;
}

-(UIButton*)buyerBtn
{
    if (!_buyerBtn) {
        _buyerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_buyerBtn];
        [_buyerBtn setTitle:@"我是买家" forState:UIControlStateNormal];
        [_buyerBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        _buyerBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_buyerBtn setImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_buyerBtn setImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [_buyerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_top).offset(35);
            make.right.mas_equalTo(self.contentView).offset(-40);
        }];
        
        _buyerBtn.titleLabel.backgroundColor = _buyerBtn.backgroundColor;
        _buyerBtn.imageView.backgroundColor = _buyerBtn.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = _buyerBtn.titleLabel.bounds.size;
        CGSize imageSize = _buyerBtn.imageView.bounds.size;
        CGFloat interval = 1.0;
        _buyerBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        _buyerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval+10), 0, imageSize.width + interval);
        [_buyerBtn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyerBtn;
}

-(UIButton*)personBuy
{
    if (!_personBuy) {
        _personBuy=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_personBuy];
        [_personBuy setTitle:@"个人购买" forState:UIControlStateNormal];
        [_personBuy setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [_personBuy setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        _personBuy.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_personBuy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_top).offset(35+70);
            make.left.mas_equalTo(self.contentView).offset(72);
            make.size.mas_equalTo(CGSizeMake(65, 20));
        }];
        [_personBuy addTarget:self action:@selector(personBuyAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _personBuy;
}

-(UIButton*)companyBuy
{
    if (!_companyBuy) {
        _companyBuy=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_companyBuy];
        [_companyBuy setTitle:@"公司购买" forState:UIControlStateNormal];
        [_companyBuy setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [_companyBuy setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        _companyBuy.titleLabel.font=[UIFont systemFontOfSize:15.0];

        [_companyBuy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_top).offset(35+70);
            make.right.mas_equalTo(self.contentView).offset(-64);
            make.size.mas_equalTo(CGSizeMake(65, 20));
        }];
        
        [_companyBuy addTarget:self action:@selector(companyBuyAction:) forControlEvents:UIControlEventTouchUpInside];
//        _companyBuy.selected=YES;
    }
    return _companyBuy;
}

-(UIImageView*)chooseView
{
    if (!_chooseView) {
        _chooseView=[[UIImageView alloc]init];
        [self.contentView addSubview:_chooseView];
        UIImage *image = [UIImage imageNamed:@"regist_choose"];
        _chooseView.image=image;
        _chooseView.contentMode=UIViewContentModeScaleAspectFill;
        [_chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_top).offset(35+70);
//            make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
            make.left.mas_equalTo(self.companyBuy.mas_right).offset(5);
        }];
        _chooseView.hidden=YES;
    }
    return _chooseView;
}

-(void)reloadUIWithModel:(LoginCellStrutM *)model
{
    [self leftView];    
    if (model.userType==UserTypeResourcer) {
        self.actorBtn.selected=YES;
        self.buyerBtn.selected=NO;
    }
    else
    {
        self.actorBtn.selected=NO;
        self.buyerBtn.selected=YES;
    }
}

//我是演员
-(void)actorAction:(UIButton*)sender
{
    if (sender.selected) {
        return;
    }
    self.actorBtn.selected=YES;
    self.buyerBtn.selected=NO;
    if (self.typeChoose1) {
        self.typeChoose1(UserTypeResourcer);
    }
}

//我是买家
-(void)buyAction:(UIButton*)sender
{
    if (sender.selected) {
        return;
    }
    self.actorBtn.selected=NO;
    self.buyerBtn.selected=YES;
    if (self.typeChoose1) {
        self.typeChoose1(UserTypePurchaser);
    }
}

//个人购买
-(void)personBuyAction:(UIButton*)sender
{
    if (sender.selected) {
        return;
    }
    self.chooseView.hidden=NO;
    self.personBuy.selected=YES;
    self.companyBuy.selected=NO;

    [self.chooseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_top).offset(35+70);
        make.left.mas_equalTo(self.personBuy.mas_right).offset(5);
    }];
    
    if (self.buyerChoose) {
        self.buyerChoose(0);
    }
}

//公司购买
-(void)companyBuyAction:(UIButton*)sender
{
    if (sender.selected) {
        return;
    }
    self.chooseView.hidden=NO;
    self.personBuy.selected=NO;
    self.companyBuy.selected=YES;

    [self.chooseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_top).offset(35+70);
        make.left.mas_equalTo(self.companyBuy.mas_right).offset(5);
    }];
    
    if (self.buyerChoose) {
        self.buyerChoose(1);
    }
}


@end
