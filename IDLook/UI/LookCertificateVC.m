//
//  LookCertificateVC.m
//  IDLook
//
//  Created by HYH on 2018/5/23.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LookCertificateVC.h"
#import "UploadCertifVC.h"

@interface LookCertificateVC ()
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,assign)BOOL isResubit;  //是否重新提交过
@end

@implementation LookCertificateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"重新提交" Target:self action:@selector(ResubmitAction)]]];
    
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
    
    [self initUI];
}

-(void)onGoback
{
    if (self.isResubit) {  //重新提交过则要重新获取授权书列表
        self.uploadRefreshUI();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//重新提交
-(void)ResubmitAction
{
    UploadCertifVC *uploadVC=[[UploadCertifVC alloc]init];
    uploadVC.model=self.model;
    WeakSelf(self);
    uploadVC.uploadRefreshUIWithUrl = ^(NSString *imageUrl) {
        weakself.model.imageUrl=imageUrl;
        [weakself.imageV sd_setImageWithUrlStr:weakself.model.imageUrl placeholderImage:[UIImage imageNamed:@"default_video"]];
        weakself.isResubit=YES;
    };
    
    [self.navigationController pushViewController:uploadVC  animated:YES];
}

-(void)initUI
{
    UIImageView *imageV=[[UIImageView alloc]init];
    [self.view addSubview:imageV];
    imageV.userInteractionEnabled=YES;
    [imageV sd_setImageWithUrlStr:self.model.imageUrl placeholderImage:[UIImage imageNamed:@"default_video"]];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(25);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH-30, (UI_SCREEN_WIDTH-30)*(486.0/690.0)));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookBigPhoto)];
    [imageV addGestureRecognizer:tap];
    self.imageV=imageV;
    
    MLLabel *desc=[[MLLabel alloc]init];
    [self.view addSubview:desc];
    desc.numberOfLines=0;
    desc.lineSpacing = 5;
    desc.text=@"授权书的模板可以用电脑打开网页，然后登录脸探肖像平台进行模板下载。 内容完善后可拍照上传授权书到脸探肖像平台。";
    desc.textAlignment=NSTextAlignmentCenter;
    desc.font=[UIFont systemFontOfSize:13.0];
    desc.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(19);
        make.bottom.mas_equalTo(self.view).offset(-40);
    }];
}

-(void)lookBigPhoto
{
    NSArray *array = @[self.model.imageUrl];
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    [lookImage showWithImageArray:array curImgIndex:0 AbsRect:CGRectMake(15, 25,UI_SCREEN_WIDTH-30, (UI_SCREEN_WIDTH-30)*(486.0/690.0))];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {};
}

@end
