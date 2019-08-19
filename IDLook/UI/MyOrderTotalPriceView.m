//
//  MyOrderTotalPriceView.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/22.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderTotalPriceView.h"

@interface MyOrderTotalPriceView ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *delectBtn;  //删除订单
@property(nonatomic,strong)UIButton *evaluationBtn;  // 评价，查看评价
@property(nonatomic,strong)UIButton *invoiceBtn;  // 申请开票

@end

@implementation MyOrderTotalPriceView

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=1;
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"合计：";
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(15);
        }];
    }
    return _titleLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:17];
        _priceLab.textColor=Public_Text_Color;
        [self addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _priceLab;
}

-(UIButton*)delectBtn
{
    if (!_delectBtn) {
        _delectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_delectBtn];
        _delectBtn.layer.masksToBounds=YES;
        _delectBtn.layer.cornerRadius=3.0;
        _delectBtn.layer.borderColor=Public_DetailTextLabelColor.CGColor;
        _delectBtn.layer.borderWidth=1;
        [_delectBtn setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
        [_delectBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        _delectBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_delectBtn addTarget:self action:@selector(delectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectBtn;
}


-(UIButton*)evaluationBtn
{
    if (!_evaluationBtn) {
        _evaluationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_evaluationBtn];
        _evaluationBtn.layer.masksToBounds=YES;
        _evaluationBtn.layer.cornerRadius=3.0;
        _evaluationBtn.layer.borderColor=Public_Red_Color.CGColor;
        _evaluationBtn.layer.borderWidth=1;
        [_evaluationBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        [_evaluationBtn setTitle:@"评价" forState:UIControlStateNormal];
        _evaluationBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_evaluationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_evaluationBtn addTarget:self action:@selector(evaluationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluationBtn;
}

-(UIButton*)invoiceBtn
{
    if (!_invoiceBtn) {
        _invoiceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_invoiceBtn];
        _invoiceBtn.layer.masksToBounds=YES;
        _invoiceBtn.layer.cornerRadius=3.0;
        _invoiceBtn.layer.borderColor=[UIColor colorWithHexString:@"#BCBCBC"].CGColor;
        _invoiceBtn.layer.borderWidth=1;
        [_invoiceBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [_invoiceBtn setTitle:@"申请开票" forState:UIControlStateNormal];
        _invoiceBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [_invoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_invoiceBtn addTarget:self action:@selector(invoiceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _invoiceBtn;
}

-(void)reloadUIWithTotalPrice:(NSInteger)price withProjectModel:(OrderProjectModel *)model
{
    [self titleLab];
    self.priceLab.text = [NSString stringWithFormat:@"¥%ld",price];
    if (model.ordeState==OrderStateTypeFinished && model.type==2) {//仅拍摄订单可以评价
//        if (model.isevaluate==1) {  //可以评价
//            [self.evaluationBtn setTitle:@"评价" forState:UIControlStateNormal];
//            self.evaluationBtn.hidden=NO;
//        }
//        else
//        {
//            if (model.allevaluate>0) {
//                [self.evaluationBtn setTitle:@"查看评价" forState:UIControlStateNormal];
//                self.evaluationBtn.hidden=NO;
//            }
//            else
//            {
//                self.evaluationBtn.hidden=YES;
//            }
//        }
        self.evaluationBtn.hidden=YES;
        self.invoiceBtn.hidden=NO;
    }
    else if (model.ordeState==OrderStateTypeFailure)
    {
        self.evaluationBtn.hidden=YES;
        self.invoiceBtn.hidden=YES;
    }else{
        self.evaluationBtn.hidden=YES;
        self.invoiceBtn.hidden=YES;
    }
}

//删除订单
-(void)delectBtnAction:(UIButton*)sender
{
    if (self.delectOrderBlock) {
        self.delectOrderBlock();
    }
}

//评价，查看评价
-(void)evaluationBtnAction:(UIButton*)sender
{
    if (self.evaluateOrderBlock) {
        self.evaluateOrderBlock();
    }
}

//申请开票
-(void)invoiceBtnAction
{
    if (self.applyforInvoiceBlock) {
        self.applyforInvoiceBlock();
    }
}

@end
