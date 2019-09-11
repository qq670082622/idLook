//
//  MyOrderMainVC+Action.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "MyOrderMainVC+Action.h"
#import "RejectOrderPopV.h"
#import "AuthPopV.h"
#import "AuthResourcerVC.h"
#import "ScriptPrivaryPopV.h"
#import "AcceptOrderPopV.h"
#import "OrderSchedulePopV.h"
#import "OrderBargainPopV.h"
#import "LookAnnunciatePopV.h"
#import "QNTestVC.h"
#import "PublicWebVC.h"
@implementation MyOrderMainVC (Action)

#pragma mark --button action
//底部按钮事件
-(void)BottomButtonAction:(NSInteger)type withProjectInfo:(ProjectOrderInfoM*)info
{
    WeakSelf(self);
    if (type==OrderBtnTypeConfrimSchedule) {  //确认档期
        NSInteger negoPriceState = [(NSNumber*)safeObjectForKey(info.askScheduleInfo, @"negoPriceState") integerValue];
        
        NSArray *latestPhotoList = (NSArray*)safeObjectForKey(info.askScheduleInfo, @"latestPhotoList");
        BOOL latestPhoto = [(NSNumber*)safeObjectForKey(info.askScheduleInfo, @"latestPhoto")boolValue];
        if (latestPhoto==YES && latestPhotoList.count==0) {  //需要上传照片
            OrderSchedulePopV *popV = [[OrderSchedulePopV alloc]init];
            [popV showPopVWithType:2];
            popV.confrimBlock = ^{
                [weakself uploadVideoOrPhotoActionWithInfo:info withType:2 withMaxCount:9];
            };
        }
        else
        {
            if (negoPriceState==1) {  //议价中
                OrderBargainPopV *popV = [[OrderBargainPopV alloc]init];
                [popV showPopVWithInfo:info];
                popV.bargainBlock = ^(NSInteger type, NSInteger price) {
                    if (type==0) {
                        [weakself actorAskScheduleProcess:1 withInfo:info withPrice:0];
                    }
                    else
                    {
                        [weakself actorAskScheduleProcess:3 withInfo:info withPrice:price];
                    }
                };
            }
            else
            {
                OrderSchedulePopV *popV = [[OrderSchedulePopV alloc]init];
                [popV showPopVWithType:1];
                popV.confrimBlock = ^{
                    [weakself actorAskScheduleProcess:1 withInfo:info withPrice:0];
                };
            }
        }
    }
    else if (type==OrderBtnTypeNoSchedule)  //无档期
    {
        OrderSchedulePopV *popV = [[OrderSchedulePopV alloc]init];
        [popV showPopVWithType:0];
        popV.confrimBlock = ^{
            [weakself actorAskScheduleProcess:2 withInfo:info withPrice:0];
        };
    }
    else if (type==OrderBtnTypeAccept)  //接单
    {
        if ([UserInfoManager getUserAuthState]!=1) {
            [SVProgressHUD showErrorWithStatus:@"认证后才能接单！"];
            return;
        }
        
        AcceptOrderPopV *popV = [[AcceptOrderPopV alloc]init];
        [popV show];
        popV.acceptOrder = ^{
            [weakself acceptOrderWithInfo:info];
        };
        
    }
    else if (type==OrderBtnTypeReject)  //拒单
    {
        RejectOrderPopV *popV=[[RejectOrderPopV alloc]init];
        [popV showWithOrderType:info.orderType];
        popV.rejectWithReason = ^(NSString *reason) {
            [weakself rejectOrderWithReson:reason withInfo:info];
        };
    }
    else if (type==OrderBtnTypeUploadVide)  //上传视频
    {
        [self uploadVideoOrPhotoActionWithInfo:info withType:1 withMaxCount:1];
    }
    else if (type==OrderBtnTypeEnterAuditonRoom)//进入试镜间
    {
        NSString *auditionDate = info.tryVideoInfo[@"auditionDate"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-DD HH:mm"];
        NSDate *audition = [dateFormatter dateFromString:auditionDate];
        NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSComparisonResult result = [audition compare:nowDate];
        if (result == NSOrderedDescending) {
            //NSLog(@"Date1  is in the future");
            [SVProgressHUD showImage:nil status:@"试镜时间还没开始"];
            return;
        }
        //进入试镜
        NSDictionary *arg = @{
                              @"orderId":info.orderId,
                              @"userId":@([[UserInfoManager getUserUID] integerValue])
                              };
        [AFWebAPI_JAVA lauchAuditionOnlineWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *body = object[@"body"];
                NSString *token = body[@"token"];
                if (token.length>0) {
                    QNTestVC *qn = [QNTestVC new];
                    qn.isCall = YES;
                    qn.token = token;
                    qn.hisAvatar = info.actorInfo[@"actorHead"];
                    qn.hisName = info.actorInfo[@"actorName"];
                    qn.roomName = body[@"roomName"];
                    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                    if (authStatus != AVAuthorizationStatusAuthorized) {
                        
                        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                            NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
                            if (granted) {
                                [self presentViewController:qn animated:YES completion:nil];
                            }
                        }];
                        
                    } else {  //做你想做的（可以去打开设置的路径）
                        [self presentViewController:qn animated:YES completion:nil];
                    }
                }
                
            }else{
                [SVProgressHUD showImage:nil status:@"未获取到试镜间信息"];
            }
            }
        ];
        }
    else if (type==OrderBtnTypeLookAnnunciate)  //查看通告
    {
        LookAnnunciatePopV *popV = [[LookAnnunciatePopV alloc]init];
        [popV showPopVWithInfo:info];
    }
    else if (type==OrderBtnTypeLookVideo)  //查看视频
    {
        NSArray *array = (NSArray*)safeObjectForKey(info.tryVideoInfo, @"fileList");
        if (array.count==0) {
            [SVProgressHUD showImage:nil status:@"无视频"];
            return;
        }
        
        NSDictionary *dic = [array lastObject];
        if ([dic[@"fileType"]integerValue]==2) {
            NSString *url = (NSString*)safeObjectForKey(dic, @"url");
            [self playVideoWithUrl:url];
        }
 
    }else if (type==OrderBtnTypePortraitSign){
        NSDictionary *arg = @{
                              @"orderId":info.orderId,
                              @"userId":@([[UserInfoManager getUserUID] integerValue])
                              };
        [AFWebAPI_JAVA getPortraitUrlWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *body = object[JSON_body];
                NSString *signShortUrl = body[@"signShortUrl"];
                PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"肖像授权" url:signShortUrl];
                webVC.hidesBottomBarWhenPushed=YES;
                webVC.refereshIfPortrait = ^{
                  [weakself refreshData];
                };
                [weakself.navigationController pushViewController:webVC animated:YES];
            }
        }];
    }else if (type==ProjectBtnTypePortraitLook){
       // 预览
        NSDictionary *arg = @{
                              @"orderId":info.orderId,
                              @"userType":@(2)
                              };
        [AFWebAPI_JAVA lookPortraitWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *body = object[JSON_body];
                NSString *renderUrl = body[@"renderUrl"];
                PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"肖像授权" url:renderUrl];
                webVC.hidesBottomBarWhenPushed=YES;
            [weakself.navigationController pushViewController:webVC animated:YES];
            }
        }];
    }
    
}

