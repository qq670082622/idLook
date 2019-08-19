//
//  OrderDBottomV.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDBottomV.h"

@interface OrderDBottomV ()
@property(nonatomic,strong)UIButton *offerBtn;     //报价
@property(nonatomic,strong)UIButton *refusalBtn;     //拒单
@property(nonatomic,assign)OrderBottomActionType type;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@end

@implementation OrderDBottomV

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
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:13];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(20);
        }];
    }
    return _titleLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        [self addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:10];
        _descLab.textColor=Public_Red_Color;
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(2);
        }];
    }
    return _descLab;
}

-(UIButton*)offerBtn
{
    if (!_offerBtn) {
        _offerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_offerBtn];
        _offerBtn.layer.cornerRadius=3.0;
        _offerBtn.layer.masksToBounds=YES;
        _offerBtn.backgroundColor=Public_Red_Color;
        [_offerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _offerBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_offerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_offerBtn addTarget:self action:@selector(offerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _offerBtn;
}

-(UIButton*)refusalBtn
{
    if (!_refusalBtn) {
        _refusalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_refusalBtn];
        _refusalBtn.layer.cornerRadius=3.0;
        _refusalBtn.layer.masksToBounds=YES;
        _refusalBtn.layer.borderWidth=0.5;
        _refusalBtn.layer.borderColor=Public_DetailTextLabelColor.CGColor;
        [_refusalBtn setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
        _refusalBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_refusalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self.offerBtn.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_refusalBtn addTarget:self action:@selector(refusalAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refusalBtn;
}


-(void)reloadUIWithModel:(OrderModel *)model
{
//    for (UIView *view in self.subviews) {
//        [view removeFromSuperview];
//    }
    
    CGFloat bottomHeight = [self getBottomHeightWithOrderModel:model];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bottomHeight);
    }];
    
    NSString *orderState = model.orderstate;
    if ([UserInfoManager getUserType]==UserTypeResourcer) {  //资源方
        if (model.ordertype==OrderTypeAudition) {
            if ([orderState isEqualToString:@"paied"]) {   //有接单，拒单
                [self.refusalBtn setTitle:@"拒单" forState:UIControlStateNormal];
                [self.offerBtn setTitle:@"接单" forState:UIControlStateNormal];
            }
            else if ([orderState isEqualToString:@"acceptted"]) {   //上传视频
                [self.offerBtn setTitle:@"上传视频" forState:UIControlStateNormal];
            }
        }
        else if (model.ordertype==OrderTypeShot)
        {
            if ([orderState isEqualToString:@"new"]) {  //有确认档期,拒单
                [self.refusalBtn setTitle:@"拒单" forState:UIControlStateNormal];
                [self.offerBtn setTitle:@"确认档期" forState:UIControlStateNormal];
                NSInteger price= [model.totalprofit integerValue];
                NSString *str=[NSString stringWithFormat:@"待收款 ¥%ld",price];
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
                [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0]} range:NSMakeRange(3,str.length-3)];
                self.titleLab.attributedText=attStr;
            }
            else if ([orderState isEqualToString:@"acceptted"] ||[orderState isEqualToString:@"paiedone"] || [orderState isEqualToString:@"paiedtwo"] )
            {
                NSInteger price= [model.totalprofit integerValue];
                NSString *str=[NSString stringWithFormat:@"待收款 ¥%ld",price];
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
                [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0]} range:NSMakeRange(3,str.length-3)];
                self.titleLab.attributedText=attStr;
            }
            else if ([orderState isEqualToString:@"finished"])
            {
                NSInteger price= [model.totalprofit integerValue];
                NSString *str=[NSString stringWithFormat:@"已收款 ¥%ld",price];
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
                [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0]} range:NSMakeRange(3,str.length-3)];
                self.titleLab.attributedText=attStr;
            }
  
        }
    }
    else if ([UserInfoManager getUserType]==UserTypePurchaser)  //购买方
    {
        if (model.ordertype==OrderTypeAudition) {
            
        }
        else if (model.ordertype==OrderTypeShot)
        {
            if ([orderState isEqualToString:@"new"]|| [orderState isEqualToString:@"acceptted"]) {    //有首款价格
                NSInteger price= [model.ordertypeprice integerValue]+[model.bailprice integerValue];
                
                NSString *str=[NSString stringWithFormat:@"待支付首款 ¥%ld",price];
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
                [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0]} range:NSMakeRange(5,str.length-5)];
                self.titleLab.attributedText=attStr;
                if ([model.bailprice integerValue]==0) {
                    self.descLab.text = [NSString stringWithFormat:@"含定妆费￥%ld",[model.ordertypeprice integerValue]];
                }
                else
                {
                    self.descLab.text = [NSString stringWithFormat:@"含定妆费￥%ld和档期预约金￥%ld",[model.ordertypeprice integerValue],[model.bailprice integerValue]];
                }
                [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self).offset(13);
                }];
            }
            else if ([orderState isEqualToString:@"paiedone"])
            {
                NSInteger price= [model.totalprice integerValue] -[model.ordertypeprice integerValue]-[model.bailprice integerValue];
                NSString *str=[NSString stringWithFormat:@"待支付尾款 ¥%ld",price];
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
                [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0]} range:NSMakeRange(5,str.length-5)];
                self.titleLab.attributedText=attStr;
            }

        }
    }
 
}

