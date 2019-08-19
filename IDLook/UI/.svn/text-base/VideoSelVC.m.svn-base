//
//  VideoSelVC.m
//  IDLook
//
//  Created by HYH on 2018/6/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoSelVC.h"
#import <Photos/Photos.h>

#import "VideoSelCell.h"

static NSString *cellReuseIdentifer = @"VideoSelCell";


@interface VideoSelVC ()<UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectV;

@property (nonatomic,strong)NSMutableArray *result;

@property (nonatomic,strong)UIButton *finishBtn;
@property (nonatomic,strong)UILabel *seletcNum;

@property (nonatomic,strong)NSMutableArray *selected;

@end

@implementation VideoSelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"视频"]];

    self.navigationItem.hidesBackButton=YES;
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"取消" Target:self action:@selector(onGoback)]]];
    
    self.result = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self albumProcess];
    
    [self collectV];
    [self footV];
}

- (void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionView *)collectV
{
    if(!_collectV)
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0.f;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectV = [[UICollectionView alloc] initWithFrame:(CGRect){self.view.bounds.origin,
            self.view.bounds.size.width,
            self.view.bounds.size.height-49.f-SafeAreaTopHeight}
                                       collectionViewLayout:flowLayout];
        _collectV.dataSource=self;
        _collectV.delegate=self;
        _collectV.backgroundColor = Public_Background_Color;
        [_collectV registerClass:[VideoSelCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        
        [self.view addSubview:_collectV];
        
    }
    return _collectV;
}

- (void)footV
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@49.f);
    }];
    
    UIView *segV = [[UIView alloc] init];
    segV.backgroundColor = Public_LineGray_Color;
    [view addSubview:segV];
    [segV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.top.equalTo(view);
        make.height.equalTo(@.5f);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:Public_Orange_Color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view);
        make.bottom.equalTo(view);
        make.right.equalTo(view).offset(-10);
        make.width.equalTo(@50);
    }];
    self.finishBtn = btn;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = Public_Orange_Color;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.layer.cornerRadius = 11.5f;
    label.layer.masksToBounds = YES;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left);
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.centerY.equalTo(view);
    }];
    self.seletcNum = label;
    self.seletcNum.hidden = YES;
    if (self.selected.count) {
        self.seletcNum.text = [NSString stringWithFormat:@"%d",(int)self.selected.count];
        self.seletcNum.hidden=NO;
    }

}

- (NSMutableArray *)selected
{
    if(!_selected)
    {
        _selected = [[NSMutableArray alloc]initWithArray:self.imageArr];
    }
    return _selected;
}


#pragma mark -
#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.result.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    VideoSelCell *cell = (VideoSelCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    
    __weak __typeof(self)ws = self;
    __weak __typeof(cell)cl=cell;
    cell.didSelected = ^(BOOL select){
        if(select)
        {
            if(ws.selected.count<6)
            {
                [ws.selected addObject:ws.result[row]];
                [ws addToSld];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"您最多只能选择6个视频"];
            }
        }
        else
        {
            if([ws.selected containsObject:ws.result[row]])
            {
                [ws.selected removeObject:ws.result[row]];
                [ws reduceToSld];
            }
        }
    };
    
    [cell reloadWithDic:self.result[row]];

    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(videoSelCellWidth, videoSelCellWidth);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8.f, 8.f, 4.f, 8.f);
}

#pragma mark -
#pragma mark - UICollectionViewDelegate

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSInteger row =indexPath.row;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:self.result[indexPath.row]];
    BOOL isSelect= [dic[@"isSelect"] boolValue];
    isSelect=!isSelect;

    if(isSelect)
    {
        if(self.selected.count<6)
        {
            [dic setObject:@(isSelect) forKey:@"isSelect"];
            [self.result replaceObjectAtIndex:indexPath.row withObject:dic];
            
            [self.selected addObject:self.result[row]];
            [self addToSld];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"您最多只能选择6个视频"];
            return;
        }
    }
    else
    {
        for (int i =0;i<self.selected.count ; i++)
        {
            NSDictionary *dicA = self.selected[i];
            NSDictionary *dicB = self.result[indexPath.row];
            if ([dicA[@"url"] isEqual: dicB[@"url"]])
            {
                [self.selected removeObject:dicA];
                [self reduceToSld];
                
                [dic setObject:@(isSelect) forKey:@"isSelect"];
                [self.result replaceObjectAtIndex:indexPath.row withObject:dic];
            }
        }
    }

    [self.collectV reloadItemsAtIndexPaths:@[indexPath]];
}


