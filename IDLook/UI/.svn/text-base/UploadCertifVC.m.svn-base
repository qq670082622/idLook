//
//  UploadCertifVC.m
//  IDLook
//
//  Created by HYH on 2018/5/23.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadCertifVC.h"
#import "AddSubButton.h"

@interface UploadCertifVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)AddSubButton *uploadSubV;
@property(nonatomic,strong)UIImage *image;
@end

@implementation UploadCertifVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"下载模版" Target:self action:@selector(download)]]];
    
    if (self.model.type==CerticateTypeCooperat) {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"脸探肖像合作授权书"]];
    }
    else if (self.model.type==CerticateTypeMirrorPhoto)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"微出镜照片授权书"]];
    }
    else if (self.model.type==CerticateTypeMirrorVideo)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"微出镜视频授权书"]];
        
    }
    else if (self.model.type==CerticateTypeTrial)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"试葩间视频授权书"]];
        
    }
    
    self.view.layer.borderWidth=0.5;
    self.view.layer.borderColor=[UIColor colorWithHexString:@"#F7F7F7"].CGColor;
    
    [self initUI];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}


//下载模版
-(void)download
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"请用电脑登录www.idlook.com下载授权书模板" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    
    [alert addAction:action0];
    [self presentViewController:alert animated:YES completion:^{}];
}

//上传
-(void)upload
{
    NSData *data = UIImageJPEGRepresentation(self.image, 1.0);
    if ([data length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请添加授权书"];
        return;
    }
    
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dic  = @{@"userid":[UserInfoManager getUserUID],
                           @"authorizationtype":@(self.model.type)};
    
    [AFWebAPI uploadAuthorizationArg:dic data:data callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            NSArray *array =[object objectForKey:JSON_data];
            NSDictionary *dic =[array firstObject];
            self.uploadRefreshUIWithUrl(dic[@"authorizationimgurl"]);
            [self onGoback];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}


-(void)initUI
{
    AddSubButton *uploadSubV=[[AddSubButton alloc]init];
    [self.view addSubview:uploadSubV];
    uploadSubV.imageN=@"certif_upload_icon";
    uploadSubV.title=@"添加授权书";
    [uploadSubV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(40);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH-110, 134));
    }];
    WeakSelf(self);
    uploadSubV.addAction = ^{
        [weakself addCertificate];
    };
    self.uploadSubV=uploadSubV;
    
    UIButton *uploadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [uploadBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn"] forState:UIControlStateNormal];
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [self.view addSubview:uploadBtn];
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-30);
    }];
    [uploadBtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
}

//添加授权书
- (void)addCertificate
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate


-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.image=image;
        self.uploadSubV.iconImage=image;
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


@end
