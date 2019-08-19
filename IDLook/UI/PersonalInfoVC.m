//
//  PersonalInfoVC.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "EditInfoCellA.h"
#import "EditInfoCellB.h"
#import "EditInfoVC.h"
#import "PublicPickerView.h"
#import "RegionChooseVC.h"
#import "RegistCellA.h"
#import "UploadHeadVC.h"
#import "UploadPersonBGVC.h"
#import "CustTableViewCell.h"
#import "CenterCustomCell.h"

@interface PersonalInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIImage *head;
@property(nonatomic,strong)UIImage *iconBG;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation PersonalInfoVC

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"个人信息"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self getData];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

-(void)onGoback
{
    self.EditInfosBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    self.dataSource=[NSMutableArray new];
    NSArray *array;
    if ([UserInfoManager getUserType]==UserTypeResourcer) {  //资源方
        array = @[
                  @[@{@"title":@"头像",@"content":@"",@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                    @{@"title":@"用户ID",@"content":[UserInfoManager getUserUID],@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                    @{@"title":@"微博名",@"content":[UserInfoManager getUserSinaName],@"placeholder":@"请输入微博名",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeOther),@"parameter":@"weiboname"},
                    @{@"title":@"微博粉丝数",@"content":[UserInfoManager getUserSinaFansNumber]<=0?@"":[NSString stringWithFormat:@"%@万", [PublicManager changeFloatWithFloat:[UserInfoManager getUserSinaFansNumber]]],@"placeholder":@"请输入微博粉丝数(万为单位)",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeContactPhone),@"parameter":@"weibofans"}],
                  ];
    }
    else if([UserInfoManager getUserType]==UserTypePurchaser)  //购买方
    {
        array = @[
                  @[@{@"title":@"头像",@"content":@"",@"desc":@"",@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)},
                    @{@"title":@"用户ID",@"content":[UserInfoManager getUserUID],@"placeholder":@"",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeAge)}],
                  @[@{@"title":@"所在地",@"content":[UserInfoManager getUserRegion],@"placeholder":@"请选择所在地",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeOther),@"parameter":@"region"},
                    @{@"title":@"详细通讯地址",@"content":[UserInfoManager getUserAddress],@"placeholder":@"请填写详细通讯地址",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeOther),@"parameter":@"address"},
                    @{@"title":@"邮政编码",@"content":[UserInfoManager getUserPostalCode],@"placeholder":@"请填写邮政编码",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeContactPhone),@"parameter":@"postalcode"},
                    @{@"title":@"电子邮箱",@"content":[UserInfoManager getUserEmail],@"placeholder":@"请填写电子邮箱",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeOther),@"parameter":@"email"},
                    @{@"title":@"联系电话(1)",@"content":[UserInfoManager getUserContactnumber1],@"placeholder":@"请填写联系电话(1)",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeContactPhone),@"parameter":@"contactnumber1"},
                    @{@"title":@"联系电话(2)",@"content":[UserInfoManager getUserContactnumber2],@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeContactPhone),@"placeholder":@"请填写联系电话(2)",@"parameter":@"contactnumber2"}],
                  ];
    }
    
    for (int i=0; i<array.count; i++) {
        NSArray *arr1= array[i];
        NSMutableArray *dataS = [NSMutableArray new];
        for (int j=0; j<arr1.count; j++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:arr1[j]];
            [dataS addObject:model];
        }
        [self.dataSource addObject:dataS];
    }
    
    [self.tableV reloadData];
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor = Public_LineGray_Color;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
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
    [commitBtn setTitle:@"保存" forState:UIControlStateNormal];
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
    if (section==0) {
        return .1f;
    }
    return 10.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            return UI_SCREEN_WIDTH*0.66;;
        }
        else
        {
            return 95;
        }
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0) {
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            static NSString *identifer = @"RegistCellA";
            RegistCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if(!cell)
            {
                cell = [[RegistCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor whiteColor];
            }
            WeakSelf(self);
            cell.uploadBGBlock = ^{
                [weakself uploadBG];
            };
            cell.uploadHeadBlock = ^{
                [weakself uploadHead];
            };
            
            NSString *headUrl;
            BOOL isShow=NO;
            if ([UserInfoManager getUserHeadstatus]==1) {
                headUrl = [UserInfoManager getUserMiniaudit];
                isShow=YES;
            }
            else
            {
                headUrl = [UserInfoManager getUserHead];
                isShow=NO;
            }
            
            [cell reloadUIHead:nil withBG:nil withheadUrl:headUrl withBGUrl:[UserInfoManager getUserBackGround] withType:1 isShowState:isShow];
            
            return cell;
        }
        else
        {
            static NSString *identifer = @"EditInfoCellA";
            EditInfoCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if(!cell)
            {
                cell = [[EditInfoCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor whiteColor];
            }
            [cell reloadUI];
            return cell;
        }
    }
    else
    {
        static NSString *identifer = @"CenterCustomCell";
        CenterCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[CenterCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        EditStructM *model = self.dataSource[indexPath.section][indexPath.row];

        [cell reloadUIWithModel:model];
        WeakSelf(self);
        cell.BeginEdit = ^{
            weakself.indexPath=indexPath;
        };
        cell.textFieldChangeBlock = ^(NSString *text) {
            model.content=text;
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sec =indexPath.section;
    NSInteger row =indexPath.row;
    
    if (sec==0&&row==0&& [UserInfoManager getUserType]==UserTypePurchaser) {  //购买方修改头像
        [self selectHeadIcon];
    }
    
    EditStructM *model = self.dataSource[sec][row];
    if (model.isShowArrow==YES) {
        if (sec==1&&row==0) {  //所在地
            RegionChooseVC *regionVC=[[RegionChooseVC alloc]init];
            [self.navigationController pushViewController:regionVC animated:YES];
            WeakSelf(self);
            regionVC.selectCity = ^(NSString *city)
            {
                model.content=city;
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
    }
}


//上传头像
-(void)uploadHead
{
    UploadHeadVC *uploadVC=[[UploadHeadVC alloc]init];
    uploadVC.isSave=YES;
    WeakSelf(self);
    uploadVC.addHeadBlock = ^(UIImage *image) {
        weakself.head=image;
        [weakself.tableV reloadData];
    };
    [self.navigationController pushViewController:uploadVC animated:YES];
}

//上传背景图
-(void)uploadBG
{
    UploadPersonBGVC *uploadVC=[[UploadPersonBGVC alloc]init];
    uploadVC.isSave=YES;
    WeakSelf(self);
    uploadVC.addHeadBGBlock = ^(UIImage *image) {
        weakself.iconBG=image;
        [weakself.tableV reloadData];
    };
    [self.navigationController pushViewController:uploadVC animated:YES];
}

#pragma mark -
#pragma mark - set Head Icon
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [SVProgressHUD showWithStatus:@"正在上传头像" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dicArg =@{@"userid":[UserInfoManager getUserUID]};
        
        NSDictionary *infoDic = @{@"head":image};
        
        [AFWebAPI modifMyotherInfoWithArg:dicArg DataDic:infoDic callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                NSDictionary *dic = [object objectForKey:JSON_data];
                UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
                [UserInfoManager setUserLoginfo:uinfo];
 
                [self.tableV reloadData];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark--keyboard Noti
- (void)keyboardFrameWillChange:(NSNotification*)notification
{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //当前Cell在屏幕中的坐标值
    CGRect rectInTableView = [self.tableV rectForRowAtIndexPath:self.indexPath];
    CGRect cellRect = [self.tableV convertRect:rectInTableView toView:[self.tableV superview]];
    
    NSLog(@"--%@--%@",NSStringFromCGRect(rectInTableView),NSStringFromCGRect(cellRect));
    
    if (rect.origin.y-200-cellRect.origin.y<0) {
        [self.tableV setContentOffset:CGPointMake(0,-rect.origin.y+cellRect.origin.y+cellRect.size.height+200+self.tableV.contentOffset.y) animated:YES];
    }
    else
    {
        //        [self.tableV setContentOffset:CGPointMake(rectInTableView.origin.x, rectInTableView.origin.y) animated:YES];
    }
}

//保存
-(void)commitAction
{
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]init];
    [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userid"];

    for (int i=0; i<self.dataSource.count; i++) {
        NSArray *array = self.dataSource[i];
        for (int j=0; j<array.count; j++) {
            EditStructM *model = array[j];
            if (model.type!=UserInfoTypeAge) {
                [dicArg setObject:model.content forKey:model.parameter];
            }
        }
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [AFWebAPI modifMyotherInfoWithAry:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            NSDictionary *dic = [object objectForKey:JSON_data];
            
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            [UserInfoManager setUserLoginfo:uinfo];
            [self onGoback];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
}

@end
