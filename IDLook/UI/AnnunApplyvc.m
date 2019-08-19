//
//  AnnunApplyvc.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunApplyvc.h"
#import "TZImagePickerController.h"
#import "UseSelectPopView.h"
#import "AnnunSuccessVC.h"
@interface AnnunApplyvc ()<UITextFieldDelegate,TZImagePickerControllerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *city_time;
@property (weak, nonatomic) IBOutlet UIButton *roleSelectBtn;
- (IBAction)roleSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceTip;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceText;

@property (weak, nonatomic) IBOutlet UIView *modelCardView;
@property (weak, nonatomic) IBOutlet UIButton *modelCardBtn;
- (IBAction)modelCardAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *introView;
@property (weak, nonatomic) IBOutlet UIButton *introBtn;
- (IBAction)introAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
- (IBAction)testAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
- (IBAction)applyAction:(id)sender;

@property(nonatomic,strong)NSMutableArray *selectedAssets;
@property(nonatomic,strong)NSData *imgData;//模特卡
@property(nonatomic,strong)NSData *introData;//自我介绍视频
@property(nonatomic,strong)NSData *testData;//试镜视频

@property(nonatomic,assign)NSInteger imgId;//脚本上传返回的id
@property(nonatomic,assign)NSInteger introId;
@property(nonatomic,assign)NSInteger testId;

@property(nonatomic,strong)UIImage *picImage;
@property(nonatomic,strong)UIImage *introImage;
@property(nonatomic,strong)UIImage *testImage;

@property(nonatomic,assign)NSInteger price;
@property(nonatomic,assign)NSInteger roleid;
@end

@implementation AnnunApplyvc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"报名"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    self.modelCardView.layer.cornerRadius = 8;
    self.modelCardView.layer.masksToBounds = YES;
    self.introView.layer.cornerRadius = 8;
    self.introView.layer.masksToBounds = YES;
    self.testView.layer.cornerRadius = 8;
    self.testView.layer.masksToBounds = YES;
    self.applyBtn.layer.cornerRadius = 8;
    self.applyBtn.layer.masksToBounds = YES;
    self.modelCardBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.scroll.contentSize = CGSizeMake(375, 1148);
    
    [self initUIWithRoleDic:_roleDic];
     NSString *roleName = _roleDic[@"roleName"];
    if (roleName) {
         self.roleSelectBtn.userInteractionEnabled = NO; //如果有角色不能选
    }
   self.name.text = _model.title;
    self.city_time.text = [NSString stringWithFormat:@"%@·%@ 至 %@",_model.shotCity,_model.shotStartDate,_model.shotEndDate];
}

-(void)initUIWithRoleDic:(NSDictionary *)dic
{
    NSInteger roleId = [dic[@"roleId"] integerValue];
    _roleid = roleId;
    NSString *roleName = dic[@"roleName"];
    if (roleName.length>0) {
        [self.roleSelectBtn setTitle:roleName forState:0];
        NSInteger rolePrice = [dic[@"budget"] integerValue];
        if (rolePrice>0) {
            self.priceTip.text = @"客户预算";
            self.priceLabel.text = [NSString stringWithFormat:@"%ld",rolePrice];
            self.priceLabel.hidden = NO;
            self.priceText.hidden = YES;
            self.price = rolePrice;
        }else{
            self.priceTip.text = @"期望片酬";
            self.priceLabel.hidden = YES;
            self.priceText.hidden = NO;
        }
    }else{
        self.priceTip.text = @"期望片酬";
        self.priceLabel.hidden = YES;
        self.priceText.hidden = NO;
    }
}

- (IBAction)roleSelect:(id)sender {
    WeakSelf(self);
  
    UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
    NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
   __block NSMutableArray *roleNames = [NSMutableArray new];
    for (NSDictionary *rd in _model.roleList) {
        NSString *name = rd[@"roleName"];
        [roleNames addObject:name];
    }
    //_model.roleList;
    popv.dataSource = [roleNames copy];//[NSArray arrayWithObjects:@"男",@"女",nil];
    popv.title = @"选择角色";
    popv.selectStr = [_roleSelectBtn.titleLabel.text isEqualToString:@"请选择角色"]?@"":_roleSelectBtn.titleLabel.text;
    [popv initSubviews];
    popv.selectID = ^(NSString * _Nonnull string) {
        [weakself.roleSelectBtn setTitle:string forState:0];
        for(int i = 0;i<roleNames.count ;i++){
            NSString *nm = roleNames[i];
            if ([nm isEqualToString:string]) {
                NSDictionary *roleD = weakself.model.roleList[i];
                [weakself initUIWithRoleDic:roleD];
                break;
            }
        }
    };
}

- (IBAction)modelCardAction:(id)sender {
    if(_roleid==0){
      [SVProgressHUD showErrorWithStatus:@"请选择角色"];
        return;
    }
    [self addVideoWithType:1];
}

- (IBAction)introAction:(id)sender {
    if(_roleid==0){
        [SVProgressHUD showErrorWithStatus:@"请选择角色"];
        return;
    }
     [self addVideoWithType:2];
}

- (IBAction)testAction:(id)sender {
    if(_roleid==0){
        [SVProgressHUD showErrorWithStatus:@"请选择角色"];
        return;
    }
     [self addVideoWithType:3];
}

