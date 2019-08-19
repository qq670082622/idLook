//
//  ReportUserVC.m
//  IDLook
//
//  Created by HYH on 2018/8/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ReportUserVC.h"
#import "FeedbackCellA.h"

@interface ReportUserVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)UIButton *commitBtn;
@property(nonatomic,strong)NSData *imageData;
@end

@implementation ReportUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"举报描述"]];

    [self tableV];
    [self commitBtn];
}


-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//提交
-(void)commitAction
{
    FeedbackCellA *cellA=[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (cellA.textView.text.length==0 && self.imageData.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容或上传图片"];
        return;
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    if ([UserInfoManager getIsJavaService]) {//java后台
        NSDictionary *dicArg = @{@"userId":@([[UserInfoManager getUserUID] integerValue]),
                                 @"content":[NSString stringWithFormat:@"%@",cellA.textView.text],
                                 @"complainId":@(self.info.actorId)
                                 };
        
        [AFWebAPI_JAVA getReportUserWithArg:dicArg data:self.imageData callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"举报成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self onGoback];
                });
            }
            else
            {
                AF_SHOW_JAVA_ERROR
            }
        }];
    }else{
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                             @"content":[NSString stringWithFormat:@"%@",cellA.textView.text],
                             @"creativeid":@(self.info.actorId)};
    [AFWebAPI getReportUserWithArg:dicArg data:self.imageData callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"举报成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self onGoback];
            });
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    }
}

-(UIButton*)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"LR_btn"] forState:UIControlStateNormal];
        [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [self.view addSubview:_commitBtn];
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-30);
        }];
        [_commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}
-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableV.touchDelegate=self;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
    }
    return _tableV;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"FeedbackCellA";
    FeedbackCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[FeedbackCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        WeakSelf(self);
        cell.addPhotoBlock = ^{
            [weakself adddPhotoClicked];
        };
    }
    [cell reloadUI];
    cell.tip.text=@"简单描述一下对方的违规行为，可添加截图，有助于加快举报处理的速度";
    return cell;
}

//添加图片
- (void)adddPhotoClicked
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
        FeedbackCellA *cell = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UIImage *scaleImg = [PublicManager scaleImageWithSize:200 image:image];
        self.imageData= UIImageJPEGRepresentation(scaleImg, 1.0);
        [cell.photoBtn setImage:image forState:UIControlStateNormal];
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
