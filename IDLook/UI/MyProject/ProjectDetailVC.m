//
//  ProjectDetailVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectDetailVC.h"
#import "TZImagePickerController.h"
#import "ProjectModel.h"
#import "ProjectNumberCell.h"
#import "ProjectDescCell.h"
#import "ProjectOptionsCell.h"
#import "DatePickPopV.h"
#import "CitySelectStep1.h"
#import "UseSelectPopView.h"
#import "ProjectEnsureCell.h"
#import "ProjectScreenCell.h"
#import "mediaModel.h"
#import "LookBigImageVC.h"
#import "VideoPlayer.h"
@interface ProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource,ProjectDescCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,TableVTouchDelegate,ProjectOptionsCellDelegate,ProjectScreenCellDelegate,ProjectEnsureCellDelegate>
{
    VideoPlayer *_player;
}
@property(nonatomic,copy)NSString *navTitle;
@property (weak, nonatomic) IBOutlet UIView *checkView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UILabel *projectNum;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *photoArray;    //脚本，图片数组
@property(nonatomic,strong)NSMutableArray *selectedAssets; //脚本，图片数组
@property(nonatomic,strong)ProjectModel *projectModel;
@end

@implementation ProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.selectedAssets=[[NSMutableArray alloc]initWithCapacity:0];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
          if (_type==1) {
            self.model = [ProjectModel new];
            self.navTitle = _isAudition?[NSString stringWithFormat:@"新建拍摄项目"]:[NSString stringWithFormat:@"新建试镜项目"];
        }else if (_type==2){
            self.navTitle = _isAudition?[NSString stringWithFormat:@"编辑拍摄项目"]:[NSString stringWithFormat:@"编辑试镜项目"];
         }else{
            self.navTitle = _isAudition?[NSString stringWithFormat:@"查看拍摄项目"]:[NSString stringWithFormat:@"查看试镜项目"];
            }
    if(_type!=1){//查看和编辑需要带图片
          NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        if (!_isAudition) {//试镜类数据装载
            //装载视频图片（视频图片有专门的播放链接和首帧图片链接，此处只拿图片链接）
        //  NSArray *videos = [_model.annex objectForKey:@"vdo"];
         __block   NSInteger screenCount = _model.vdo.count+_model.img.count;
            for(int i=0;i<_model.vdo.count;i++){
                NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                    NSString *videoUrl = _model.vdo[i][@"cuturl"];
                    NSString *videoPlayerUrl = _model.vdo[i][@"videourl"];
                    NSString *videoId = _model.vdo[i][@"id"];
                    NSString *duration =[NSString stringWithFormat:@"%@",_model.vdo[i][@"duration"]];
                    UIImage *videoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.vdo[i][@"cuturl"]]]];
              
                    if(!videoImg){
                        videoImg = [UIImage imageNamed:@"default_home"];
                    }
                    NSDictionary *videoModelDic = @{@"type":[NSNumber numberWithInt:mediaTypeVideoOld],@"image":videoImg,@"url":videoUrl,@"id":videoId,@"duration":duration,@"videourl":videoPlayerUrl};
                        dispatch_async(dispatch_get_main_queue(), ^{
                           screenCount--;
                            if (videoUrl.length>5) {
                                [self.selectedAssets addObject:videoImg];
                                [self.photoArray addObject:[mediaModel yy_modelWithDictionary:videoModelDic]];
                                
                                if (screenCount==0) {
                                    [self sortPhotoArray];
                                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                                }
                            }
                       } );
                 }];
                [queue addOperation:op];
            }
            //装载图片
           //  NSArray *imgs = [_model.annex objectForKey:@"img"];
          
            for(int i=0;i<_model.img.count;i++){
                NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                    NSString *url = _model.img[i][@"imageurl"];
                     NSString *imageId = _model.img[i][@"id"];
                    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                if(!img){
                        img = [UIImage imageNamed:@"default_home"];
                    }
                        NSDictionary *imageModelDic = @{@"type":[NSNumber numberWithInt:mediaTypePhotoOld],@"image":img,@"url":url,@"id":imageId};
                        dispatch_async(dispatch_get_main_queue(), ^{
                           screenCount--;
                            if (url.length>5) {
                                [self.selectedAssets addObject:img];
                                [self.photoArray addObject:[mediaModel yy_modelWithDictionary:imageModelDic]];
                               
                                if (screenCount==0) {
                                    [self sortPhotoArray];
                                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                                }
                            }
                         } );
                  
                }];
                [queue addOperation:op];
            }
           
        }else{//拍摄类数据装载
      
        NSArray *urls = [_model.url componentsSeparatedByString:@"|"];
        for(int i=0;i<urls.count;i++){
            NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                NSString *url = urls[i];
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
             
                if(!img){
                    img = [UIImage imageNamed:@"default_home"];
                }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (url.length>5) {
                            NSDictionary *imageModelDic = @{@"type":[NSNumber numberWithInt:mediaTypePhotoOld],@"image":img,@"url":url};
                            [self.selectedAssets addObject:img];
                            [self.photoArray addObject:[mediaModel yy_modelWithDictionary:imageModelDic]];
                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                        }
                      
                    } );
                
                }];
            [queue addOperation:op];
        }
        }
        
    }
   
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:_navTitle]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
   
        if (_type == 3) {//查看
            self.editView.hidden = YES;
        }else if(_type == 1){//新建则没有编号
            self.tableView.y=0;
self.checkView.hidden = YES;
            self.tableView.height+=42;
        }else{//编辑
            self.projectNum.text = _model.projectid;
        }
    
}
#pragma mark---PlaceAuditCellECDelegate
-(void)addAction   //才艺作品添加视频
{
    NSInteger maxCount = 9;
    NSInteger oldCount = 0;
    for (mediaModel *model in _photoArray) {
        if (model.type==mediaTypePhotoOld || model.type==mediaTypeVideoOld) {
            oldCount++;
        }
    }
    if (_type==2) {//编辑页面进来需要减去原本存在的img
       maxCount = 9-oldCount;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    NSMutableArray *PHAssetArray = [NSMutableArray new];
    for (id anything in _selectedAssets) {//编辑界面进来，第一次添加图片可能数组装的是image(因为已经有图片了)，所以全部转PHAsset
        if (![anything isKindOfClass:[UIImage class]]) {
            [PHAssetArray addObject:anything];
        }
    }
    imagePickerVc.selectedAssets = PHAssetArray;
    
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
//        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = _isAudition?NO:YES;//试镜可选视频，拍摄不能选视频
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = YES; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = NO;
    
    // 设置首选语言 / Set preferred language
    imagePickerVc.preferredLanguage = @"zh-Hans";
    
#pragma mark - 到这里为止
    
 
           // NSTimeInterval time = asset.duration;
            //int times = round(time);
  
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeClear];
       //去掉相册选择的model
        NSMutableArray *newArr = [NSMutableArray new];
        for(int i=0; i<_photoArray.count;i++){
            mediaModel *model = _photoArray[i];
            if (model.type==0 || model.type==2) {
                [newArr addObject:model];
            }
        }
        self.photoArray = [NSMutableArray arrayWithArray:newArr];
        [self.selectedAssets setArray:assets];
        //photoArray只是加了视频图片但没有加视频的data
        //装载新的model
        WeakSelf(self);
   __block NSInteger loadCount = 0;
     for (int i=0; i<assets.count;i++) {
                PHAsset *PHAsset =assets[i];
                UIImage *photo = photos[i];
                if (PHAsset.mediaType==2) {//视频
                    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
                    options.version = PHImageRequestOptionsVersionCurrent;
                    options.networkAccessAllowed = true;  //允许网络视频加载
                    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                   PHImageManager *manager = [PHImageManager defaultManager];
                   [manager requestAVAssetForVideo:PHAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                            AVURLAsset *urlAsset = (AVURLAsset *)asset;
                            NSURL *url = urlAsset.URL;
                            NSData *data = [NSData dataWithContentsOfURL:url];
                            NSDictionary *videoModelDic = @{@"type":[NSNumber numberWithInt:mediaTypeVideoNew],@"image":photo,@"data":data,@"PHAssetDate":PHAsset.creationDate,@"duration":[NSString stringWithFormat:@"%f",PHAsset.duration],@"id":@""};
                            [weakself.photoArray addObject:[mediaModel yy_modelWithDictionary:videoModelDic]];
                            loadCount++;
                       if (loadCount == assets.count) {
                           [weakself upLoadShootMedia];
                       }
                        }];
                    
                 
                }else{//图片
                    NSDictionary *imageModelDic = @{@"type":[NSNumber numberWithInt:mediaTypePhotoNew],@"image":photo,@"PHAssetDate":PHAsset.creationDate,@"id":@""};
                    [self.photoArray addObject:[mediaModel yy_modelWithDictionary:imageModelDic]];
                    loadCount++;
                    if (loadCount == assets.count) {
                         [weakself upLoadShootMedia];
                    }
                }
                
            }
     
      }];
  
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)upLoadShootMedia
{
    //当全部装载完成再执行像后端传值的操作
  //如果是试镜 需要提前上传视频、图片
    //先排序再装id，不然因为网络原因可能导致装的id混淆
    [self sortPhotoArray];
        if (!_isAudition) {
           
            WeakSelf(self);
            for(mediaModel *model in _photoArray){
                
                if (model.type==mediaTypeVideoNew) {
                    [AFWebAPI upLoadShootVideoWithArg:[NSDictionary dictionaryWithObject:[UserInfoManager getUserUID] forKey:@"buyerid"] videoArray:[NSArray arrayWithObject:model.data] callBack:^(BOOL success, id object) {
                        NSLog(@"obj  is %@",object);
                        if ([object[@"msg"] isEqualToString:@"OK"]) {
                            NSArray *videoDics = object[@"data"][@"vdo"];
                            if (videoDics.count>0) {
                                NSDictionary *videoDic = [videoDics objectAtIndex:0];
                                NSString *videoId = [videoDic objectForKey:@"id"];
                                model.id = videoId;//给视频模型装id
                                }
                        }
                        }];
                }
                if (model.type==mediaTypePhotoNew) {
                    [AFWebAPI upLoadShootImageWithArg:[NSDictionary dictionaryWithObject:[UserInfoManager getUserUID]forKey:@"buyerid"] mageArray:[NSArray arrayWithObject:model.image] callBack:^(BOOL success, id object) {
                        NSLog(@"obj  is %@",object);
                        if ([object[@"msg"] isEqualToString:@"OK"]) {
                            NSArray *imgDics = object[@"data"][@"img"];
                            if (imgDics.count>0) {
                                NSDictionary *imageDic = [imgDics objectAtIndex:0];
                                NSString *imageId = [imageDic objectForKey:@"id"];
                                model.id = imageId;//给图片模型装id
                                
                            }
                            
                        }
                    }];
                }
                
            }
            }
   
  
    dispatch_async(dispatch_get_main_queue(), ^{
         [SVProgressHUD showSuccessWithStatus:@"上传成功"];
         [self.tableView reloadData];
    });
    
}
//删除图片
-(void)delectWithRow:(NSInteger)row
{
    if (self.photoArray.count>row) {
        mediaModel *deleteModel = _photoArray[row];
        if (deleteModel.type==mediaTypePhotoNew || deleteModel.type==mediaTypeVideoNew) {
            for (int i=0;i<_selectedAssets.count;i++) {
                PHAsset *set = _selectedAssets[i];
                if ([set.creationDate isEqualToDate:deleteModel.PHAssetDate]) {//说明删除了相册中选中的视频或图片
                    [_selectedAssets removeObjectAtIndex:i];
                }
            }
        }
       
        [self.photoArray removeObjectAtIndex:row];
[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
       }
}
//查看大图
-(void)chekBigImageWithRow:(NSInteger)row
{
    if (_type==1 || _type==2) {//新建,n编辑 不能查看图片
        return;
    }
    mediaModel *clickModel = _photoArray[row];
    if (clickModel.type<2) {
        //说明点击的是视频
        [self playWorkVideoWithUrl:clickModel.videourl];
        return;
    }
    //图片
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    lookImage.downPhotoBlock = ^(NSInteger index) {};

    //装载所有图片类url
    NSMutableArray *urls = [NSMutableArray new];
    for (int i = 0;i<_photoArray.count;i++) {
        mediaModel *model = _photoArray[i];
      if (model.type>1) {
            [urls addObject:model.url];
        }
      }
    for(int j =0;j<urls.count;j++){
        NSString *url = urls[j];
        if ([url isEqualToString:clickModel.url]) {//确定点击图片在新数组中的下标
            row = j;
        }
    }
            [lookImage showWithImageArray:urls curImgIndex:row AbsRect:CGRectMake(0, 0,0,0)];
            [self.navigationController pushViewController:lookImage animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
  
        if (indexPath.section==0){
        ProjectDescCell *descCell = [ProjectDescCell cellWithTableView:tableView];
       
        descCell.textViewChangeBlock = ^(NSString * _Nonnull text) {
            weakself.model.desc = text;
            };
        descCell.textFieldChangeBlock = ^(NSString * _Nonnull text) {
            weakself.model.name = text;
            };
        descCell.model = _model;
        if (_type==3) {
            descCell.checkStyle = YES;
        }
#warning --装载图片cell数据
//        NSMutableArray *images = [NSMutableArray new];
//        for (mediaModel *model in _photoArray) {
//            [images addObject:model.image];
//        }
        [descCell reloadUIWithArray:_photoArray withAssets:self.selectedAssets];
       
        descCell.delegate = self;
        
        return descCell;
    }else if(indexPath.section==1){
        if (_isAudition) {//注入拍摄类cell
            ProjectOptionsCell *optionsCell = [ProjectOptionsCell cellWithTableView:tableView];
            optionsCell.delegate = self;
           optionsCell.model = _model;
            if (_type==3) {
                optionsCell.checkStyle = YES;
            }
           optionsCell.actionType = ^(NSInteger actionType) {
                if(actionType == actionTypeStartDay){
                    NSDate *minimumDate = [NSDate date];
                    NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
                    // NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*_model.auditiondays*2)];
                    DatePickPopV *popV = [[DatePickPopV alloc]init];
                    [popV showWithMinDate:minimumDate maxDate:maximumDate];
                    popV.dateString = ^(NSString * _Nonnull str) {
                        if ([weakself.model.start isEqualToString:str]) {//选了一样的天数 不操作
                            
                        }else{//选择了不一样的天数
                        weakself.model.start = str;
                            weakself.model.end = @"";
                        }
//                        weakself.model.end = [self start:str WithAudition:_model.auditiondays];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
                    };
                }else if(actionType == actionTypeEndDay){
                    NSDate *minimumDate = [self dateWithString:_model.start];//[self minStart:_model.start WithAudition:_model.auditiondays];
                    NSDate *maximumDate = [self start:_model.start WithAudition:_model.auditiondays];
                    DatePickPopV *popV = [[DatePickPopV alloc]init];
                    [popV showWithMinDate:minimumDate maxDate:maximumDate];
                    popV.dateString = ^(NSString * _Nonnull str) {
                       weakself.model.end = str;
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
                    };
                }
            };
            return optionsCell;
        }else{//注入试镜类cell
            ProjectScreenCell *screenCell = [ProjectScreenCell cellWithTableView:tableView];
            screenCell.delegate = self;
            if (_type==3) {
                screenCell.checkStyle = YES;
            }
            screenCell.model = _model;
            
            return screenCell;
        }
        
    }else{
        if (_type == 3) {//查看类无按钮cell
            UITableViewCell *noneCell = [UITableViewCell new];
            return noneCell;
        }
       ProjectEnsureCell *ensureCell = [ProjectEnsureCell cellWithTableView:tableView];
        if (_type==2) {//编辑是保存
            ensureCell.btnTitle = @"保存";
        }
        if (_type==1) {//新建是“保存并使用”
             ensureCell.btnTitle = @"保存";
        }
        ensureCell.delegate = self;
        return ensureCell;
    }
}
#pragma -optionCellDelegate 拍摄项目的选项代理
-(void)ProjectOptionsCellSelectOptionWithType:(NSInteger)type
{
    WeakSelf(self);
    if(type == actionTypeDays){
        UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
        NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
        popv.dataSource = [NSArray arrayWithObjects:@"1天",@"2天",@"3天",@"4天",@"5天",nil];
        popv.title = @"拍摄天数";
        popv.selectStr = [NSString stringWithFormat:@"%ld天",(long)_model.auditiondays];
        [popv initSubviews];
        popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
              NSString *auditionsDay = [string stringByReplacingOccurrencesOfString:@"天" withString:@""];
            if (weakself.model.auditiondays != [auditionsDay integerValue]) {
                weakself.model.auditiondays = [auditionsDay integerValue];
                weakself.model.end = @"";
                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
            }
          };
    }
    else if(type == actionTypeCity){
    //selectedArr  artistRegin 演员所在地
    CitySelectStep1 *cityStep = [CitySelectStep1 new];
    cityStep.selectedArr = [_model.city componentsSeparatedByString:@"、"];
    cityStep.hidesBottomBarWhenPushed=YES;
    cityStep.selectCity = ^(NSString *city) {
        //取出选择的城市，用、
        weakself.model.city = city;
        [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForItem:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:cityStep animated:YES];
    }else if (type == actionTypeUseTime){
        UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
        NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
        popv.dataSource = [NSArray arrayWithObjects:@"1年",@"2年",@"3年",@"4年",@"5年",nil];
        popv.title = @"肖像周期";
        popv.selectStr = _model.shotcycle;
        [popv initSubviews];
        popv.selectID = ^(NSString * _Nonnull string) {//选择的周期和范围
            weakself.model.shotcycle = string;
             [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForItem:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }else if (type == actionTypeUseRange){
        UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
        popv.dataSource = [NSArray arrayWithObjects:@"中国大陆",@"港澳台",@"海外其他",nil];
        popv.title = @"肖像范围";
         popv.selectStr = _model.shotregion;
        [popv initSubviews];
        popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
              weakself.model.shotregion = string;
             [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForItem:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
}
#pragma-mark ProjectScreenCell 试镜类项目的选项代理
-(void)ProjectScreenCellSelectOptionWithType:(NSInteger)type
{
    WeakSelf(self);
  if(type == TypeLatestDay)  //最晚上传作品日期
  {
      NSDate *minimumDate = [NSDate date];
      NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
      DatePickPopV *popV = [[DatePickPopV alloc]init];
      [popV showWithMinDate:minimumDate maxDate:maximumDate];
      popV.dateString = ^(NSString * _Nonnull str) {
            weakself.model.auditionend = str;
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
      };
  }else if (type == TypeShootDays){//拍摄天数
      UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
      NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
      popv.dataSource = [NSArray arrayWithObjects:@"1天",@"2天",@"3天",@"4天",@"5天",nil];
      popv.title = @"拍摄天数";
      popv.selectStr = [NSString stringWithFormat:@"%ld天",(long)_model.auditiondays];
      [popv initSubviews];
      popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
    NSString *auditionsDay = [string stringByReplacingOccurrencesOfString:@"天" withString:@""];
          if (weakself.model.auditiondays != [auditionsDay integerValue]) {
              weakself.model.auditiondays = [auditionsDay integerValue];
              weakself.model.end = @"";
               [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
          }
          
         };
  }else if (type == TypeCity)//拍摄城市
  {
      //selectedArr  artistRegin 演员所在地
      CitySelectStep1 *cityStep = [CitySelectStep1 new];
      cityStep.selectedArr = [_model.city componentsSeparatedByString:@"、"];
      cityStep.hidesBottomBarWhenPushed=YES;
      cityStep.selectCity = ^(NSString *city) {
          //取出选择的城市，用、
          weakself.model.city = city;
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
      };
      [self.navigationController pushViewController:cityStep animated:YES];
  }else if (type == TypeStartDay){//开始日期
      NSDate *minimumDate = [NSDate date];
      NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
      DatePickPopV *popV = [[DatePickPopV alloc]init];
      [popV showWithMinDate:minimumDate maxDate:maximumDate];
      popV.dateString = ^(NSString * _Nonnull str) {
          if ([weakself.model.start isEqualToString:str]) {//选了一样的天数 不操作
              
          }else{//选择了不一样的天数
              weakself.model.start = str;
              weakself.model.end = @"";
          }
        [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
      };
  }else if (type == TypeEndDay)//结束日期
  {
      NSDate *minimumDate = [self dateWithString:_model.start];//[self minStart:_model.start WithAudition:_model.auditiondays];
      NSDate *maximumDate = [self start:_model.start WithAudition:_model.auditiondays];
      DatePickPopV *popV = [[DatePickPopV alloc]init];
      [popV showWithMinDate:minimumDate maxDate:maximumDate];
      popV.dateString = ^(NSString * _Nonnull str) {
          weakself.model.end = str;
          [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
      };
  }
    
  
    }
#pragma - mark ensureCellDelegate    确认按钮点击后/接口
-(void)ProjectEnsureCellClicked
{
    if (_model.name.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写项目名称"];
        return;
    }
    if (_model.desc.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写项目简介"];
        return;
    }
    if (_model.auditionend.length==0 && !_isAudition) {
        [SVProgressHUD showImage:nil status:@"请填写最晚上传作品日期"];
        return;
    }
    if (_model.auditiondays==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄天数"];
        return;
    }
    if (_model.city.length == 0) {
        [SVProgressHUD showImage:nil status:@"请选择城市"];
        return;
    }
    if (_model.start.length==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄开始日期"];
        return;
    }
    if (_model.end.length==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄结束日期"];
        return;
    }
  
    if (_isAudition) {
        if (_model.shotcycle.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择肖像周期"];
            return;
        }
        if (_model.shotregion.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择肖像范围"];
            return;
        }
    }
    if (!_isAudition) {
       if (_model.auditionend.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择最晚上传作品日期"];
            return;
        }
    }
   
    NSMutableDictionary *projectDic = [NSMutableDictionary new];
    [projectDic setObject:_model.name forKey:@"name"];
    [projectDic setObject:_model.desc forKey:@"desc"];
    [projectDic setObject:_model.city forKey:@"city"];
    [projectDic setObject:_model.start forKey:@"start"];
    [projectDic setObject:_model.end forKey:@"end"];
    [projectDic setObject:[NSString stringWithFormat:@"%ld",(long)_model.auditiondays] forKey:@"days"];
    [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeClear];

    //厘清4种media
    //老照片//老视频//新照片//新视频
    NSMutableArray *oldPhotos = [NSMutableArray new];
    NSMutableArray *oldVideos = [NSMutableArray new];
    NSMutableArray *newPhotos = [NSMutableArray new];
    NSMutableArray *newVideos = [NSMutableArray new];
    for (mediaModel *model in _photoArray) {
        if (model.type==mediaTypePhotoOld) {
            [oldPhotos addObject:model.url];
        }
        else if (model.type==mediaTypeVideoOld) {
            [oldVideos addObject:model.url];
        }
        else if (model.type==mediaTypePhotoNew){
            [newPhotos addObject:model.image];
        }
        else if (model.type==mediaTypeVideoNew){
            [newVideos addObject:model.data];
        }
    }
    if(_type == 1){//新建
        [projectDic setObject:[UserInfoManager getUserUID] forKey:@"userid"];
        if (_isAudition) {//拍摄  新图片
             [projectDic setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
            [projectDic setObject:_model.shotcycle forKey:@"cycle"];
            [projectDic setObject:_model.shotregion forKey:@"region"];
          [AFWebAPI addProjectWithArg:projectDic imageArray:newPhotos callBack:^(BOOL success, id  object) {
              if (success) {
                  NSLog(@"response is %@",object);
                  ProjectModel *model = [ProjectModel yy_modelWithDictionary:[object objectForKey:JSON_data]];
                  [SVProgressHUD showSuccessWithStatus:@"新建项目成功"];
                  [self.delegate VCRefereshWithProjectModel:model];
                  [self.navigationController popViewControllerAnimated:YES];
              } else
              {
                  AF_SHOW_RESULT_ERROR
              }
            }];
            return;
        }
        //试镜  新视频、图片
        [projectDic setObject:[NSNumber numberWithInteger:1] forKey:@"type"];
        [projectDic setObject:_model.auditionend forKey:@"latestwork"];
        NSMutableArray *annexidArr = [NSMutableArray new];
        for (mediaModel *shootAddModel in _photoArray) {
            [annexidArr addObject:shootAddModel.id];
        }
        NSString *annexids = [annexidArr componentsJoinedByString:@","];
        [projectDic setObject:annexids forKey:@"annexids"];
        [AFWebAPI addShootProjectWithArg:projectDic callBack:^(BOOL success, id object) {
                        if (success) {
                            ProjectModel *model = [ProjectModel yy_modelWithDictionary:[object objectForKey:JSON_data]];
                            [SVProgressHUD showSuccessWithStatus:@"新建项目成功"];
                            [self.delegate VCRefereshWithProjectModel:model];
                            [self.navigationController popViewControllerAnimated:YES];
                        } else
                        {
                            AF_SHOW_RESULT_ERROR
            
                        }
        }];

    }else if (_type == 2){//编辑   新老图片（url）
        [projectDic setObject:[NSString stringWithFormat:@"%ld",(long)_model.id] forKey:@"creativeid"];
         [projectDic setObject:[UserInfoManager getUserUID] forKey:@"userid"];
        NSMutableArray *urlArr = [NSMutableArray new];
        for (mediaModel *auditionModel in _photoArray) {
            if (auditionModel.type == mediaTypePhotoOld) {
                [urlArr addObject:auditionModel.url];
            }
            
        }
        if (urlArr.count>0) {//将原先的图片的url带进去
            NSString *urlStr = [urlArr componentsJoinedByString:@"|"];
             [projectDic setObject:urlStr forKey:@"url"];
        }else{
              [projectDic setObject:@"" forKey:@"url"];
        }
      
        if (_isAudition) {//拍摄
            [projectDic setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
            [projectDic setObject:_model.shotcycle forKey:@"cycle"];
            [projectDic setObject:_model.shotregion forKey:@"region"];
           
            [AFWebAPI editProjectWithArg:projectDic imageArray:newPhotos callBack:^(BOOL success, id object) {
                if (success) {
                     [SVProgressHUD showSuccessWithStatus:@"项目编辑成功"];
                    ProjectModel *model = [ProjectModel yy_modelWithDictionary:[object objectForKey:JSON_data]];
                    [self.delegate VCRefereshWithProjectModel:model];
                    [self.navigationController popViewControllerAnimated:YES];
                } else
                {
                    AF_SHOW_RESULT_ERROR
                }
            }];
            return;
        }
        //试镜 新老视频图片（4个：url。data）
        [projectDic setObject:[NSNumber numberWithInteger:1] forKey:@"type"];
        [projectDic setObject:_model.auditionend forKey:@"latestwork"];
        [projectDic setObject:[NSString stringWithFormat:@"%ld",(long)_model.auditiondays] forKey:@"days"];
        NSMutableArray *annexidArr = [NSMutableArray new];
        for (mediaModel *shootAddModel in _photoArray) {
            [annexidArr addObject:shootAddModel.id];
        }
        NSString *annexids = [annexidArr componentsJoinedByString:@","];
        [projectDic setObject:annexids forKey:@"annexids"];
        [AFWebAPI EditShootProjectWithArg:projectDic callBack:^(BOOL success, id object) {
                        if (success) {
                             [SVProgressHUD showSuccessWithStatus:@"项目编辑成功"];
                            ProjectModel *model = [ProjectModel yy_modelWithDictionary:[object objectForKey:JSON_data]];
                            [self.delegate VCRefereshWithProjectModel:model];
                            [self.navigationController popViewControllerAnimated:YES];
                        } else
                        {
                            AF_SHOW_RESULT_ERROR
                        }
        }];

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//预估行高，否则刷新某行时table会抖动
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section==0){
    
        NSInteger mediaCount=0;
        if (_isAudition) {
            NSArray *urls = [_model.url componentsSeparatedByString:@"|"];
            mediaCount = urls.count;
        }else{
           mediaCount = _model.vdo.count+_model.img.count;
        }
       //若mediacount没有值说明是新建
       mediaCount = _photoArray.count;
        NSInteger heightRadius = 1;
        //275固定 3个以内 height = (screenWid - 40)/3  + 20
        if (mediaCount>2 && mediaCount<6){
            heightRadius = 2;
        }else if (mediaCount>5){
            heightRadius = 3;
        }
        CGFloat cellHeight = 270+(10*heightRadius)+(UI_SCREEN_WIDTH-40)*heightRadius/3;
        if (_type==3) {
            if (mediaCount==3 ||mediaCount==6) {
                cellHeight = 270+mediaCount*(UI_SCREEN_WIDTH-40)/9;
            }

        }
        return cellHeight;
    }else if(indexPath.section == 1){//
        if (_isAudition) {
            return 248;//拍摄
        }else{
            return 261;
        }

    }else{//查看时，没有此cell（按钮cell）
        if (_type==3) {
            return 0.5;
        }
        return 113;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        if (indexPath.section==0){
        NSInteger heightRadius = 1;
        //275固定 3个以内 height = (screenWid - 40)/3  + 20
        if (self.photoArray.count>2 && self.photoArray.count<6){
            heightRadius = 2;
        }else if (self.photoArray.count>5){
            heightRadius = 3;
        }
        CGFloat cellHeight = 290+(10*heightRadius)+(UI_SCREEN_WIDTH-40)*heightRadius/3;
        if (_type==3) {
            if (_photoArray.count==3 ||_photoArray.count==6) {
                 cellHeight = 290+_photoArray.count*(UI_SCREEN_WIDTH-40)/9;
            }
           
        }
        return cellHeight;
    }else if(indexPath.section == 1){//
        if (_isAudition) {
            return 248;//拍摄
        }else{
            return 261;
        }
        
    }else{//查看时，没有此cell（按钮cell）
        if (_type==3) {
            return 0.5;
        }
        return 113;
    }
}
- (void)onGoback
{
    [self.delegate VCRefereshWithProjectModel:nil]; //编辑了直接返回刷新列表，不然下次编辑会把修改过的model带入编辑页面];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ProjectDescCell *descCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextView *textView = [descCell.contentView viewWithTag:111];
    [textView resignFirstResponder];
    UITextView *textField = [descCell.contentView viewWithTag:112];
    [textField resignFirstResponder];
}
-(void)setModel:(ProjectModel *)model
{
    _model = model;
}
//根据开始时间生成结束时间 (n+2)个天数
-(NSDate *)start:(NSString *)start WithAudition:(NSInteger)auditionDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
      [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date1 = [dateFormatter dateFromString:start];
   
        NSTimeInterval  auditionDayInterval = 24 * 60 * 60 * (auditionDay+1);
      //  NSDate *date2 = [date1 initWithTimeIntervalSinceNow:auditionDayInterval];
    NSDate *date2 = [date1 dateByAddingTimeInterval:auditionDayInterval];
    return date2;
}
//结束日期最早的一天
//-(NSDate *)minStart:(NSString *)start WithAudition:(NSInteger)auditionDay
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//      [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    NSDate *date1 = [dateFormatter dateFromString:start];
//
//    NSTimeInterval  auditionDayInterval = 24 * 60 * 60 * (auditionDay-1);
//    NSDate *date2 = [date1 initWithTimeIntervalSinceNow:auditionDayInterval];
//    return date2;
//}
//将时间转化为date
-(NSDate *)dateWithString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date1 = [dateFormatter dateFromString:dateString];
    return date1;
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    if (_type == 3) {//查看
       // self.editView.hidden = YES;
           self.tableView.frame=CGRectMake(0, 42, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-105-42);
    }else if(_type == 1){//新建则没有编号
      //  self.tableView.y=0;
     //   self.checkView.hidden = YES;
           self.tableView.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-105);
    }else{//编辑
      //  self.projectNum.text = _model.projectid;
          self.tableView.frame=CGRectMake(0, 42, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-105-42);
    }
  
 
}
-(void )sortPhotoArray
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES];
    //这个数组保存的是排序好的对象
    NSArray *tempArray = [_photoArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];//升序排列 老视频、新视频、老图片、新图片
    self.photoArray = [NSMutableArray arrayWithArray:tempArray];
}
//播放视频组
-(void)playWorkVideoWithUrl:(NSString *)url
{
  
    
    [_player destroyPlayer];
    _player = nil;
    
    _player = [[VideoPlayer alloc] init];
    _player.videoUrl =url;
    _player.onlyFullScreen=YES;
    
    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
    WeakSelf(self);
    _player.dowmLoadBlock = ^{
     //   [weakself VideostatisticsWithWorkModel:model withType:2];
    };
    
//    [self VideostatisticsWithWorkModel:model withType:1];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   [_player destroyPlayer];
    _player = nil;
}
@end
