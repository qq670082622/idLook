//
//  CouponTopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CouponTopV.h"

@interface CouponTopV ()<UITextFieldDelegate>
@property(nonatomic,strong)CustomTextField *textField;
@end

@implementation CouponTopV

-(id)init
{
    if (self=[super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    CustomTextField *textField = [[CustomTextField alloc] init];
    textField.backgroundColor=Public_Background_Color;
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=4.0;
    textField.delegate=self;
    textField.font=[UIFont systemFontOfSize:14];
//    textField.keyboardType=UIKeyboardTypeDecimalPad;
    textField.placeholder=@"请输入兑换码";
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-62);
        make.height.mas_equalTo(30);
    }];

    UIView *leftV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10,10)];
    textField.leftView=leftV;
    textField.leftViewMode=UITextFieldViewModeAlways;
    self.textField=textField;

    UIButton *convertBtn=[[UIButton alloc]init];
    [self addSubview:convertBtn];
    convertBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [convertBtn setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
    [convertBtn setTitle:@"兑换" forState:UIControlStateNormal];
    [convertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(textField);
    }];
    [convertBtn addTarget:self action:@selector(convertBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    //说明view
    UIView *bg = [[UIView alloc]init];
    bg.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
    bg.userInteractionEnabled=YES;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(50);
        make.bottom.mas_equalTo(self);
    }];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(explainAction)];
    [bg addGestureRecognizer:tap];
    
    UIImageView *promtV=[[UIImageView alloc]init];
    [bg addSubview:promtV];
    promtV.contentMode=UIViewContentModeScaleAspectFill;
    promtV.image=[UIImage imageNamed:@"coupon_ask"];
    [promtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bg);
        make.left.mas_equalTo(bg).offset(15);
    }];
    
    UILabel *descLab = [[UILabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:13];
    descLab.textColor =[UIColor colorWithHexString:@"#FF6600"];
    [bg addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(35);
    }];
    descLab.text=@"点击查看优惠券使用说明";
    
    UIImageView *arrow=[[UIImageView alloc]init];
    [bg addSubview:arrow];
    arrow.contentMode=UIViewContentModeScaleAspectFill;
    arrow.image=[UIImage imageNamed:@"coupon_arrow"];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bg);
        make.right.mas_equalTo(bg).offset(-15);
    }];
}

//兑换
-(void)convertBtnAction
{
    if (self.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请输入兑换码"];
        return;
    }
    [self endEditing:YES];
    if (self.convertBlock) {
        self.convertBlock(self.textField.text);
    }
}

//查看说明
-(void)explainAction
{
    if (self.explainBlock) {
        self.explainBlock();
    }
}

@end
