//
//  UploadPersonBGVC.m
//  IDLook
//
//  Created by HYH on 2018/8/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadPersonBGVC.h"
#import "AddSubButton.h"
#import "TZImagePickerController.h"

@interface UploadPersonBGVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
@property(nonatomic,strong)AddSubButton *addBtn;
@end

@implementation UploadPersonBGVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"上传个人主页背景"]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self initUI];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI
{
    
    UILabel *titleLab = [[UILabel alloc]init];
    [self.view addSubview:titleLab];
    titleLab.text=@"*请上传清晰的与您本人相关的背景图";
    titleLab.font=[UIFont systemFontOfSize:13.0];
    titleLab.textColor=Public_Red_Color;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(25);
    }];
    
    AddSubButton *addBtn=[[AddSubButton alloc]init];
    addBtn.imageN=@"works_photo_icon";
    addBtn.title=@"添加背景图";
    addBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(self.view).offset(50);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH-30,(UI_SCREEN_WIDTH-30)*0.61));
    }];
    WeakSelf(self);
    addBtn.addAction = ^{
        [weakself selectHeadIcon];
    };
    self.addBtn=addBtn;
    
    UIImageView *arrow = [[UIImageView alloc]init];
    [self.view addSubview:arrow];
    [arrow setImage:[UIImage imageNamed:@"upload_head_arrow02"]];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(addBtn.mas_bottom).offset(15);
    }];
    
    UIImageView *defaultHead = [[UIImageView alloc]init];
    [self.view addSubview:defaultHead];
    [defaultHead setImage:[UIImage imageNamed:@"upload_head_02"]];
    [defaultHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(addBtn.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH-30,(UI_SCREEN_WIDTH-30)*0.61));
    }];
    
    UILabel *desc = [[UILabel alloc]init];
    [self.view addSubview:desc];
    desc.text=@"背景示例";
    desc.font=[UIFont systemFontOfSize:12.0];
    desc.textColor=[UIColor whiteColor];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(defaultHead);
        make.bottom.mas_equalTo(defaultHead).offset(-5);
    }];
    
    UIButton *confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.backgroundColor=Public_Red_Color;
    confirmBtn.layer.cornerRadius=5.0;
    confirmBtn.layer.masksToBounds=YES;
    [confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(defaultHead.mas_bottom).offset(30);
        make.height.mas_equalTo(48);
    }];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
}

//确认
-(void)confirmAction
{
    if (self.addBtn.iconImage==nil) {
        [SVProgressHUD showImage:nil status:@"请选择背景"];
        return;
    }

    if (self.isSave) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicArg =@{@"userid":[UserInfoManager getUserUID]};
        
        NSDictionary *infoDic = @{@"background":self.addBtn.iconImage};
        
        [AFWebAPI modifMyotherInfoWithArg:dicArg DataDic:infoDic callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                NSDictionary *dic = [object objectForKey:JSON_data];
                UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
                [UserInfoManager setUserLoginfo:uinfo];
                
                self.addHeadBGBlock(self.addBtn.iconImage);
                [self onGoback];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    else
    {
        self.addHeadBGBlock(self.addBtn.iconImage);
        [self onGoback];
    }

    
    self.addHeadBGBlock(self.addBtn.iconImage);
    [self onGoback];
}

#pragma mark -
#pragma mark - set Head Icon

- (void)selectHeadIcon
{

    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
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
    
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    
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
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            PHAsset *fileasset = [assets firstObject];
            UIImage *image = photos.firstObject;
            if (fileasset.mediaType==PHAssetMediaTypeImage) {
                self.addBtn.iconImage = image;
            }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}

@end
