//
//  MyOrderProjectCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderProjectCellA.h"
#import "MyOrderCustomView.h"
#import "MyOrderHeadView.h"
#import "MyOrderFailureView.h"
#import "MyOrderServiceView.h"
#import "MyOrderTotalPriceView.h"

@interface MyOrderProjectCellA ()
@property(nonatomic,strong)MyOrderHeadView *headView;
@property(nonatomic,strong)UIView *artistView;   //艺人view
@property(nonatomic,strong)MyOrderServiceView *serviceView;  //服务费一栏
@property(nonatomic,strong)MyOrderTotalPriceView *totalPriceView;  //合计费一栏
@property(nonatomic,strong)OrderProjectModel *projectModel;
@end

@implementation MyOrderProjectCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.clipsToBounds=YES;
    }
    return self;
}

-(MyOrderHeadView*)headView
{
    if (!_headView) {
        _headView=[[MyOrderHeadView alloc]init];
        [self.contentView addSubview:_headView];
        _headView.userInteractionEnabled=YES;
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(45);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookProject)];
        [_headView addGestureRecognizer:tap];
        WeakSelf(self);
        _headView.HeadclickOrderBlock = ^(BOOL select) {
            [weakself selectAllProjectWithSelect:select];
        };
    }
    return _headView;
}

-(UIView*)artistView
{
    if (!_artistView) {
        _artistView=[[UIView alloc]init];
        _artistView.userInteractionEnabled=YES;
        [self.contentView addSubview:_artistView];
        [_artistView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(45);
            make.height.mas_equalTo(90);
        }];
    }
    return _artistView;
}

-(MyOrderServiceView*)serviceView
{
    if (!_serviceView) {
        _serviceView=[[MyOrderServiceView alloc]init];
        [self.contentView addSubview:_serviceView];
        [_serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.artistView.mas_bottom);
            make.height.mas_equalTo(45);
        }];
    }
    return _serviceView;
}

-(MyOrderTotalPriceView*)totalPriceView
{
    if (!_totalPriceView) {
        _totalPriceView=[[MyOrderTotalPriceView alloc]init];
        [self.contentView addSubview:_totalPriceView];
        [_totalPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(45);
        }];
        WeakSelf(self);
        _totalPriceView.delectOrderBlock = ^{

        };
        _totalPriceView.evaluateOrderBlock = ^{
            if (weakself.delegate &&[weakself.delegate respondsToSelector:@selector(evaluateOrderWithIndexPath:)]) {
                [weakself.delegate evaluateOrderWithIndexPath:weakself.indexPath];
            }
        };
        _totalPriceView.applyforInvoiceBlock = ^{
            if (weakself.delegate &&[weakself.delegate respondsToSelector:@selector(applyforinvoiceWithIndexPath:)]) {
                [weakself.delegate applyforinvoiceWithIndexPath:weakself.indexPath];
            }
        };
    }
    return _totalPriceView;
}