//拒单操作
-(void)rejectOrderWithReson:(NSString*)reson withInfo:(ProjectOrderInfoM*)info
{
    if (info.orderType==3) {  //试镜
        [self tryVideoProceWithInfo:info withOperate:206 withReason:reson];
    }
    else if (info.orderType==5)  //定妆
    {
        [self makeupProceWithInfo:info withOperate:404 withReason:reson];
    }
    else if (info.orderType==7)  //锁档
    {
        [self lockScheduleProceWithInfo:info withOperate:304 withReason:reson];
    }
}

//接单操作
-(void)acceptOrderWithInfo:(ProjectOrderInfoM*)info
{
    if (info.orderType==3) {  //试镜
        [self tryVideoProceWithInfo:info withOperate:203 withReason:@""];
    }
    else if (info.orderType==5)  //定妆
    {
        [self makeupProceWithInfo:info withOperate:403 withReason:@""];
    }
    else if (info.orderType==7)  //锁档
    {
        [self lockScheduleProceWithInfo:info withOperate:303 withReason:@""];
    }
}

//演员操作询问档期订单
-(void)actorAskScheduleProcess:(NSInteger)operate withInfo:(ProjectOrderInfoM*)info withPrice:(NSInteger)price
{
    [SVProgressHUD show];
    NSDictionary *dic = @{@"operate":@(operate),   //1=同意档期; 2=拒绝档期; 3=同意档期并还价
                          @"orderId":info.orderId,
                          @"userId":[UserInfoManager getUserUID],
                          };
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
    if (operate==3) {
        [dicArg setObject:@(price) forKey:@"suggestPrice"];
    }
    
    [AFWebAPI_JAVA getActorProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self refreshData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//试镜订单操作
-(void)tryVideoProceWithInfo:(ProjectOrderInfoM*)info withOperate:(NSInteger)operate withReason:(NSString*)reason
{
    [SVProgressHUD show];
    NSDictionary *dic = @{@"operate":@(operate),
                             @"orderId":info.orderId,
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType])};
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
    if (operate==206) {  //拒单
        [dicArg setObject:reason forKey:@"rejectReason"];
    }
    
    [AFWebAPI_JAVA getTryVideoProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self refreshData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//锁档订单操作
-(void)lockScheduleProceWithInfo:(ProjectOrderInfoM*)info withOperate:(NSInteger)operate withReason:(NSString*)reason
{
    [SVProgressHUD show];
    NSDictionary *dic = @{@"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType]),
                             @"operate":@(operate),
                             @"orderIdList":@[info.orderId]
                             };
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
    if (operate==304) {  //拒单
        [dicArg setObject:reason forKey:@"rejectReason"];
    }
    
    [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self refreshData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//定妆订单操作
-(void)makeupProceWithInfo:(ProjectOrderInfoM*)info withOperate:(NSInteger)operate withReason:(NSString*)reason
{
    [SVProgressHUD show];
    NSDictionary *dic = @{@"operate":@(operate),
                             @"orderId":info.orderId,
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType])
                             };
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
    if (operate==404) {  //拒单
        [dicArg setObject:reason forKey:@"rejectReason"];
    }
    
    [AFWebAPI_JAVA getMakeupProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self refreshData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//上传视频,图片 type=1：视频。2:图片。maxCount：最大数量
-(void)uploadVideoOrPhotoActionWithInfo:(ProjectOrderInfoM*)pInfo withType:(NSInteger)type withMaxCount:(NSInteger)maxCount
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    
    if (type==1) {  //视频
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = NO;
        imagePickerVc.allowPickingMultipleVideo = YES; // 是否可以多选视频
    }
    else
    {
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    }

    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowCrop=YES;
    imagePickerVc.cropRect=CGRectMake(0,UI_SCREEN_HEIGHT/2-UI_SCREEN_WIDTH * 42/75/2, UI_SCREEN_WIDTH, UI_SCREEN_WIDTH * 42/75);
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = NO;
    
    // 设置首选语言 / Set preferred language
    imagePickerVc.preferredLanguage = @"zh-Hans";
    
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        
        //视频PHAsset转nsdata
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.networkAccessAllowed = true;  //允许网络视频加载
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        [SVProgressHUD show];

        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *url = urlAsset.URL;
            NSData *data = [NSData dataWithContentsOfURL:url];
            [self uploadTryVideoWithInfo:pInfo withData:data];
        }];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

        [self uploadLastPhotoWithInfo:pInfo withArray:photos];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)uploadTryVideoWithInfo:(ProjectOrderInfoM*)info withData:(NSData*)data
{

    NSDictionary *dicArg = @{@"orderId":info.orderId,
                             @"actorId":@(info.actorId)
                             };
    [AFWebAPI_JAVA upLoadTryVideoWithArg:dicArg data:data callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"已上传"];
            //上传完后调用试镜操作
            [self tryVideoProceWithInfo:info withOperate:207 withReason:@""];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//上传最新照片
-(void)uploadLastPhotoWithInfo:(ProjectOrderInfoM*)info withArray:(NSArray*)array
{
    NSDictionary *dicArg = @{@"orderId":info.orderId,
                             @"userId":@(info.actorId),
                             @"category":@(2),
                             @"fileType":@(1)
                             };
    [SVProgressHUD showWithStatus:@"正在上传。。。"];
    
    __block  NSInteger uploadCount=array.count;
    for (int i=0; i<array.count; i++) {
        UIImage *image = array[i];
        NSData *data =  UIImageJPEGRepresentation(image, 1.0);
        [AFWebAPI_JAVA upLoadLastPhotoWithArg:dicArg data:data callBack:^(BOOL success, id  _Nonnull object) {
            uploadCount--;
            if (success) {
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
            if (uploadCount==0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showSuccessWithStatus:@"上传完成。"];
                    [self refreshData];
                });
            }
        }];
    };
}

@end
