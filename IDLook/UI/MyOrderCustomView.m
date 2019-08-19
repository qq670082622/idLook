//
//  MyOrderCustomView.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderCustomView.h"
#import "PlaceOrderModel.h"
#import "MyOrderFailureView.h"

@interface MyOrderCustomView ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *nameLab;   //名字
@property(nonatomic,strong)UILabel *stateLab;   //状态lab
@property(nonatomic,strong)UILabel *desc1;      //
@property(nonatomic,strong)UILabel *desc2;      //
@property(nonatomic,strong)UIImageView *icon;    //头像
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UIButton *selectBtn;  //选择按钮
@property(nonatomic,strong)UIView *lineV1;    //
@property(nonatomic,strong)UIButton *cancleBtn;  //取消订单
@property(nonatomic,strong)UIButton *finsihBtn;  //确认完成按钮
@property(nonatomic,strong)UIButton *confrimBtn;  //再次确认档期
@property(nonatomic,strong)UIView *lineV2;    //
@property(nonatomic,strong)MyOrderFailureView *failView;  //失效原因
@end

@implementation MyOrderCustomView

-(id)init
{
    if (self=[super init]) {
        self.clipsToBounds=YES;
    }
    return self;
}

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_selectBtn];
        [_selectBtn setImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        [_selectBtn setImage:[UIImage imageNamed:@"work_disable"] forState:UIControlStateDisabled];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.left.mas_equalTo(self).offset(0);
            make.size.mas_equalTo(CGSizeMake(46, 80));
        }];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [self addSubview:_bgV];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(90);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookOrderDetial)];
        [_bgV addGestureRecognizer:tap];
    }
    return _bgV;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds=YES;
        [self.bgV addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    }
    return _icon;
}

-(UILabel*)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:16];
        _nameLab.textColor=Public_Text_Color;
        [self.bgV addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(13);
            make.left.mas_equalTo(self.icon.mas_right).offset(12);
        }];
    }
    return _nameLab;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc]init];
        _stateLab.font=[UIFont systemFontOfSize:13];
        _stateLab.textColor=Public_Red_Color;
        [self.bgV addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.left.mas_equalTo(self.nameLab.mas_right).offset(2);
        }];
    }
    return _stateLab;
}

-(UILabel*)desc1
{
    if (!_desc1) {
        _desc1=[[UILabel alloc]init];
        _desc1.font=[UIFont systemFontOfSize:13];
        _desc1.textColor=Public_DetailTextLabelColor;
        [self.bgV addSubview:_desc1];
        [_desc1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLab);
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(5);
        }];
    }
    return _desc1;
}

-(UILabel*)desc2
{
    if (!_desc2) {
        _desc2=[[UILabel alloc]init];
        _desc2.font=[UIFont systemFontOfSize:13];
        _desc2.textColor=Public_DetailTextLabelColor;
        [self.bgV addSubview:_desc2];
        [_desc2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLab);
            make.top.mas_equalTo(self.desc1.mas_bottom).offset(5);
        }];
    }
    return _desc2;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont systemFontOfSize:16];
        _priceLab.textColor=Public_Red_Color;
        [self.bgV addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self).offset(-15);
        }];
    }
    return _priceLab;
}

