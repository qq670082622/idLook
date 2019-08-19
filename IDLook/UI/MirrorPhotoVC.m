//
//  MirrorPhotoVC.m
//  IDLook
//
//  Created by HYH on 2018/5/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MirrorPhotoVC.h"
#import "MirrPhotoListCell.h"
#import "PhotoDetialVC.h"

static NSString *cellReuseIdentifer = @"MirrPhotoListCell";

@interface MirrorPhotoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation MirrorPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"过往作品图片"]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self collectionView];
}


-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        [flowLayout setSectionInset:UIEdgeInsetsMake(15, 15, 15,15)];
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsHorizontalScrollIndicator=NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[MirrPhotoListCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MirrPhotoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    [cell reloadUIWithModel:self.array[indexPath.row]];
    WeakSelf(self);
    cell.buyPhotoBlock = ^{
        [weakself placeOrderWithIndex:indexPath.row];
    };
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(mirrPhotoWidth, mirrPhotoWidth*1.2);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    PhotoDetialVC *lookVC = [[PhotoDetialVC alloc]init];
//    lookVC.model=self.array[indexPath.row];
//    lookVC.info=self.info;
//    [self.navigationController pushViewController:lookVC animated:YES];
    
    WorksModel *model = self.array[indexPath.row];
    MirrPhotoListCell *cell =(MirrPhotoListCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:@[model.url] curImgIndex:0 AbsRect:cell.contentView.bounds];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {};
}

//购买下单
-(void)placeOrderWithIndex:(NSInteger)index
{

}


@end