- (IBAction)applyAction:(id)sender {
    if ([_roleSelectBtn.titleLabel.text isEqualToString:@"请选择角色"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择角色"];
        return;
    }
    if ([_priceTip.text isEqualToString:@"期望片酬"] && _priceText.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请填写片酬"];
        return;
    }
    if (_imgId==0) {
        [SVProgressHUD showErrorWithStatus:@"请上传模特卡"];
                return;
    }
    if (_introId==0) {
        [SVProgressHUD showErrorWithStatus:@"请上传自我介绍视频"];
        return;
    }
//    if (_imgData.length>1024*5) {
//        [SVProgressHUD showErrorWithStatus:@"模特卡大于5M"];
//        return;
//    }
//    if (_introData.length>1024*5) {
//        [SVProgressHUD showErrorWithStatus:@"自我介绍视频大于50M"];
//        return;
//    }
//    if (_testData.length>1024*5) {
//        [SVProgressHUD showErrorWithStatus:@"试镜视频大于50M"];
//        return;
//    }
    NSString *roleId = _roleDic[@"roleId"];
    NSDictionary  *body =  @{
        @"actorId": @([[UserInfoManager getUserUID] integerValue]),
        @"modelCard": @(_imgId),
        @"phone": [UserInfoManager getUserMobile],
        @"price": @(_price),
        @"roleId":@([roleId integerValue]),
        @"selfIntro": @(_introId),
        @"shotBroadcastId": @(_model.id),
        @"tryVideo": @(_testId)
        };
    [AFWebAPI_JAVA applyAnnunciateWith:body callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            AnnunSuccessVC *success = [AnnunSuccessVC new];
            success.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:success animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.priceText resignFirstResponder];
    self.price = [_priceText.text integerValue];
}

//添加视频，图片。type=0:视频。type=1:图片。type=2:图片+视频
-(void)addVideoWithType:(NSInteger)type
{
    WeakSelf(self);
    NSInteger roleId = [_roleDic[@"roleId"] integerValue];
 
    NSDictionary *dic = @{
                          @"actorId":@([[UserInfoManager getUserUID] integerValue]),
                          @"roleId":@(_roleid),
                          @"shotBroadcastId":@(_model.id)
                          };
  __block  NSMutableDictionary *muDic = [NSMutableDictionary new];
    [muDic addEntriesFromDictionary:dic];
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.selectedAssets = self.selectedAssets;
    
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
    if (type==2 || type==3) {  //视频
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = NO;
    }
    else if (type==1)   //图片
    {
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
    }
 
    
    imagePickerVc.allowPickingOriginalPhoto = NO;   //是否能选原图
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = NO;
    
    // 设置首选语言 / Set preferred language
    imagePickerVc.preferredLanguage = @"zh-Hans";
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        PHAsset *fileasset = [assets firstObject];
        UIImage *image = photos.firstObject;
        if (fileasset.mediaType==PHAssetMediaTypeImage) {
//            NSData *picData = UIImageJPEGRepresentation(image, 1.0);
//            NSLog(@"leghth is %ld",picData.length);
//            if (picData.length/1000>5) {
//             image = [PublicManager scaleImageWithSize:5 image:image];
//            }
          //  weakself.picImage = image;
            [weakself.modelCardBtn setBackgroundImage:image forState:0];
            weakself.imgData = UIImageJPEGRepresentation(image, 1.0);
            [muDic setObject:@(1) forKey:@"type"];
            [AFWebAPI_JAVA upLoadAnnunciateWithArg:muDic type:1 data:weakself.imgData callBack:^(BOOL success, id  _Nonnull object) {
                NSLog(@"图片上传结果：%@",object);
                NSInteger picId = [[object objectForKey:JSON_body][@"id"] integerValue];
                weakself.imgId = picId;
            }];
        }
    }];
    
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
          [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        NSTimeInterval time = asset.duration;
        int times = round(time);
       
        
        //视频PHAsset转nsdata
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.networkAccessAllowed = true;  //允许网络视频加载
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        if (type==2) {
           // weakself.introImage = coverImage;
            [weakself.introBtn setBackgroundImage:coverImage forState:0];
        }else{
           // weakself.testImage = coverImage;
            [weakself.testBtn setBackgroundImage:coverImage forState:0];
        }
        
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *url = urlAsset.URL;
            NSData *data = [NSData dataWithContentsOfURL:url];
//            if (data.length/1000>50) {
//                [SVProgressHUD showErrorWithStatus:@"视频不能大于50M"];
//                return ;
//            }
            if (type==2) {
                weakself.introData = data;
                 [muDic setObject:@(2) forKey:@"type"];
                 // [weakself.introBtn setBackgroundImage:coverImage forState:0];
            }else{
                weakself.testData = data;
                 [muDic setObject:@(3) forKey:@"type"];
              //   [weakself.testBtn setBackgroundImage:coverImage forState:0];
            }
          
            [AFWebAPI_JAVA upLoadAnnunciateWithArg:muDic type:2 data:data callBack:^(BOOL success, id  _Nonnull object) {
                NSLog(@"视频上传结果：%@",object);
                 [SVProgressHUD showSuccessWithStatus:@""];
                NSInteger viId = [[object objectForKey:JSON_body][@"id"] integerValue];
                if (type==2) {
                   weakself.introId = viId;
                }else{
                    weakself.testId = viId;
                }
                
            }];
        }];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
