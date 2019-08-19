//
//  AuditWayPopV.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuditWayPopV.h"
@interface AuditWayPopV()
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,strong)NSArray *dataS;
@property (nonatomic,assign)CGFloat vHeight;
@end

@implementation AuditWayPopV

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, self.vHeight)];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showWithOrderM:(OrderStructM *)model
{
    self.dataS = [PlaceOrderModel getAuditionWay];
    self.vHeight = 68 + self.dataS.count*80 +10;
    for (int i=0; i<self.dataS.count; i++) {
        OrderStructM *modelA  = self.dataS[i];
        if ([model.content isEqualToString:modelA.title]) {
            modelA.isChoose=YES;
        }
    }

    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    self.maskV=maskV;
    
    [showWindow addSubview:self];
    
    [self initUI];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-self.vHeight, UI_SCREEN_WIDTH, self.vHeight);
    
    [UIView commitAnimations];
}


- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, self.vHeight);
    [UIView commitAnimations];
}

- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}

- (void)confirmSelected
{
    OrderStructM *model = [OrderStructM new];
    for (int i=0; i<self.dataS.count; i++) {
        OrderStructM *modelA = self.dataS[i];
        if (modelA.isChoose==YES) {
            model=modelA;
        }
    }
    if (model.isChoose==NO) {
//        [SVProgressHUD showImage:nil status:@"请选择试镜方式"];
        return;
    }
    
    if (self.auditionWayChooseWithModel) {
        self.auditionWayChooseWithModel(model);
    }
    [self hide];
}


- (void)initUI
{
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.equalTo(self).offset(13);
    }];
    title.text=@"选择试镜方式";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
#if 0
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    btn.backgroundColor=Public_Red_Color;
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=5.0;
    [btn addTarget:self action:@selector(confirmSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-30);
        make.left.mas_equalTo(self).offset(15);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(48);
    }];
#endif
    
    
    for (int i=0; i<self.dataS.count; i++) {
        OrderStructM *model = self.dataS[i];
        
        AuditPopCell *cell = [[AuditPopCell alloc]init];
        cell.userInteractionEnabled=YES;
        cell.tag=1000+i;
        [self addSubview:cell];
        [cell reloadUIWithOrderM:model];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(68+i*80);
            make.height.mas_equalTo(64);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTapAction:)];
        [cell addGestureRecognizer:tap];
    }

}

-(void)cellTapAction:(UITapGestureRecognizer*)tap
{
    OrderStructM *models = [[OrderStructM alloc]init];
    for (int i=0; i<self.dataS.count; i++) {
        OrderStructM *model = self.dataS[i];
        if (i==tap.view.tag-1000) {
            model.isChoose=YES;
            models=model;
        }
        else
        {
            model.isChoose=NO;
        }
        
        AuditPopCell *cell = [self viewWithTag:1000+i];
        [cell reloadUIWithOrderM:model];
    }
    
    if (self.auditionWayChooseWithModel) {
        self.auditionWayChooseWithModel(models);
    }
    [self hide];
}

@end

@interface AuditPopCell ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *priceLab;
@end

@implementation AuditPopCell

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [self addSubview:_bgV];
        _bgV.backgroundColor=Public_Background_Color;
        _bgV.layer.cornerRadius=4.0;
        _bgV.layer.masksToBounds=YES;
        _bgV.layer.borderColor=Public_Background_Color.CGColor;
        _bgV.layer.borderWidth=0.5;
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self);
        }];
    }
    return _bgV;
}


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(15);
            make.top.mas_equalTo(self).offset(13);
        }];
    }
    return _titleLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        _descLab.font=[UIFont systemFontOfSize:11];
        _descLab.textColor=[UIColor colorWithHexString:@"#909090"];
        [self addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(15);
            make.bottom.mas_equalTo(self).offset(-13);
        }];
    }
    return _descLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont systemFontOfSize:18];
        _priceLab.textColor=Public_Text_Color;
        [self addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-15);
            make.top.mas_equalTo(self).offset(15);
        }];
    }
    return _priceLab;
}

-(void)reloadUIWithOrderM:(OrderStructM *)model
{
    [self bgV];
    self.titleLab.text=model.title;
    self.descLab.text=model.desc;
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",model.price];
    if (model.isChoose==NO) {
        self.bgV.backgroundColor=Public_Background_Color;
        self.bgV.layer.borderColor=Public_Background_Color.CGColor;
        self.titleLab.textColor=Public_Text_Color;
        self.descLab.textColor=[UIColor colorWithHexString:@"#909090"];
        self.priceLab.textColor=Public_Text_Color;
    }
    else
    {
        self.bgV.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.1];
        self.bgV.layer.borderColor=Public_Red_Color.CGColor;
        self.titleLab.textColor=Public_Red_Color;
        self.descLab.textColor=Public_Red_Color;
        self.priceLab.textColor=Public_Red_Color;
    }
}

@end
