/*
 @header  AuthBuyerVC.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/16
 @description
 
 */

#import "AuthBuyerVC.h"
#import "AuthCellA.h"
#import "AuthCellC.h"
#import "AuthCellD.h"
#import "IdentityAuthCell.h"
#import "AuthModel.h"
#import "PublicPickerView.h"
#import "AuthChooseIdentityVC.h"
#import "MyAuthStateVC.h"
#import "PublicWebVC.h"

@interface AuthBuyerVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property (nonatomic,strong)NSMutableArray *dataS;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign)NSInteger imageType;   //图片类型 0：左边。1:右边
@property (nonatomic,assign)UserSubType userType;
@end

@implementation AuthBuyerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self getData];
    
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    if (self.buyType==0) {  //个人
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"个人认证"]];
        self.dataS=[[NSMutableArray alloc]initWithArray:[AuthModel getBuyerPersonDataSource]];
    }
    else if (self.buyType==1)  //企业
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"企业认证"]];
        self.dataS=[[NSMutableArray alloc]initWithArray:[AuthModel getBuyerCompanyDataSource]];
    }
    
    if (self.upgradeDic==nil) {
        return;
    }
    
    AuthStructModel *model4 = self.dataS[3];
    AuthStructModel *model5 = self.dataS[4];
    
        
    model4.content = self.upgradeDic[@"adminnickname"];
    model5.content = self.upgradeDic[@"papers"];
    
    [self getImageWithUrl:self.upgradeDic[@"photourl1"] withType:0];
    [self getImageWithUrl:self.upgradeDic[@"photourl2"] withType:1];

}