-(UIView*)lineV1
{
    if (!_lineV1) {
        _lineV1 = [[UIView alloc]init];
        _lineV1.backgroundColor=Public_LineGray_Color;
        [self.bgV addSubview:_lineV1];
        [_lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(89.5);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV1;
}

-(UIButton*)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_cancleBtn];
        _cancleBtn.layer.masksToBounds=YES;
        _cancleBtn.layer.cornerRadius=3.0;
        _cancleBtn.layer.borderColor=Public_DetailTextLabelColor.CGColor;
        _cancleBtn.layer.borderWidth=1;
        [_cancleBtn setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
        [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(97);
            make.right.mas_equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}


-(UIButton*)finsihBtn
{
    if (!_finsihBtn) {
        _finsihBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_finsihBtn];
        _finsihBtn.layer.masksToBounds=YES;
        _finsihBtn.layer.cornerRadius=3.0;
        _finsihBtn.layer.borderColor=Public_Red_Color.CGColor;
        _finsihBtn.layer.borderWidth=1;
        [_finsihBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        [_finsihBtn setTitle:@"确认完成" forState:UIControlStateNormal];
        _finsihBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_finsihBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(97);
            make.right.mas_equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_finsihBtn addTarget:self action:@selector(finishOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finsihBtn;
}

-(UIButton*)confrimBtn
{
    if (!_confrimBtn) {
        _confrimBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_confrimBtn];
        _confrimBtn.layer.masksToBounds=YES;
        _confrimBtn.layer.cornerRadius=3.0;
        _confrimBtn.layer.borderColor=Public_Red_Color.CGColor;
        _confrimBtn.layer.borderWidth=1;
        [_confrimBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        [_confrimBtn setTitle:@"再次确认档期" forState:UIControlStateNormal];
        _confrimBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(97);
            make.right.mas_equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(106, 30));
        }];
        [_confrimBtn addTarget:self action:@selector(confrimBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confrimBtn;
}

-(MyOrderFailureView*)failView
{
    if (!_failView) {
        _failView=[[MyOrderFailureView alloc]init];
        [self addSubview:_failView];
        [_failView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(90);
            make.right.mas_equalTo(self).offset(0);
            make.left.mas_equalTo(self).offset(0);
            make.height.mas_equalTo(45);
        }];
    }
    return _failView;
}

-(UIView*)lineV2
{
    if (!_lineV2) {
        _lineV2 = [[UIView alloc]init];
        _lineV2.backgroundColor=Public_LineGray_Color;
        [self addSubview:_lineV2];
        [_lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(90+44.5);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV2;
}

-(void)reloadUIWithProjectModel:(OrderProjectModel *)projectMdeol withOrderModel:(OrderModel *)orderModel
{
    [self.icon sd_setImageWithUrlStr:orderModel.actorHead placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.nameLab.text= orderModel.actorNick;
    [self lineV1];
    
    self.stateLab.text=[NSString stringWithFormat:@"(%@)",[orderModel getOrderStateWihtOrderInfo:orderModel]];
    
    if (projectMdeol.type==1) {  //试镜
        self.desc1.text = [NSString stringWithFormat:@"试镜方式：%@",[orderModel getAuditionWayWithType:orderModel.auditionType]];
        self.desc2.text = [NSString stringWithFormat:@"最晚上传作品日期：%@",projectMdeol.auditionend];
        self.priceLab.text = [NSString stringWithFormat:@"¥%ld",[orderModel.price integerValue]];
    }
    else if (projectMdeol.type==2)  //拍摄
    {
        self.desc1.text = [NSString stringWithFormat:@"定妆场地：%@",orderModel.shotordertype==1?@"自备场地":@"平面影棚"];
        self.desc2.text = [NSString stringWithFormat:@"拍摄日期：%@至%@",projectMdeol.start,projectMdeol.end];

        NSInteger price = 0;
        NSString *priceDesc = @"";
        if (projectMdeol.ordeState==1) {  //首款  定妆费+档期预约金
            price = [orderModel.ordertypeprice integerValue]+[orderModel.bailprice integerValue];
            priceDesc=@"首款：";
        }
        else if (projectMdeol.ordeState==2) //尾款  总价-定妆费-档期预约金
        {
            price = [orderModel.totalprice integerValue]- [orderModel.ordertypeprice integerValue]-[orderModel.bailprice integerValue];
            priceDesc=@"尾款：";
        }
        else
        {
            price = [orderModel.totalprice integerValue];
            priceDesc=@"总价：";
        }
        
        NSString *str = [NSString stringWithFormat:@"%@¥%ld",priceDesc,price];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0,priceDesc.length)];
        self.priceLab.attributedText=attStr;
        
    }
    [self lineV2];
    
    if (projectMdeol.ordeState==1) { //进行中,有取消按钮
        self.cancleBtn.hidden=NO;
        
        if (projectMdeol.type==2&&[orderModel.orderstate isEqualToString:@"acceptted"]) {  //拍摄订单，演员接单后，购买方可以再次确认档期
            [self.cancleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).offset(-130);
            }];
            self.confrimBtn.hidden=NO;
        }
        else
        {
            [self.cancleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).offset(-15);
            }];
            self.confrimBtn.hidden=YES;
        }
    }
    else if(projectMdeol.ordeState==OrderStateTypeFailure)
    {
        [self.failView reloadUIWithState:orderModel.orderstate];
    }
    
#pragma 选择按钮处理
    self.selectBtn.selected=orderModel.isChoose;
    BOOL isShowSelect=NO;  //是否显示选择按钮
    if (projectMdeol.ordeState!=OrderStateTypeAll&& projectMdeol.type==1) {  //试镜
        if ([orderModel.orderstate isEqualToString:@"new"]) {  //付款勾选按钮
            isShowSelect=YES;
        }
        else
        {
            isShowSelect=NO;
        }
    }
    else if (projectMdeol.ordeState!=OrderStateTypeAll&& projectMdeol.type==2)
    {
          if ([orderModel.orderstate isEqualToString:@"acceptted"] || [orderModel.orderstate isEqualToString:@"paiedone"]) {  //付款勾选按钮
              isShowSelect=YES;
          }
          else
          {
              isShowSelect=NO;
          }
    }

    if (isShowSelect==YES) {
        self.selectBtn.hidden=NO;
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(46);
        }];
    }
    else
    {
        self.selectBtn.hidden=YES;
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
        }];
    }
    
#pragma 确认完成按钮处理
    if (projectMdeol.ordeState==OrderStateTypeGoing) {
        if (orderModel.ordertype==OrderTypeAudition&&[orderModel.orderstate isEqualToString:@"videouploaded"]) {
            self.finsihBtn.hidden=NO;
        }
        else if (orderModel.ordertype==OrderTypeShot&&[orderModel.orderstate isEqualToString:@"paiedtwo"])
        {
            self.finsihBtn.hidden=NO;
        }
    }

}

//选中订单
-(void)selectAction:(UIButton*)sender
{
    if (self.clickOrderBlock) {
        self.clickOrderBlock(!sender.selected);
    }
}

//取消订单
-(void)cancleBtnAction:(UIButton*)sender
{
    if (self.CancleOrderBlock) {
        self.CancleOrderBlock();
    }
}

//查看订单详情
-(void)lookOrderDetial
{
    if (self.MyOrderCustomViewlookOrderDetialBlock) {
        self.MyOrderCustomViewlookOrderDetialBlock();
    }
}

//确认完成
-(void)finishOrder:(UIButton*)sender
{
    if (self.finishedOrderBlock) {
        self.finishedOrderBlock();
    }
}

//确认档期
-(void)confrimBtnAction:(UIButton*)sender
{
    if (self.confrimSchedBlock) {
        self.confrimSchedBlock();
    }
}

@end
