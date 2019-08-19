
//
//  UploadWorksVC.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadWorksVC.h"
#import <AVFoundation/AVFoundation.h>
#import "UploadWorksCellA.h"
#import "UploadWorksCellB.h"
#import "UploadWorksCellC.h"
#import "WorkTypeSelectV.h"
#import "UploadVideoCell.h"
#import "VideoSelVC.h"
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import "UploadWorksVCM.h"


@interface UploadWorksVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UploadWorksCellBDelegate,TableVTouchDelegate,UploadWorksCellCDelegate,TZImagePickerControllerDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property (nonatomic,strong)UIButton *agreeBtn;

@property(nonatomic,assign)NSInteger videType;   //0：图片   1:视频
@property(nonatomic,strong)NSData *videData;

@property(nonatomic,strong)NSMutableArray *photoArray;    //才艺作品，视频数组
@property(nonatomic,strong)NSMutableArray *timeArray;    //才艺作品，视频时间
@property(nonatomic,strong)NSMutableArray *selectedAssets; //才艺作品，图片数组
@property(nonatomic,strong)NSMutableArray *fileDataS;  //视图组data

@property(nonatomic,strong)UploadWorksVCM *dsm;    //数据处理object

@end

@implementation UploadWorksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    if (self.type==WorkTypePerformance) {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"上传试戏作品"]];
    }
    else if (self.type==WorkTypePastworks)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"上传过往作品"]];
    }
    else if (self.type==WorkTypeIntroduction)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"上传自我介绍"]];
    }
    else if (self.type==WorkTypeMordCard)
    {
        if ([UserInfoManager getUserMastery]==2) {
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"上传剧照"]];
        }
        else
        {
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"上传模特卡"]];
        }
    }
    
    self.photoArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.selectedAssets=[[NSMutableArray alloc]initWithCapacity:0];
    self.fileDataS=[[NSMutableArray alloc]initWithCapacity:0];
    self.timeArray =[[NSMutableArray alloc]initWithCapacity:0];
    
    [self dsm];
    
    [self tableV];
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//上传
-(void)upload
{
    //试戏作品
    if (self.type==WorkTypePerformance) {
        
        UploadWorksCellA *cellA1 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        UploadWorksCellA *cellA2 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        UploadWorksCellA *cellA3 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

        if ([self.videData length]<=0){
            [SVProgressHUD showImage:nil status:@"请添加试戏作品"];
            return;
        }
        
        if (cellA1.textField.text.length==0) {
            [SVProgressHUD showImage:nil status:@"请输入作品标题"];
            return;
        }
        
        if (cellA2.textField.text.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择作品类型"];
            return;
        }
        
        if (cellA3.textField.text.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择作品关键词"];
            return;
        }
        
        if (self.agreeBtn.selected==NO) {
            [SVProgressHUD showImage:nil status:@"请同意授权上传作品给脸探肖像平台"];
            return;
        }
        
        [SVProgressHUD showWithStatus:@"正在上传，请稍等!" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dic = @{@"userid":[UserInfoManager getUserUID],
                                 @"title":cellA1.textField.text,
                                 @"videotype":cellA2.textField.text,
                                 @"keyword":[cellA3.textField.text stringByReplacingOccurrencesOfString:@"、" withString:@"|"]};
        
        NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
        if ([UserInfoManager getUserMastery]==2) {
            UploadWorksCellA *cellA4 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];

//            if (cellA4.textField.text.length==0) {
//                [SVProgressHUD showImage:nil status:@"请选择作品角色"];
//                return;
//            }
            
            NSInteger mastery=0;
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if ([dic[@"attrname"] isEqualToString:cellA4.textField.text]) {
                    mastery = [dic[@"attrid"] integerValue];
                }
            }
            [dicArg setObject:@(mastery) forKey:@"role"];
        }
        
        [AFWebAPI uploadWorksWithArg:dicArg withDataArr:@[self.videData] callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"上传成功！"];
                [self onGoback];
                self.saveRefreshUI();
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
        
    }
    else if(self.type==WorkTypePastworks)    //过往作品
    {
        UploadWorksCellA *cellA1 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        UploadWorksCellA *cellA2 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        UploadWorksCellA *cellA3 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

        if ([self.videData length]<=0)
        {
            [SVProgressHUD showImage:nil status:@"请添加过往作品"];
            return;
        }
        
        if (cellA1.textField.text.length==0) {
            [SVProgressHUD showImage:nil status:@"请输入作品标题"];
            return;
        }
        
        if (cellA2.textField.text.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择作品类型"];
            return;
        }
        
        if (cellA3.textField.text.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择作品关键词"];
            return;
        }
        
        if (self.agreeBtn.selected==NO) {
            [SVProgressHUD showImage:nil status:@"请同意授权上传作品给脸探肖像平台"];
            return;
        }
        
        [SVProgressHUD showWithStatus:@"正在上传，请稍等!" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dic = @{@"userid":[UserInfoManager getUserUID],
                                 @"title":cellA1.textField.text,
                                 @"type":@(self.videType+1),
                                 @"producetype":cellA2.textField.text,
                                 @"keyword":[cellA3.textField.text stringByReplacingOccurrencesOfString:@"、" withString:@"|"]};

        NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
        if ([UserInfoManager getUserMastery]==2) {
            UploadWorksCellA *cellA4 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
            
//            if (cellA4.textField.text.length==0) {
//                [SVProgressHUD showImage:nil status:@"请选择作品角色"];
//                return;
//            }
            
            NSInteger mastery=0;
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if ([dic[@"attrname"] isEqualToString:cellA4.textField.text]) {
                    mastery = [dic[@"attrid"] integerValue];
                }
            }
            [dicArg setObject:@(mastery) forKey:@"role"];
        }
        
        
        [AFWebAPI getUploadPastworkWithArg:dicArg data:self.videData callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"上传成功！"];
                [self onGoback];
                self.saveRefreshUI();
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    else if(self.type==WorkTypeIntroduction || self.type==WorkTypeMordCard)    //自我介绍,模特卡
    {
        UploadWorksCellA *cellA1 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        UploadWorksCellA *cellA2 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        
        if ([self.videData length]<=0)
        {
            if (self.type==WorkTypeIntroduction) {
                [SVProgressHUD showImage:nil status:@"请添加自我介绍"];
            }
            else if (self.type==WorkTypeMordCard)
            {
                if ([UserInfoManager getUserMastery]==2)
                {
                    [SVProgressHUD showImage:nil status:@"请添加剧照"];
                }
                else
                {
                    [SVProgressHUD showImage:nil status:@"请添加模特卡"];
                }
                
            }
            return;
        }
        
        if (self.type==WorkTypeMordCard&&[UserInfoManager getUserMastery]==2){
            if (cellA1.textField.text.length==0) {
                [SVProgressHUD showImage:nil status:@"请选择剧照类型"];
                return;
            }
            if (cellA2.textField.text.length==0) {
                [SVProgressHUD showImage:nil status:@"请选择剧照关键词"];
                return;
            }
        }
        else
        {
            if (cellA1.textField.text.length==0) {
                [SVProgressHUD showImage:nil status:@"请选择形象类型"];
                return;
            }
            if (cellA2.textField.text.length==0) {
                [SVProgressHUD showImage:nil status:@"请选择形象关键词"];
                return;
            }
        }
        
        [SVProgressHUD showWithStatus:@"正在上传，请稍等" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dic = @{@"userid":[UserInfoManager getUserUID],
                              @"type":cellA1.textField.text,
                              @"keyword":[cellA2.textField.text stringByReplacingOccurrencesOfString:@"、" withString:@"|"],
                              @"cardorvideo":self.type==WorkTypeIntroduction?@(2):@(1)};
        
        NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
        if ([UserInfoManager getUserMastery]==2&&self.type==WorkTypeMordCard) {
            UploadWorksCellA *cellA3 = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            
//            if (cellA3.textField.text.length==0) {
//                [SVProgressHUD showImage:nil status:@"请选择剧照角色"];
//                return;
//            }
            
            NSInteger mastery=0;
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if ([dic[@"attrname"] isEqualToString:cellA3.textField.text]) {
                    mastery = [dic[@"attrid"] integerValue];
                }
            }
            [dicArg setObject:@(mastery) forKey:@"role"];
        }
        
        [AFWebAPI addmodelcardWithArg:dicArg data:self.videData callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                self.saveRefreshUI();
                [self onGoback];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
}

-(UploadWorksVCM*)dsm
{
    if (!_dsm) {
        _dsm = [[UploadWorksVCM alloc]init];
        [_dsm refreshDataWithType:self.type];
    }
    return _dsm;
}

//同意协议
-(void)agreeAction:(UIButton*)sender
{
    sender.selected=!sender.selected;
}

-(UIView*)tableFootV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 110)];
    
    UIButton *uploadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [bg addSubview:uploadBtn];
    uploadBtn.layer.cornerRadius=5.0;
    uploadBtn.layer.masksToBounds=YES;
    uploadBtn.backgroundColor=Public_Red_Color;
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(15);
        make.height.mas_equalTo(48);
        if (self.type==WorkTypePerformance || self.type==WorkTypePastworks) {
            make.top.mas_equalTo(bg).offset(48);
        }
        else
        {
            make.top.mas_equalTo(bg).offset(30);
        }
    }];
    [uploadBtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"works_agree_n"] forState:UIControlStateNormal];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"works_agree_h"] forState:UIControlStateSelected];
    [bg addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_left).offset(15);
        make.top.mas_equalTo(bg).offset(18);
    }];
    agreeBtn.selected=YES;
    [agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn.hidden=YES;
    self.agreeBtn=agreeBtn;
    
    UILabel *agreeLab= [[UILabel alloc]init];
    agreeLab.text=@"本人同意并授权上传的作品给脸探肖像平台";
    agreeLab.font=[UIFont systemFontOfSize:13];
    agreeLab.textColor=[UIColor colorWithHexString:@"#9B9B9B"];
    [bg addSubview:agreeLab];
    [agreeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(agreeBtn);
        make.left.mas_equalTo(agreeBtn.mas_right).offset(3);
    }];
    agreeLab.hidden=YES;
    
    if (self.type==WorkTypePerformance || self.type==WorkTypePastworks) {
        agreeBtn.hidden=NO;
        agreeLab.hidden=NO;
    }
    return bg;
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.touchDelegate=self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
        _tableV.tableFooterView = [self tableFootV];
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
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
    return self.dsm.ds.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger row = indexPath.row;
    return [[(NSDictionary *)self.dsm.ds[row] objectForKey:UploadWorksVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dsm.ds[row] objectForKey:UploadWorksVCMCellClass];
    
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    
    if ([classStr isEqualToString:@"UploadWorksCellC"]) {
        UploadWorksCellC *cell = (UploadWorksCellC *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        NSArray *array =  [(NSDictionary *)self.dsm.ds[row] objectForKey:UploadWorksVCMCellData];
        [cell reloadUIWithArray:array withTimes:self.timeArray];
    }
    else if ([classStr isEqualToString:@"UploadWorksCellB"])
    {
        UploadWorksCellB *cell = (UploadWorksCellB *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        
        NSDictionary *dic =  [self.dsm.ds[row] objectForKey:UploadWorksVCMCellData];
        UIImage *image = dic[@"image"];
        [cell reloadUIType:self.type withImage:image withTime:dic[@"time"]];
    }
    else if ([classStr isEqualToString:@"UploadWorksCellA"])
    {
        UploadWorksCellA *cell = (UploadWorksCellA *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textFieldChangeBlock = ^(NSString *text) {
            
        };
        
        NSDictionary *dic =  [(NSDictionary *)self.dsm.ds[row] objectForKey:UploadWorksVCMCellData];
        [cell reloadUIWithDic:dic];
    }
//    else if ([classStr isEqualToString:@"UploadVideoCell"])
//    {
//        UploadVideoCell *cell = (UploadVideoCell *)obj;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        WeakSelf(self);
//        cell.addVideoAction = ^{
//            [weakself addVideoAndPhotoWithType:2];
//        };
//        NSDictionary *dic =  [self.dsm.ds[row] objectForKey:UploadWorksVCMCellData];
//        [cell reloadUIWithDic:dic];
//    }
    return obj;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0) {
        NSDictionary *dic =  [(NSDictionary *)self.dsm.ds[indexPath.row] objectForKey:UploadWorksVCMCellData];
        NSString *title = dic[@"title"];
        BOOL isEdit = [dic [@"isEdit"] boolValue];
        if (isEdit==NO) {
            NSInteger type=0;
            if ([title isEqualToString:@"作品类型"]||[title isEqualToString:@"形象类型"]||[title isEqualToString:@"剧照类型"]) {
                type=0;
            }
            else if ([title isEqualToString:@"作品角色"]||[title isEqualToString:@"剧照角色"])
            {
                type=2;
            }
            else
            {
                type=1;
            }
            UploadWorksCellA *cell = [tableView cellForRowAtIndexPath:indexPath];
            WorkTypeSelectV *selectV=[[WorkTypeSelectV alloc]init];
            selectV.keywordSelectAction = ^(NSString *content) {
                cell.textField.text=content;
            };
            NSArray* array;
            if ([cell.textField.text length]) {
                array=[cell.textField.text componentsSeparatedByString:@"、"];
            }
            [selectV showWithSelectArray:array withType:type withTitle:title];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark--
#pragma mark---UploadWorksCellCDelegate
-(void)addVideAction   //才艺作品添加视频
{
    [self addVideoWithType:1 withMaxCount:6];
}

//删除视频
-(void)delectActionWithRow:(NSInteger)row
{
    if (self.photoArray.count>row) {
        [self.photoArray removeObjectAtIndex:row];
        [self.selectedAssets removeObjectAtIndex:row];
        [self.timeArray removeObjectAtIndex:row];
        [self.fileDataS removeObjectAtIndex:row];
        
        [self.dsm changeHeightWithPhotos:self.photoArray];
        [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark--
#pragma mark---UploadWorksCellBDelegate
//添加视频或者照片
- (void)addVideoAndPhotoWithType:(NSInteger)type
{
    [self addVideoWithType:0 withMaxCount:1];
}

//添加视频，图片。type=0:视频。type=1:图片。type=2:图片+视频
-(void)addVideoWithType:(NSInteger)type withMaxCount:(NSInteger)max
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:max columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.selectedAssets = self.selectedAssets;
    
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
    if (self.type==WorkTypePerformance ||self.type==WorkTypeIntroduction) {  //视频
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = NO;
    }
    else if (self.type==WorkTypeMordCard)   //图片
    {
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
    }
    else if(self.type==WorkTypePastworks)  //视频+图片
    {
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = YES;
    }
    
    imagePickerVc.allowPickingOriginalPhoto = NO;   //是否能选原图
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = NO;
    
    // 设置首选语言 / Set preferred language
    imagePickerVc.preferredLanguage = @"zh-Hans";
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        PHAsset *fileasset = [assets firstObject];
        UIImage *image = photos.firstObject;
        if (fileasset.mediaType==PHAssetMediaTypeImage) {
            self.videData = UIImageJPEGRepresentation(image, 1.0);
            self.videType=0;
            [self.dsm addVideoOrPhotoChangeData:image withTime:@"" withType:self.type];
            [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        NSTimeInterval time = asset.duration;
        int times = round(time);
        self.videType=1;
        [self.dsm addVideoOrPhotoChangeData:coverImage withTime:[PublicManager timeFormatted:times] withType:self.type];
        [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //视频PHAsset转nsdata
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.networkAccessAllowed = true;  //允许网络视频加载
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *url = urlAsset.URL;
            NSData *data = [NSData dataWithContentsOfURL:url];
            self.videData=data;
        }];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)analysFileData
{
    [self.timeArray removeAllObjects];
    [self.fileDataS removeAllObjects];

    for (int i =0; i<self.selectedAssets.count; i++) {
        
        PHAsset *fileasset = self.selectedAssets[i];
        NSTimeInterval time = fileasset.duration;
        int times = round(time);
        [self.timeArray addObject:[PublicManager timeFormatted:times]];
        
        //视频PHAsset转nsdata
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        options.networkAccessAllowed = true;
        
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:fileasset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *url = urlAsset.URL;
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            [self.fileDataS addObject:data];
        }];
    }
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
