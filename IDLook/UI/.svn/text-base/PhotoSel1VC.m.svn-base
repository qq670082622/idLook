//
//  PhotoSel1VC.m
//  miyue
//
//  Created by wsz on 16/5/3.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import "PhotoSel1VC.h"
#import "PhotoSelCellA.h"
#import "PhotoSel2VC.h"

#import <Photos/Photos.h>

@interface PhotoSel1VC ()<UITableViewDelegate,
                         UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataSouece;
@property (nonatomic,strong)CustomTableV *tableV;

@end

@implementation PhotoSel1VC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选择相册"]];

    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"取消" Target:self action:@selector(cancle)]]];
    
    [self tableV];
    [self albumProcess];
}

- (NSMutableArray *)dataSouece
{
    if(!_dataSouece)
    {
        _dataSouece = [NSMutableArray array];
    }
    return _dataSouece;
}

- (CustomTableV *)tableV
{
    if(!_tableV)
    {
        _tableV = [[CustomTableV alloc] initWithFrame:self.view.bounds
                                                style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
    }
    return _tableV;
}

- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark - UITableViewDelegate&&UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSouece count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"PhotoSelCellA";
    PhotoSelCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[PhotoSelCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell reloadUIWithDic:self.dataSouece[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoSel2VC *sel2VC = [[PhotoSel2VC alloc] initWithDic:self.dataSouece[indexPath.row]];
    __weak __typeof(self)ws = self;
    sel2VC.doCancle = ^(){
        [ws cancle];
    };
    sel2VC.doUpdata = ^(NSMutableArray *array){
        [ws dismissViewControllerAnimated:YES completion:^{
            ws.updateImages(array);
        }];
    };
    [self.navigationController pushViewController:sel2VC animated:YES];
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
                    if (
                         [collection.localizedTitle isEqualToString:@"视频"]) {
                        PHFetchResult *result = [self fetchAssetsInAssetCollection:collection ascending:NO];
                        if (result.count > 0) {
                            
                            NSDictionary *dic = @{@"name":collection.localizedTitle,
                                                  @"result":result};
                            [self.dataSouece addObject:dic];
                        }
                    }
                }];
                
//                PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
//                [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
//                    PHFetchResult *result = [self fetchAssetsInAssetCollection:collection ascending:NO];
//                    if (result.count > 0) {
//                        NSDictionary *dic = @{@"name":collection.localizedTitle,
//                                              @"result":result};
//                        [self.dataSouece addObject:dic];
//                    }
//                }];
                [self.tableV reloadData];
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

@end
