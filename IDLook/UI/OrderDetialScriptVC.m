//
//  OrderDetialScriptVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/22.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "OrderDetialScriptVC.h"
#import "ScriptCell.h"
#import "ScriptModel.h"
#import "VideoPlayer.h"

static NSString *cellReuseIdentifer = @"ScriptCell";

@interface OrderDetialScriptVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)CustomCollectV *collectionView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation OrderDetialScriptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"脚本"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];

    [self getData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_player destroyPlayer];
    _player = nil;
}

-(void)getData
{
    self.dataSource= [NSMutableArray new];
    
    if (self.projectModel.type==1) {
        //脚本视频
        for (int i=0; i<self.projectModel.vdo.count; i++) {
            NSDictionary *dic = self.projectModel.vdo[i];
            ScriptModel *model = [ScriptModel yy_modelWithDictionary:dic];
            model.type=1;
            [self.dataSource addObject:model];
        }
        
        //脚本图片
        for (int i=0; i<self.projectModel.img.count; i++) {
            NSDictionary *dic = self.projectModel.img[i];
            ScriptModel *model = [ScriptModel yy_modelWithDictionary:dic];
            model.type=2;
            [self.dataSource addObject:model];
        }
    }
    else
    {
        NSArray *array = [self.projectModel.url componentsSeparatedByString:@"|"];
        for (int i=0; i<array.count; i++) {
            ScriptModel *model = [[ScriptModel alloc]init];
            model.type=2;
            model.imageurl = array[i];
            [self.dataSource addObject:model];
        }
    }

    [self.collectionView reloadData];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CustomCollectV*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 9, 10,9)];
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[CustomCollectV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.alwaysBounceVertical = true; //当contentsize小于collectionview尺寸时，垂直方向添加弹簧效果
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[ScriptCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        
        [self.view addSubview:_collectionView];

    }
    return _collectionView;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(UI_SCREEN_WIDTH, 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScriptCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    [cell reloadUIWithModel:self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UI_SCREEN_WIDTH-4*10)/3, (UI_SCREEN_WIDTH-4*10)/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ScriptModel *model  = self.dataSource[indexPath.row];
    if (model.type==1) {
        [_player destroyPlayer];
        _player = nil;
        _player = [[VideoPlayer alloc] init];
        _player.videoUrl =model.videourl;
        _player.onlyFullScreen=YES;
        
        _player.completedPlayingBlock = ^(VideoPlayer *player) {
            [player destroyPlayer];
            _player = nil;
        };
        _player.dowmLoadBlock = ^{};
    }
    else if (model.type==2)
    {
        NSMutableArray *dataSource = [NSMutableArray new];
        NSInteger currIndex = 0;
        for (int i=0; i<self.dataSource.count; i++) {
            ScriptModel *modelA = self.dataSource[i];
            if (modelA.type==2) {
                [dataSource addObject:modelA.imageurl];
                if (i==indexPath.row) {
                    currIndex = dataSource.count-1;
                }
            }
        }
        
        LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
        lookImage.isShowDown=YES;
        [lookImage showWithImageArray:dataSource curImgIndex:currIndex AbsRect:CGRectMake(15, 25,UI_SCREEN_WIDTH-30, (UI_SCREEN_WIDTH-30)*(486.0/690.0))];
        [self.navigationController pushViewController:lookImage animated:YES];
        lookImage.downPhotoBlock = ^(NSInteger index) {};

    }
}


@end
