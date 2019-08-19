//
//  MyOrderProjectCellB.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/9.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderProjectCellB.h"
#import "PlaceOrderModel.h"
#import "OrderModel.h"
#import "MyOrderFailureView.h"


@interface MyOrderProjectCellB ()
@property(nonatomic,strong)UILabel *titleLab;   //标题
@property(nonatomic,strong)UIImageView *icon;    //试镜拍摄图标
@property(nonatomic,strong)UILabel *stateLab;   //状态lab
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UILabel *desc1;      //定妆场地，
@property(nonatomic,strong)UILabel *desc2;      //拍摄日期
@property(nonatomic,strong)UIView *lineV1;
@property(nonatomic,strong)UIButton *rightBtn;  //右边按钮
@property(nonatomic,strong)UIButton *leftBtn;  //左边按钮
@property(nonatomic,strong)MyOrderFailureView *failView;  //失效原因

@end

@implementation MyOrderProjectCellB

-(id)init
{
    if (self=[super init]) {
        self.clipsToBounds=YES;
    }
    return self;
}
-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(20);
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.left.mas_equalTo(self.icon.mas_right).offset(3);
        }];
    }
    return _titleLab;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc]init];
        _stateLab.font=[UIFont systemFontOfSize:13];
        _stateLab.textColor=Public_Red_Color;
        [self.contentView addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(2);
        }];
    }
    return _stateLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:16];
        _priceLab.textColor=Public_Red_Color;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _priceLab;
}

-(UILabel*)desc1
{
    if (!_desc1) {
        _desc1=[[UILabel alloc]init];
        _desc1.font=[UIFont systemFontOfSize:13];
        _desc1.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_desc1];
        [_desc1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(45);
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
        [self.contentView addSubview:_desc2];
        [_desc2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.desc1.mas_bottom).offset(5);
        }];
    }
    return _desc2;
}

