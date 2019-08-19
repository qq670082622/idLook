//
//  AuthResourcerVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/9.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthResourcerVC.h"
#import "AuthCellA.h"
#import "AuthCellB.h"
#import "AuthCellC.h"
#import "AuthFootV.h"
#import "BirthSelectV.h"
#import "PublicPickerView.h"
#import "MyAuthStateVC.h"
#import "IdentityAuthCell.h"
#import "AuthModel.h"

@interface AuthResourcerVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TableVTouchDelegate>
@property (nonatomic,strong)TouchTableV *tableV;
@property (nonatomic,strong)NSMutableArray *dataS;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign)NSInteger imageType;  //图片类型 0：左边。1:右边
@end

@implementation AuthResourcerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"实名认证"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self dataS];
    
    [self tableV];
    
}

-(void)onGoback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSMutableArray*)dataS
{
    if (!_dataS) {
        _dataS=[[NSMutableArray alloc]initWithArray:[AuthModel getResourceAuthDataSource]];
    }
    return _dataS;
}

- (TouchTableV *)tableV
{
    if(!_tableV)
    {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.tableFooterView=[self tableFootView];
    }
    return _tableV;
}

-(UIView*)tableFootView
{
    IdentityAuthCell *bg = [[IdentityAuthCell alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-48-40-190-SafeAreaTabBarHeight_IphoneX-SafeAreaTopHeight)];
    WeakSelf(self);
    bg.submitBlock = ^{
        [weakself submitAuth];
    };
    return bg;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataS.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthStructModel *model = self.dataS[indexPath.row];
    if (model.cellType==AuthCellTypeImage) {
        return 190;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthStructModel *model = self.dataS[indexPath.row];
    WeakSelf(self);
    if (model.cellType==AuthCellTypeImage) {
        static NSString *identifer = @"AuthCellC";
        AuthCellC *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuthCellC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        cell.selectPhotoBlock = ^(NSInteger tag) {
            weakself.indexPath=indexPath;
            weakself.imageType=tag;
            [weakself addCertificate];
        };
        [cell reloadUIWithModel:model];
        return cell;
    }
    else
    {
        static NSString *identifer = @"AuthCellA";
        AuthCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuthCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithModel:model];
        cell.BeginEdit = ^{
            weakself.indexPath=indexPath;
        };
        cell.textFielChangeBlock = ^(NSString *text) {
            model.content=text;
        };
        return cell;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        static NSString *identifer = @"UITableViewHeaderFooterView";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
        if(!headerView)
        {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifer];
            [headerView.backgroundView setBackgroundColor:[UIColor clearColor]];
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.tag=100;
            titleLabel.textColor =  [UIColor colorWithHexString:@"#666666"];
            titleLabel.font=[UIFont systemFontOfSize:13.0];
            [headerView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(headerView).offset(15);
                make.top.mas_equalTo(headerView).offset(15);
            }];
        }
        UILabel *titleLab = [headerView viewWithTag:100];
        titleLab.text=@"请填写证件上真实的信息";
        return headerView;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

//提交审核
-(void)submitAuth
{
        AuthStructModel *model1 = self.dataS[0];
        AuthStructModel *model2 = self.dataS[1];
        if (model1.content.length<=0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请将%@填写完整～",model1.title]];
            return;
        }
        
        if (model2.image1==nil || model2.image2==nil) {
            [SVProgressHUD showErrorWithStatus:@"请将证件信息上传完整～"];
            return;
        }
        
        
    [SVProgressHUD showWithStatus:@"资料上传中，请稍等" maskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *dic=@{@"actorId":[UserInfoManager getUserUID],
                        @"idCardNo":model1.content};
    
    NSDictionary *imageDic =@{@"frontFile":[PublicManager scaleImageWithSize:1000 image:model2.image1],
                              @"backFile":[PublicManager scaleImageWithSize:1000 image:model2.image2]
                              };
    
    [AFWebAPI_JAVA getResourceAuthWithArg:dic imageDic:imageDic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"信息上传成功，请耐心等待审核结果！"];
            
            [UserInfoManager setUserAuthState:3];
            MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
            stateVC.authState=3;
            [self.navigationController pushViewController:stateVC animated:YES];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
 
}


#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//添加证件照
- (void)addCertificate
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
            picker.allowsEditing = NO;
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
        picker.allowsEditing = NO;
        
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

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate


-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        AuthStructModel *model = self.dataS[self.indexPath.row];
        if (self.imageType==0) {
            model.image1 = image;
        }
        else
        {
            model.image2=image;
        }
        [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self.indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


@end