-(void)reloadUIWithModel:(OrderProjectModel *)model
{
    self.projectModel=model;
    [self.headView reloadUIWithModel:model];
    
    for (UIView *view in self.artistView.subviews) {
        [view removeFromSuperview];
    }
    
    
    //项目总价
    NSInteger totalPrice =0;
    
    //艺人高度
    CGFloat artistHeight = 0;
    for (int i=0; i<model.orderlist.count; i++) {
        OrderModel *orderModel = model.orderlist[i];

        CGFloat height = 90;
        if (model.ordeState==OrderStateTypeConfirm || model.ordeState==OrderStateTypeFailure) {  //待确认 高度90+45 有取消订单一栏高度45
            if (orderModel.ordertype==OrderTypeAudition&&[orderModel.orderstate isEqualToString:@"paied"]) {  //试镜订单已支付 ，不能取消
                height=90;
            }
            else
            {
                height=135;
            }
        }
        else if (model.ordeState==OrderStateTypeGoing)
        {
            if (orderModel.ordertype==OrderTypeAudition&&[orderModel.orderstate isEqualToString:@"videouploaded"]) { //试镜订单,有确认完成按钮
                height=135;
            }
            else if (orderModel.ordertype==OrderTypeShot&&[orderModel.orderstate isEqualToString:@"paiedtwo"])  //拍摄订单,有确认完成按钮
            {
                height=135;
            }
        }
        
        MyOrderCustomView *view = [[MyOrderCustomView alloc]init];
        view.tag=1000+i;
        [self.artistView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(45+artistHeight);
            make.height.mas_equalTo(height);
        }];
        [view reloadUIWithProjectModel:model withOrderModel:orderModel];
        WeakSelf(self);
        view.MyOrderCustomViewlookOrderDetialBlock = ^{  //查看订单详情
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(lookOrderDetialWithIndexPath:withTag:)]) {
                [weakself.delegate lookOrderDetialWithIndexPath:self.indexPath withTag:i];
            }
        };
        view.CancleOrderBlock = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(cancleOrderWithIndexPath:withTag:)]) {
                [weakself.delegate cancleOrderWithIndexPath:self.indexPath withTag:i];
            }
        };
        view.finishedOrderBlock = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(confrimFinishOrderWithIndexPath:withTag:)]) {
                [weakself.delegate confrimFinishOrderWithIndexPath:self.indexPath withTag:i];
            }
        };
        view.clickOrderBlock = ^(BOOL select) {
            [weakself selectOneOrderWithTag:i withSelect:select];
        };
        view.confrimSchedBlock = ^{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(confrimSchedAgainOrderWithIndexPath:withTag:)]) {
                [weakself.delegate confrimSchedAgainOrderWithIndexPath:self.indexPath withTag:i];
            }
        };
        artistHeight+=height;
        
        if (model.type==1) { //试镜
            totalPrice = totalPrice + [orderModel.price integerValue];
        }
        else if (model.type==2)  //拍摄
        {
            totalPrice = totalPrice + [orderModel.totalprice integerValue];
        }
    }
    
    [self.artistView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(artistHeight);
    }];
    
    [self.serviceView reloadUIWithModel:model];
    if (model.type==2 &&( model.ordeState!=OrderStateTypeFailure)) {//拍摄项目，有服务费一栏
        self.serviceView.hidden=NO;
        totalPrice=totalPrice+400*model.auditiondays;
    }
    else
    {
        self.serviceView.hidden=YES;
    }
#warning   此处model暂时一直为1
//    model.isevaluate = 1;
    [self.totalPriceView reloadUIWithTotalPrice:totalPrice withProjectModel:model];
    if (model.ordeState==OrderStateTypeFinished||model.ordeState==OrderStateTypeFailure) {//完成，失效订单，有合计一栏
        self.totalPriceView.hidden=NO;
    }
    else
    {
        self.totalPriceView.hidden=YES;
    }
}

//查看项目
-(void)lookProject
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lookProjectWithIndexPath:)]) {
        [self.delegate lookProjectWithIndexPath:self.indexPath];
    }
}

//选中整个项目
-(void)selectAllProjectWithSelect:(BOOL)select
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectAllProjectOrderWithIndexPath:withSelect:)]) {
        [self.delegate selectAllProjectOrderWithIndexPath:self.indexPath withSelect:select];
    }
}

//选中一个订单
-(void)selectOneOrderWithTag:(NSInteger)tag withSelect:(BOOL)select
{
    OrderModel *model = self.projectModel.orderlist[tag];
    model.isChoose = select;
    BOOL isAll = YES;
    //是否有未选中的
    for (int i=0; i<self.projectModel.orderlist.count; i++) {
        OrderModel *modelA = self.projectModel.orderlist[i];
        if (modelA.isChoose==NO) {
            isAll=NO;
        }
    }
    self.projectModel.isChoose=isAll;
    [self reloadUIWithModel:self.projectModel];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectOneOrderWithIndexPath:withTag:withSelect:)]) {
        [self.delegate selectOneOrderWithIndexPath:self.indexPath withTag:tag withSelect:select];
    }
}

@end
