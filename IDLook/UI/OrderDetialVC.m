//
//  OrderDetialVCViewController.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialVC.h"
#import "OrderDBottomV.h"
#import "OrderDetialVCM.h"
#import "OrderDetialCellA.h"
#import "OrderDetialCellB.h"
#import "OrderDetialCellC.h"
#import "OrderDetialCellD.h"
#import "OrderDetialCellE.h"
#import "OrderDetialCellF.h"
#import "OrderDetialCellG.h"
#import "OrderDetialCellH.h"
#import "OrderDetialCellM.h"
#import "OrderDetialCellN.h"
#import "OrderDetialCellO.h"
#import "OrderProgressVC.h"
#import "PlayVideoPopV.h"
#import "AcceptOrderPopV.h"
#import "RejectOrderPopV.h"
#import "PayWaysVC.h"
#import "DownLoadmanager.h"
#import "PriceModel.h"
#import "PublicWebVC.h"
#import "PlaceShotOrderVC.h"
#import "PlaceAuditionOrderVC.h"
#import "AuthPopV.h"
#import "AuthResourcerVC.h"
#import "MyAuthStateVC.h"
#import "OrderDetialScriptVC.h"
#import "VideoPlayer.h"
#import "ScriptPrivaryPopV.h"

@interface OrderDetialVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,OrderDBottomDelegate>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)OrderDBottomV *bottomV;
@property(nonatomic,strong)OrderDetialVCM *dsm;
@end

@implementation OrderDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"订单详情"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.dsm refreshOrderInfoWithOrderModel:self.orderModel withProjM:self.projectModel];
    
//    [self.bottomV reloadUIWithModel:self.orderModel];
    
    [self tableV];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_player destroyPlayer];
    _player = nil;
}

-(void)onGoback
{
    if (self.isRefreshData) {
        self.isRefreshData();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(OrderDetialVCM*)dsm
{
    if (!_dsm) {
        _dsm=[[OrderDetialVCM alloc]init];
        WeakSelf(self);
        _dsm.newDataNeedRefreshed = ^{
            [weakself.tableV reloadData];
            [weakself.bottomV reloadUIWithModel:weakself.dsm.model];
            [weakself.tableV headerEndRefreshing];
        };
    }
    return _dsm;
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=YES;
        _tableV.showsHorizontalScrollIndicator=YES;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.bottomV.mas_top).offset(0);
            make.top.mas_equalTo(self.view);
        }];
        [_tableV addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
    }
    return _tableV;
}


-(OrderDBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[OrderDBottomV alloc]init];
        [self.view addSubview:_bottomV];
        _bottomV.clipsToBounds=YES;
        _bottomV.delegate=self;
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(0);
            make.height.mas_equalTo(0);
        }];
    }
    return _bottomV;
}

