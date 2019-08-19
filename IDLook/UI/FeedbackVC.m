//
//  FeedbackVC.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "FeedbackVC.h"
#import "FeedbackCellA.h"
#import "FeedbackCellB.h"

@interface FeedbackVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"意见反馈"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//提交
-(void)commitAction
{
    FeedbackCellA *cellA=[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    FeedbackCellB *cellB= [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    if(cellA.textView.text.length<10)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入10字以上的内容"];
        return;
    }
    else if (cellB.textField.text.length<=0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入您的联系方式"];
        return;
    }

     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
      if ([UserInfoManager getIsJavaService]) {//java后台
          NSDictionary *dicArg = @{@"userId":@([[UserInfoManager getUserUID] integerValue]),
                                   @"content":cellA.textView.text,
                                   @"contact":cellB.textField.text
                                  };
          UIImage *scaleImg = [PublicManager scaleImageWithSize:200 image:cellA.photoBtn.currentImage];
          [AFWebAPI_JAVA setUserFeedbackArg:dicArg data:UIImageJPEGRepresentation(scaleImg, 1.0) callBack:^(BOOL success, id  _Nonnull object) {
              if (success) {
                  [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
                             @"content":cellA.textView.text,
                             @"contact":cellB.textField.text};
    
    [AFWebAPI setUserFeedbackArg:dicArg data:UIImageJPEGRepresentation(cellA.photoBtn.currentImage, 1.0) callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor = Public_LineGray_Color;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableV.touchDelegate=self;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
        _tableV.tableFooterView=[self tableFootV];
    }
    return _tableV;
}

-(UIView*)tableFootV
{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 108)];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor=Public_Red_Color;
    commitBtn.layer.cornerRadius=5.0;
    commitBtn.layer.masksToBounds=YES;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [footV addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footV);
        make.left.mas_equalTo(footV).offset(15);
        make.centerY.mas_equalTo(footV);
        make.height.mas_equalTo(48);
    }];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    return footV;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 210;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
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
        return cell;
    }
    else
    {
        static NSString *identifer = @"FeedbackCellB";
        FeedbackCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[FeedbackCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            
        }
        [cell reloadUI];
        return cell;
    }
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