-(TouchTableV*)tableV
{
    if (!_tableV) {
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
    IdentityAuthCell *bg = [[IdentityAuthCell alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 320)];
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
    if (model.type==AuthBasicTypeCertificateImage) {
        return 190;
    }
    else if (model.type==AuthBasicTypeLicenseImage)
    {
        return 273;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthStructModel *model = self.dataS[indexPath.row];
    WeakSelf(self);
    if (model.type==AuthBasicTypeLicenseImage) {
        static NSString *identifer = @"AuthCellD";
        AuthCellD *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuthCellD alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        cell.selectPhotoBlock = ^(NSInteger tag) {
            weakself.indexPath=indexPath;
            weakself.imageType=tag;
            [weakself addCertificate];
        };
        cell.downloadCerBlock = ^{
            PublicWebVC *webVC = [[PublicWebVC alloc]initWithTitle:@"下载《委托下单授权书》范本" url:@"http://www.idlook.com/public/authorization/html/index.html"];
            [weakself.navigationController pushViewController:webVC animated:YES];
        };
        [cell reloadUIWithModel:model];
        return cell;
    }
    else if (model.type==AuthBasicTypeCertificateImage)
    {
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
    AuthStructModel *model = self.dataS[indexPath.row];
    AuthBasicType type = model.type;
    WeakSelf(self);
    if (type==AuthBasicTypeOccupation) {
        PublicPickerView *pickerV = [[PublicPickerView alloc] init];
        pickerV.title=@"所属职业";
        pickerV.didSelectBlock = ^(NSString *select) {
            model.content=select;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [pickerV showWithPickerType:PickerTypePostion withDesc:model.content];
    }
    else if (type==AuthBasicTypeCompanyType)
    {
        AuthChooseIdentityVC *chooseVC=[[AuthChooseIdentityVC alloc]init];
        chooseVC.chooseIDTypeBlock = ^(NSInteger type, NSString * _Nonnull name) {
            weakself.userType=type;
            model.content=name;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:chooseVC animated:YES];
    }
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


//提交审核
-(void)submitAuth
{

    NSArray *array = self.dataS;
    NSDictionary *dicArg;    //参数
    NSDictionary *imageDic;  //图片数据
       
    if (self.buyType==0) {  //个人
        for (int i=0; i<array.count-1; i++) {
            AuthStructModel *model = array[i];
            if (model.content.length<=0) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请将%@填写完整～",model.title]];
                return;
            }
        }
        
        AuthStructModel *model1 = array[0];
        AuthStructModel *model2 = array[1];
        AuthStructModel *model3 = array[2];
        AuthStructModel *model4 = array[3];
        
        if (model4.image1==nil || model4.image2==nil) {
            [SVProgressHUD showErrorWithStatus:@"请将证件信息上传完整～"];
            return;
        }
        
        
        dicArg = @{@"buyerId":[UserInfoManager getUserUID],
                   @"buyerIdName":model1.content,
                   @"buyerIdNo":model2.content,
                   @"occupation":model3.content};
        
        imageDic = @{@"frontFile":[PublicManager scaleImageWithSize:1000 image:model4.image1],
                     @"backFile":[PublicManager scaleImageWithSize:1000 image:model4.image2]};
        
        [SVProgressHUD showWithStatus:@"资料上传中，请稍等" maskType:SVProgressHUDMaskTypeClear];

        [AFWebAPI_JAVA getPersonlAuthWithArg:dicArg imageDic:imageDic callBack:^(BOOL success, id  _Nonnull object) {
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
    else
    {
        for (int i=0; i<array.count-2; i++) {
            AuthStructModel *model = array[i];
            if (model.content.length<=0) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请将%@填写完整～",model.title]];
                return;
            }
        }
        
        AuthStructModel *model1 = array[0];
        AuthStructModel *model2 = array[1];
        AuthStructModel *model3 = array[2];
        AuthStructModel *model4 = array[3];
        AuthStructModel *model5 = array[4];
        
        
        AuthStructModel *model6 = array[5];
        AuthStructModel *model7 = array[6];
        
        if (model6.image1==nil || model7.image2==nil) {
            [SVProgressHUD showErrorWithStatus:@"请上传营业执照和委托下单授权书～"];
            return;
        }
        
        if (model6.image1==nil || model7.image2==nil) {
            [SVProgressHUD showErrorWithStatus:@"请将证件信息上传完整～"];
            return;
        }
        
        dicArg = @{@"buyerId":[UserInfoManager getUserUID],
                   @"buyerCompanyName":model1.content,
                   @"buyerCompanyLicense":model2.content,
                   @"buyerCompanyType":model3.content,
                   @"buyerCompanyIdentity":@(self.userType),
                   @"buyerIdName":model4.content,
                   @"buyerIdNo":model5.content,
                   };
        
        //此处压缩一下图片，保证在2m以内
        imageDic = @{@"licenseFile":[PublicManager scaleImageWithSize:1000 image:model6.image1],
                     @"authorizeFile":[PublicManager scaleImageWithSize:1000 image:model6.image2],
                     @"frontFile":[PublicManager scaleImageWithSize:1000 image:model7.image1],
                     @"backFile":[PublicManager scaleImageWithSize:1000 image:model7.image2]
                     };
        
        [SVProgressHUD showWithStatus:@"资料上传中，请稍等" maskType:SVProgressHUDMaskTypeClear];

        [AFWebAPI_JAVA getCompanyAuthWithArg:dicArg imageDic:imageDic callBack:^(BOOL success, id  _Nonnull object) {
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

}


//添加图片
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


//获取身份证图片
-(void)getImageWithUrl:(NSString*)url withType:(NSInteger)type
{

    NSURL *URL = [NSURL URLWithString:url];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        AuthStructModel *model6 = self.dataS[6];
        if(isInCache)
        {
            UIImage *image = nil;
            image =[[manager imageCache] imageFromMemoryCacheForKey:URL.absoluteString];
            if(image)
            {
                if (type==0) {
                    model6.image1 = image;
                }
                else
                {
                    model6.image2=image;
                }
            }
            else
            {
                image = [[manager imageCache] imageFromDiskCacheForKey:URL.absoluteString];
                if(image)
                {
                    if (type==0) {
                        model6.image1 = image;
                    }
                    else
                    {
                        model6.image2=image;
                    }
                }
            }
        }
        else
        {
            [manager downloadImageWithURL: URL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if(image)
                {
                    if (type==0) {
                        model6.image1 = image;
                    }
                    else
                    {
                        model6.image2=image;
                    }
                }
            }];
        }
        [self.tableV reloadData];
    }];
}


@end
