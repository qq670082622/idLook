//
//  ScheduleWayPopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/7.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ScheduleWayPopV.h"

@interface ScheduleWayPopV()
@property (nonatomic,strong)UIView *maskV;
@property (nonnull,strong)NSArray *dataS;
@property (nonatomic,strong)UIButton *agreeBtn;
@property (nonatomic,strong)UIButton *agreeLabBtn;
@end

@implementation ScheduleWayPopV

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 376)];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showWithOrderM:(OrderStructM *)model withPrice:(NSString *)price
{
    self.dataS = [PlaceOrderModel getScheduleWay];
    for (int i=0; i<self.dataS.count; i++) {
        OrderStructM *modelA  = self.dataS[i];
        if ([model.content isEqualToString:modelA.title]) {
            modelA.isChoose=YES;
        }
        if (i==1) {
            modelA.price = price;
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
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-376, UI_SCREEN_WIDTH, 376);
    
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
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 376);
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
        [SVProgressHUD showImage:nil status:@"请选择锁档方式"];
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
    title.text=@"档期预约金";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
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
    
    
    for (int i=0; i<self.dataS.count; i++) {
        OrderStructM *model = self.dataS[i];
        
        ScheduleWayPopCell *cell = [[ScheduleWayPopCell alloc]init];
        cell.userInteractionEnabled=YES;
        cell.tag=1000+i;
        [self addSubview:cell];
        [cell reloadUIWithOrderM:model];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(68+i*100);
            make.height.mas_equalTo(84);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTapAction:)];
        [cell addGestureRecognizer:tap];
    }
    
    UIButton *agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setImage:[UIImage imageNamed:@"icon_select_default"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"icon_select_default"] forState:UIControlStateDisabled];
    [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor colorWithHexString:@"#9B9B9B"] forState:UIControlStateNormal];
    agreeBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.bottom.mas_equalTo(self).offset(-92);
    }];
    agreeBtn.enabled=NO;
    agreeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0,-2);
    //粗体
    if (IsBoldSize()) {
        agreeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    }
    agreeBtn.hidden=YES;
    self.agreeBtn=agreeBtn;
    
    UIButton *agreeLabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [agreeLabBtn setTitle:@"《档期预约金服务协议》" forState:UIControlStateNormal];
    [agreeLabBtn setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
    agreeLabBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:agreeLabBtn];
    [agreeLabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(agreeBtn.mas_right).offset(0);
        make.centerY.mas_equalTo(agreeBtn);
    }];
    [agreeLabBtn addTarget:self action:@selector(lookAction) forControlEvents:UIControlEventTouchUpInside];
    agreeLabBtn.hidden=YES;
    self.agreeLabBtn=agreeLabBtn;

    OrderStructM *modelA  = [self.dataS lastObject];
    if (modelA.isChoose) {
        self.agreeBtn.hidden=NO;
        self.agreeLabBtn.hidden=NO;
    }

}

-(void)cellTapAction:(UITapGestureRecognizer*)tap
{
    for (int i=0; i<self.dataS.count; i++) {
        OrderStructM *model = self.dataS[i];
        if (i==tap.view.tag-1000) {
            model.isChoose=!model.isChoose;
        }
        else
        {
            model.isChoose=NO;
        }
        ScheduleWayPopCell *cell = [self viewWithTag:1000+i];
        [cell reloadUIWithOrderM:model];
    }
    
    OrderStructM *model = self.dataS[tap.view.tag-1000];
    if (tap.view.tag-1000==1&&model.isChoose==YES) {
        self.agreeBtn.hidden=NO;
        self.agreeLabBtn.hidden=NO;
    }
    else
    {
        self.agreeBtn.hidden=YES;
        self.agreeLabBtn.hidden=YES;
    }
}



//查看协议
-(void)lookAction
{
    [self confirmSelected];
    if (self.lookScheduleBlock) {
        self.lookScheduleBlock();
    }
}

@end

@interface ScheduleWayPopCell ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *priceLab;
@end

@implementation ScheduleWayPopCell

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
        _titleLab.font=[UIFont boldSystemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(15);
            make.top.mas_equalTo(self).offset(16);
        }];
    }
    return _titleLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        _descLab.numberOfLines=0;
        _descLab.font=[UIFont systemFontOfSize:11];
        _descLab.textColor=Public_DetailTextLabelColor;
        [self addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(15);
            make.right.mas_equalTo(self.bgV).offset(-15);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
        }];
    }
    return _descLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:18];
        _priceLab.textColor=Public_Text_Color;
        [self addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-15);
            make.centerY.mas_equalTo(self.titleLab);
        }];
    }
    return _priceLab;
}

-(void)reloadUIWithOrderM:(OrderStructM *)model
{
    [self bgV];
    self.titleLab.text=model.title;
    self.descLab.text=model.content;
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    if (model.type==1) {
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(16);
        }];
        self.priceLab.text = [NSString stringWithFormat:@"¥%@",model.price];
    }
    else
    {
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(23);
        }];
        self.priceLab.text = @"";

    }
    
    if (model.isChoose==NO) {
        self.bgV.backgroundColor=Public_Background_Color;
        self.bgV.layer.borderColor=Public_Background_Color.CGColor;
        self.titleLab.textColor=Public_Text_Color;
        self.descLab.textColor=Public_DetailTextLabelColor;
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