-(void)pullDownToRefresh:(id)sender
{
    [self.dsm refreshOrderInfoWithOrderModel:self.orderModel withProjM:self.projectModel];
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dsm.ds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dsm.ds[section]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dsm.ds[indexPath.section][indexPath.row] objectForKey:kOrderDetialVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellClass];
    
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    
    if ([classStr isEqualToString:@"OrderDetialCellA"]) {
        OrderModel *model = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellData];
        OrderDetialCellA *cell = (OrderDetialCellA *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithModel:model];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellB"])
    {
        OrderModel *model = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellData];
        OrderDetialCellB *cell = (OrderDetialCellB *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithModel:model];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellC"])
    {
        OrderDetialCellC *cell = (OrderDetialCellC *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellData];
        [cell reloadUIWithArray:array];
        WeakSelf(self);
        cell.LookScreenmirror = ^{
            [weakself LookScreenmirrors];
        };
        
        cell.downScreenmirrorBlock = ^{
            SourceType type = [PublicManager getSourceTypeWithUrl:weakself.orderModel.creativeurl];
            DownLoadmanager *manager = [[DownLoadmanager alloc]init];
            if (type==SourceTypePhoto) {
                [manager downloadWithUrl:weakself.dsm.model.creativeurl withType:DownloadTypePhoto];
            }
            else
            {
                [manager downloadWithUrl:weakself.dsm.model.creativeurl withType:DownloadTypeVideo];
            }
        };
    }
    else if ([classStr isEqualToString:@"OrderDetialCellD"])
    {
        OrderDetialCellD *cell = (OrderDetialCellD *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *price = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellData];
        [cell reloadUIWithPrice:price];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellE"])
    {
        OrderDetialCellE *cell = (OrderDetialCellE *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellData];
        [cell reloadUIWithArray:array];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellF"])
    {
        OrderDetialCellF *cell = (OrderDetialCellF *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUI];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellG"])
    {
        OrderDetialCellG *cell = (OrderDetialCellG *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithOrderModel:self.dsm.model];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellH"])
    {
        OrderDetialCellH *cell = (OrderDetialCellH *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithType:self.orderModel.ordertype];
        WeakSelf(self);
        cell.LookAuditionVideo = ^{
            if (self.orderModel.ordertype==OrderTypeAudition) {
                [_player destroyPlayer];
                _player = nil;
                _player = [[VideoPlayer alloc] init];
                _player.videoUrl =weakself.dsm.model.ordermsg;
                _player.onlyFullScreen=YES;
                
                _player.completedPlayingBlock = ^(VideoPlayer *player) {
                    [player destroyPlayer];
                    _player = nil;
                };
                _player.dowmLoadBlock = ^{};
            }
            else
            {
                NSArray *array = @[self.dsm.model.ordermsg];
                LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
                lookImage.isShowDown=YES;
                [lookImage showWithImageArray:array curImgIndex:0 AbsRect:CGRectMake(15, 25,UI_SCREEN_WIDTH-30, (UI_SCREEN_WIDTH-30)*(486.0/690.0))];
                [self.navigationController pushViewController:lookImage animated:YES];
                lookImage.downPhotoBlock = ^(NSInteger index) {};
            }
        };
        
        cell.downVideo = ^{
            DownLoadmanager *manager = [[DownLoadmanager alloc]init];

            if (self.orderModel.ordertype==OrderTypeAudition) {
                 [manager downloadWithUrl:weakself.dsm.model.ordermsg withType:DownloadTypeVideo];
            }
            else
            {
                [manager downloadWithUrl:weakself.dsm.model.ordermsg withType:DownloadTypeVideo];
            }
        };
    }
    else if ([classStr isEqualToString:@"OrderDetialCellM"])
    {
        OrderDetialCellM *cell = (OrderDetialCellM *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUI];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellN"])
    {
        OrderDetialCellN *cell = (OrderDetialCellN *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUI];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellO"])
    {
        NSString *desc = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellData];
        OrderDetialCellO *cell = (OrderDetialCellO *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadUIWithDesc:desc];
    }
    return obj;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dsm.ds[sec][row] objectForKey:kOrderDetialVCMCellClass];
    if ([classStr isEqualToString:@"OrderDetialCellA"])
    {

    }
    else if ([classStr isEqualToString:@"OrderDetialCellM"])
    {
        //http://www.idlook.com/public/protocol/html/index.html?num_id=   正式
        //http://www.pre.idlook.com/public/protocol/html/index.html?num_id=  测试
        PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"保单详情" url:[NSString stringWithFormat:@"http://www.idlook.com/public/protocol/html/index.html?num_id=%@",self.dsm.model.policynum]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if ([classStr isEqualToString:@"OrderDetialCellN"])  //查看脚本
    {
        OrderDetialScriptVC *scriptVC = [[OrderDetialScriptVC alloc]init];
        scriptVC.projectModel=self.projectModel;
        [self.navigationController pushViewController:scriptVC animated:YES];
    }
}

//查看画面分镜
-(void)LookScreenmirrors
{
    
    SourceType type = [PublicManager getSourceTypeWithUrl:self.orderModel.creativeurl];
    
    if (type==SourceTypePhoto) {
        NSArray *array = @[self.dsm.model.creativeurl];
        LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
        lookImage.isShowDown=YES;
        lookImage.downPhotoBlock = ^(NSInteger index) {};
        [lookImage showWithImageArray:array curImgIndex:0 AbsRect:CGRectMake(15, 25,UI_SCREEN_WIDTH-30, (UI_SCREEN_WIDTH-30)*(486.0/690.0))];
        [self.navigationController pushViewController:lookImage animated:YES];
    }
    else if (type==SourceTypeVideo)
    {
//        PlayVideoPopV *playVC=[[PlayVideoPopV alloc]init];
//        playVC.videoUrl=self.dsm.model.creativeurl;
//        [playVC show];
        

    }
}

#pragma mark--
#pragma mark-----OrderDBottomDelegate
-(void)rejectOrder  //拒单，拒绝报价
{
    RejectOrderPopV *popV=[[RejectOrderPopV alloc]init];
    [popV showWithOrderType:self.orderModel.ordertype];
    WeakSelf(self);
    popV.rejectWithReason = ^(NSString *reason) {
        [weakself rejectWithReason:reason];
    };
}

-(void)rejectWithReason:(NSString*)reason
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *dicArg=@{@"orderid":self.orderModel.orderId,
                           @"msg":reason,
                           @"userid":[UserInfoManager getUserUID]};
    NSString *service ;
    if (self.dsm.model.ordertype==OrderTypeShot) {
        service=@"Order.proReject";
    }
    else if (self.dsm.model.ordertype==OrderTypeAudition)
    {
        service=@"order.reject";
    }

    [AFWebAPI getRejectOrder:dicArg withSerivce:service callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"订单已拒绝"];
            [self.dsm refreshOrderInfoWithOrderModel:self.dsm.model withProjM:self.projectModel];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

-(void)acceptOrderWithType:(OrderBottomActionType)type
{
    if (type==OrderBottomActionTypeAccept) {     //接单
        [self acceltOrderAction];
    }
    else if (type==OrderBottomActionTypeUploadVide)    //上传视频
    {
        [self uploadVideo];
    }
}

//上传视频/图片
- (void)uploadVideo
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    
    picker.mediaTypes = [NSArray arrayWithObject:availableMedia[1]]; //设置媒体类型为public.image
    
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.movie"]) {
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *file = [NSData dataWithContentsOfURL:url];
        [SVProgressHUD showWithStatus:@"正在上传视频" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicArg=@{@"orderid":self.dsm.model.orderId,
                               @"userid":self.dsm.model.actorid};
        [AFWebAPI uploadVideoAuditionOrder:dicArg data:file callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"视频已上传！"];
                [self.dsm refreshOrderInfoWithOrderModel:self.dsm.model withProjM:self.projectModel];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    else if ([type isEqualToString:@"public.image"]) {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [SVProgressHUD showWithStatus:@"正在上传授权书" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicArg=@{@"orderid":self.dsm.model.orderId,
                               @"userid":self.dsm.model.actorid};
        [AFWebAPI uploadShotOrderCertificationWithArg:dicArg data:UIImageJPEGRepresentation(image, 1.0) callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"授权书已上传"];
                [self.dsm refreshOrderInfoWithOrderModel:self.dsm.model withProjM:self.projectModel];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

//接单
-(void)acceltOrderAction
{
    if ([UserInfoManager getUserAuthState]!=1) {
        AuthPopV *popV = [[AuthPopV alloc]init];
        [popV show];
        popV.goAuthBlock = ^{
            if ([UserInfoManager getUserAuthState]==0) {
                AuthResourcerVC *authVC=[[AuthResourcerVC alloc]init];
                [self.navigationController pushViewController:authVC animated:YES];
            }
            else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
            {
                MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
                stateVC.authState=[UserInfoManager getUserAuthState];
                [self.navigationController pushViewController:stateVC animated:YES];
            }
        };
        return;
    }
    
    ScriptPrivaryPopV *scriptPopV = [[ScriptPrivaryPopV alloc]init];
    [scriptPopV show];
    scriptPopV.confrimOrder = ^{
        if (self.dsm.model.payterms==1 && self.dsm.model.ordertype==OrderTypeShot) {
            AcceptOrderPopV *popV = [[AcceptOrderPopV alloc]init];
            [popV show];
            popV.acceptOrder = ^{
                [self acceptOrder];
            };
        }
        else
        {
            [self acceptOrder];
        }
    };
}

#pragma mark-----Action
-(void)acceptOrder
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *dicArg=@{@"orderid":self.dsm.model.orderId,
                           @"userid":[UserInfoManager getUserUID]};
    NSString *service ;
    if (self.dsm.model.ordertype==OrderTypeShot) {
        service=@"Order.proAccept";
    }
    else if (self.dsm.model.ordertype==OrderTypeAudition)
    {
        service=@"order.accept";
    }
    [AFWebAPI getAcceptOrder:dicArg withSerivce:service callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self.dsm refreshOrderInfoWithOrderModel:self.dsm.model withProjM:self.projectModel];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

@end