//接单，付款，确认完成
-(void)offerAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(acceptOrderWithType:)]) {
        [self.delegate acceptOrderWithType:self.type];
    }
}

//拒单
-(void)refusalAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rejectOrder)]) {
        [self.delegate rejectOrder];
    }
}

//底部高度
-(CGFloat)getBottomHeightWithOrderModel:(OrderModel*)model
{
    CGFloat bottomHeight = 0;
    NSString *orderState = model.orderstate;
    if ([UserInfoManager getUserType]==UserTypeResourcer) {  //资源方
        if (model.ordertype==OrderTypeAudition) {
            if ([orderState isEqualToString:@"paied"]) {   //有接单，拒单
                bottomHeight=SafeAreaTabBarHeight_IphoneX+60;
                self.type=OrderBottomActionTypeAccept;
                
                self.refusalBtn.hidden=NO;
                self.offerBtn.hidden=NO;
                self.titleLab.hidden=YES;
                self.descLab.hidden=YES;
            }
            else if ([orderState isEqualToString:@"acceptted"]) {   //上传视频
                bottomHeight=SafeAreaTabBarHeight_IphoneX+60;
                self.type=OrderBottomActionTypeUploadVide;
                
                self.refusalBtn.hidden=YES;
                self.offerBtn.hidden=NO;
                self.titleLab.hidden=YES;
                self.descLab.hidden=YES;
            }
            else
            {
                self.refusalBtn.hidden=YES;
                self.offerBtn.hidden=YES;
                self.titleLab.hidden=YES;
                self.descLab.hidden=YES;
            }
        }
        else if (model.ordertype==OrderTypeShot)
        {
            if ([orderState isEqualToString:@"new"]) {  //有确认档期
                bottomHeight=SafeAreaTabBarHeight_IphoneX+60;
                self.type=OrderBottomActionTypeAccept;
                self.refusalBtn.hidden=NO;
                self.offerBtn.hidden=NO;
                self.titleLab.hidden=NO;
                self.descLab.hidden=YES;
            }
            else if ([orderState isEqualToString:@"acceptted"] ||[orderState isEqualToString:@"paiedone"] || [orderState isEqualToString:@"paiedtwo"] ||[orderState isEqualToString:@"finished"])
            {
                bottomHeight=SafeAreaTabBarHeight_IphoneX+60;
                self.refusalBtn.hidden=YES;
                self.offerBtn.hidden=YES;
                self.titleLab.hidden=NO;
                self.descLab.hidden=YES;
            }
            else
            {
                self.refusalBtn.hidden=YES;
                self.offerBtn.hidden=YES;
                self.titleLab.hidden=YES;
                self.descLab.hidden=YES;
            }
        }
    }
    else if ([UserInfoManager getUserType]==UserTypePurchaser)  //购买方
    {
        if (model.ordertype==OrderTypeAudition) {
            self.refusalBtn.hidden=YES;
            self.offerBtn.hidden=YES;
            self.titleLab.hidden=YES;
            self.descLab.hidden=YES;
        }
        else if (model.ordertype==OrderTypeShot)
        {
            if ([orderState isEqualToString:@"new"]|| [orderState isEqualToString:@"acceptted"] ||[orderState isEqualToString:@"paiedone"]) {    //有首款价格
                bottomHeight=SafeAreaTabBarHeight_IphoneX+60;
                self.refusalBtn.hidden=YES;
                self.offerBtn.hidden=YES;
                self.titleLab.hidden=NO;
                self.descLab.hidden=NO;
            }
            else
            {
                self.refusalBtn.hidden=YES;
                self.offerBtn.hidden=YES;
                self.titleLab.hidden=YES;
                self.descLab.hidden=YES;
            }
        }
    }
    return bottomHeight;
}

@end
