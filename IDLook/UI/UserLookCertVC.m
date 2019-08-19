//
//  UserLookCertVC.m
//  IDLook
//
//  Created by HYH on 2018/6/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserLookCertVC.h"

@interface UserLookCertVC ()

@end

@implementation UserLookCertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"脸探肖像合作授权书"]];

    [self initUI];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initUI
{
    UIImageView *imageV=[[UIImageView alloc]init];
    [self.view addSubview:imageV];
    imageV.userInteractionEnabled=YES;
    [imageV sd_setImageWithUrlStr:self.imageUrl placeholderImage:[UIImage imageNamed:@"default_video"]];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(25);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH-30, (UI_SCREEN_WIDTH-30)*(486.0/690.0)));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookBigPhoto)];
    [imageV addGestureRecognizer:tap];
    
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
    NSArray *array = @[self.imageUrl];
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    [lookImage showWithImageArray:array curImgIndex:0 AbsRect:CGRectMake(15, 25,UI_SCREEN_WIDTH-30, (UI_SCREEN_WIDTH-30)*(486.0/690.0))];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {};
}


@end