-(UIView*)lineV1
{
    if (!_lineV1) {
        _lineV1 = [[UIView alloc]init];
        _lineV1.backgroundColor=Public_LineGray_Color;
        [self addSubview:_lineV1];
        [_lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self.contentView).offset(100);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV1;
}

//右边按钮
-(UIButton*)rightBtn
{
    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_rightBtn];
        _rightBtn.layer.masksToBounds=YES;
        _rightBtn.layer.cornerRadius=3.0;
        _rightBtn.layer.borderColor=Public_Red_Color.CGColor;
        _rightBtn.layer.borderWidth=1;
        [_rightBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

//左边按钮
-(UIButton*)leftBtn
{
    if (!_leftBtn) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_leftBtn];
        _leftBtn.layer.masksToBounds=YES;
        _leftBtn.layer.cornerRadius=3.0;
        _leftBtn.layer.borderColor=Public_DetailTextLabelColor.CGColor;
        _leftBtn.layer.borderWidth=1;
        [_leftBtn setTitle:@"拒单" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
        _leftBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.mas_equalTo(self.rightBtn.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [_leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(MyOrderFailureView*)failView
{
    if (!_failView) {
        _failView=[[MyOrderFailureView alloc]init];
        [self.contentView addSubview:_failView];
        [_failView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(100);
            make.right.mas_equalTo(self.contentView).offset(0);
            make.left.mas_equalTo(self.contentView).offset(0);
            make.height.mas_equalTo(45);
        }];
    }
    return _failView;
}

-(void)reloadUIWithModel:(OrderProjectModel *)model
{
    self.icon.image=[UIImage imageNamed:model.type==1?@"order_audition":@"order_shot"];
    self.titleLab.text=model.name;
    
    //订单数据模型
    OrderModel *structmodel = [model.orderlist firstObject];
    
    self.stateLab.text=[NSString stringWithFormat:@"(%@)",[structmodel getOrderStateWihtOrderInfo:structmodel]];
    
    if (model.type==1) {  //试镜
        self.desc1.text = [NSString stringWithFormat:@"试镜方式：%@",[structmodel getAuditionWayWithType:structmodel.auditionType]];
        self.desc2.text = [NSString stringWithFormat:@"最晚上传作品日期：%@",model.auditionend];
        self.priceLab.text = [NSString stringWithFormat:@"¥%ld",[structmodel.profit integerValue]];
        
        if ([structmodel.orderstate isEqualToString:@"paied"]) {  //需要 接单，
            [self.rightBtn setTitle:@"接单" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"拒单" forState:UIControlStateNormal];
            self.lineV1.hidden=NO;
            self.rightBtn.hidden=NO;
            self.leftBtn.hidden=NO;
            
        }
        else if ([structmodel.orderstate isEqualToString:@"acceptted"]) //上传视频
        {
            if (structmodel.auditionType==3) {//手机试镜
                [self.rightBtn setTitle:@"在线试镜" forState:UIControlStateNormal];
                self.lineV1.hidden=NO;
                self.rightBtn.hidden=NO;
                self.leftBtn.hidden=NO;
                 [self.leftBtn setTitle:@"修改时间" forState:UIControlStateNormal];
             
            }else{//非手机试镜
            [self.rightBtn setTitle:@"上传视频" forState:UIControlStateNormal];
            self.lineV1.hidden=NO;
            self.rightBtn.hidden=NO;
            self.leftBtn.hidden=YES;
            }
        }
        else
        {
            self.lineV1.hidden=YES;
            self.rightBtn.hidden=YES;
            self.leftBtn.hidden=YES;
        }
    }
    else if (model.type==2)  //拍摄
    {
        self.desc1.text = [NSString stringWithFormat:@"定妆场地：%@",structmodel.shotordertype==1?@"自备场地":@"平面影棚"];
        self.desc2.text = [NSString stringWithFormat:@"拍摄日期：%@至%@",model.start,model.end];

        NSString *str = [NSString stringWithFormat:@"总价：¥%ld",[structmodel.totalprofit integerValue]];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0,3)];
        self.priceLab.attributedText=attStr;
        
        if ([structmodel.orderstate isEqualToString:@"new"]) {  //需要 确认档期，
            [self.rightBtn setTitle:@"确认档期" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"拒单" forState:UIControlStateNormal];
            self.lineV1.hidden=NO;
            self.rightBtn.hidden=NO;
            self.leftBtn.hidden=NO;
        }
        else
        {
            self.lineV1.hidden=YES;
            self.rightBtn.hidden=YES;
            self.leftBtn.hidden=YES;
        }
    }
    
    if (model.ordeState==OrderStateTypeFailure) {  //已失效
        self.lineV1.hidden=NO;
        [self.failView reloadUIWithState:structmodel.orderstate];
    }
    else
    {
        
    }
}

-(void)rightBtnAction:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"接单"]) {  //试镜
        if (self.delegate && [self.delegate respondsToSelector:@selector(acceptOrderWithIndexPath:)]) {
            [self.delegate acceptOrderWithIndexPath:self.indexPath];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"确认档期"])  //拍摄
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(confrimScheduleWithIndexPath:)]) {
            [self.delegate confrimScheduleWithIndexPath:self.indexPath];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"上传视频"])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(uploadVideoWithIndexPath:)]) {
            [self.delegate uploadVideoWithIndexPath:self.indexPath];
        }
    }
//    else if ([sender.titleLabel.text isEqualToString:@"在线试镜"])
//    {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(videoOnLineWithIndexPath:)]) {
//            [self.delegate videoOnLineWithIndexPath:self.indexPath];
//        }
//    }
    
}

-(void)leftBtnAction:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"上传视频"]){
    if (self.delegate && [self.delegate respondsToSelector:@selector(rejectOrderWithIndexPath:)]) {
        [self.delegate rejectOrderWithIndexPath:self.indexPath];
    }
    }else if ([sender.titleLabel.text isEqualToString:@"修改时间"]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(modifyAuditionTimeWithIndexPath:)]) {
            [self.delegate modifyAuditionTimeWithIndexPath:self.indexPath];
        }
    }
}

@end
