//
//  UploadHeadVC.m
//  IDLook
//
//  Created by HYH on 2018/8/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadHeadVC.h"
#import "AddSubButton.h"

@interface UploadHeadVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)AddSubButton *addBtn;
@end

@implementation UploadHeadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"上传头像"]];
    
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
    titleLab.text=@"*请上传五官清晰的正面照";
    titleLab.font=[UIFont systemFontOfSize:13.0];
    titleLab.textColor=Public_Red_Color;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(50);
    }];
    
    UIImageView *arrow = [[UIImageView alloc]init];
    [self.view addSubview:arrow];
    [arrow setImage:[UIImage imageNamed:@"upload_head_arrow"]];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(170);
    }];
    
    AddSubButton *addBtn=[[AddSubButton alloc]init];
    addBtn.imageN=@"works_photo_icon";
    addBtn.title=@"添加头像";
    addBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(-25);
        make.top.mas_equalTo(self.view).offset(93);
        make.size.mas_equalTo(CGSizeMake(130, 130));
    }];
    WeakSelf(self);
    addBtn.addAction = ^{
        [weakself selectHeadIcon];
    };
    self.addBtn=addBtn;
    
    UIImageView *defaultHead = [[UIImageView alloc]init];
    [self.view addSubview:defaultHead];
    [defaultHead setImage:[UIImage imageNamed:@"upload_head_01"]];
    [defaultHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX).offset(25);
        make.top.mas_equalTo(self.view).offset(93);
        make.size.mas_equalTo(CGSizeMake(130, 130));
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
        [SVProgressHUD showImage:nil status:@"请选择头像"];
        return;
    }
    
    if (self.isSave) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicArg =@{@"userid":[UserInfoManager getUserUID]};
        
        NSDictionary *infoDic = @{@"head":self.addBtn.iconImage};

        [AFWebAPI modifMyotherInfoWithArg:dicArg DataDic:infoDic callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                NSDictionary *dic = [object objectForKey:JSON_data];
                UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
                [UserInfoManager setUserLoginfo:uinfo];
                self.addHeadBlock(self.addBtn.iconImage);
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
        self.addHeadBlock(self.addBtn.iconImage);
        [self onGoback];
    }
    
}

#pragma mark -
#pragma mark - set Head Icon

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];

        self.addBtn.iconImage = image;
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


- (void)selectHeadIcon
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"手机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:^{}];
        }
        else
        {}
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"本地图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:^{}];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [alert dismissViewControllerAnimated:YES completion:^{}];
                                                    }];
    
    [alert addAction:action0];
    [alert addAction:action1];
    [alert addAction:action2];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}


@end