#pragma mark -
#pragma mark - others

- (void)finish
{
    if (self.selected.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请至少选择一个视频！"];
        return;
    }
    self.doUpdata(self.selected);
    [self onGoback];
}

//选中
- (void)addToSld
{
    self.seletcNum.hidden = NO;
    self.seletcNum.text = [NSString stringWithFormat:@"%d",(int)self.selected.count];
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    ani.fromValue =@1.0;
    ani.toValue =@1.3;
    ani.duration =.1f;
    ani.autoreverses = YES;
    [self.seletcNum.layer addAnimation:ani forKey:@"scale"];
}

//取消选中
- (void)reduceToSld
{
    if(self.selected.count==0)
    {
        self.seletcNum.hidden = YES;
    }
    else
    {
        self.seletcNum.text = [NSString stringWithFormat:@"%d",(int)self.selected.count];
        
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
        ani.fromValue =@1.0;
        ani.toValue =@1.3;
        ani.duration =.1f;
        ani.autoreverses = YES;
        [self.seletcNum.layer addAnimation:ani forKey:@"scale"];
    }
}


#pragma mark -
#pragma makr - others
- (void)albumProcess
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status != PHAuthorizationStatusAuthorized)
            {
                NSLog(@"用户拒绝授权访问相册");
                return ;
            }
            else
            {
                PHFetchResult *sysAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
                [sysAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
                    if ([collection.localizedTitle isEqualToString:@"视频"]) {
                        PHFetchResult *result = [self fetchAssetsInAssetCollection:collection ascending:YES];
                        if (result.count > 0) {
                            [self AnalysisImagesWithResult:result];
                        }
                    }
                }];
            }
        });
    }];
}

- (PHFetchResult *)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    return result;
}

//图片数据解析
- (void)AnalysisImagesWithResult:(PHFetchResult*)result
{
    __block int index=0;

    
    for(int i =0;i<result.count;i++)
    {
        [self.result addObject:result[i]];   //按顺序加载视频

        PHAsset *asset = result[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        PHImageManager *manager = [PHImageManager defaultManager];
        //视频PHAsset转nsdata
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        options.networkAccessAllowed = true;
        
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info)
         {

             NSURL *URL = [(AVURLAsset *)asset URL];
             NSNumber *fileSizeValue = nil;
             [URL getResourceValue:&fileSizeValue forKey:NSURLFileSizeKey error:nil];
             //or
             
             NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
             
             NSLog(@"输出视频的大小:%lu--%@,视频时长--%d",(unsigned long)[data length],URL,[PublicManager getVideoLength:URL]);
             
             [dic setObject:data forKey:@"data"];
             [dic setObject:URL forKey:@"url"];
             [dic setObject:[PublicManager timeFormatted:[PublicManager getVideoLength:URL]] forKey:@"time"];
             UIImage *image = [PublicManager getVideoPreViewImage:URL];  //获取视频第一帧
             [dic setObject:image forKey:@"image"];
             
             [dic setObject:@(NO) forKey:@"isSelect"];
             
             
             //是否已经选中
             for (int i=0; i<self.imageArr.count; i++) {
                 NSDictionary *dicA = self.imageArr[i];
                 if ([dicA[@"url"] isEqual:dic[@"url"]])
                 {
                     [dic setObject:@(YES) forKey:@"isSelect"];
                 }
             }
             
             [self.result replaceObjectAtIndex:i withObject:dic];   //将解析的视频数据替换掉之前内容，以保证视频加载的顺序

             index++;
             if (index==result.count)  //当所有视频都加载完，刷新ui
             {
                 dispatch_async(dispatch_get_main_queue(), ^{  //主线程中执行UI
                     [self.collectV reloadData];
                 });
             }
         }];
    }
    
}

@end
