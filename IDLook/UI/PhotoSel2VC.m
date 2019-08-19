//
//  PhotoSel2VC.m
//  miyue
//
//  Created by wsz on 16/5/3.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import "PhotoSel2VC.h"
#import "PhotoSel2CellA.h"

static NSString *cellReuseIdentifer = @"PhotoSel2CellA";

@interface PhotoSel2VC ()<UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectV;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)PHFetchResult *result;

@property (nonatomic,strong)UIButton *finishBtn;
@property (nonatomic,strong)UILabel *seletcNum;

@property (nonatomic,strong)NSMutableArray *selected;

@property (nonatomic,strong)NSMutableArray *imageArr;

@end

@implementation PhotoSel2VC

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        self.name = [dic objectForKey:@"name"];
        self.result = [dic objectForKey:@"result"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:self.name]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"取消" Target:self action:@selector(cancle)]]];
    
    [self collectV];
    [self footV];
}

- (void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancle
{
    self.doCancle();
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
        [_collectV registerClass:[PhotoSel2CellA class] forCellWithReuseIdentifier:cellReuseIdentifer];
    
        [self.view addSubview:_collectV];
        
    }
    return _collectV;
}

- (void)footV
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = Public_Background_Color;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@49.f);
    }];
    
    UIView *segV = [[UIView alloc] init];
    segV.backgroundColor = [UIColor lightGrayColor];
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
}

- (NSMutableArray *)selected
{
    if(!_selected)
    {
        _selected = [NSMutableArray array];
    }
    return _selected;
}

- (NSMutableArray *)imageArr
{
    if(!_imageArr)
    {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger c = self.result.count;
    NSInteger k = c%4;
    if(k==0)
    {
        return c/4;
    }
    else
    {
        return c/4+1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    PhotoSel2CellA *cell = (PhotoSel2CellA *)[collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    
    __weak __typeof(self)ws = self;
    __weak __typeof(cell)cl=cell;
    cell.didSelected = ^(BOOL select){
        if(select)
        {
            if((sec*4+row)<ws.result.count)
            {
                [ws.selected addObject:ws.result[sec*4+row]];
                [ws addToSld];
            }
        }
        else
        {
            if((sec*4+row)<ws.result.count)
            {
                if([ws.selected containsObject:ws.result[sec*4+row]])
                {
                    [ws.selected removeObject:ws.result[sec*4+row]];
                    [ws reduceToSld];
                }
            }
        }
    };
    if((sec*4+row)<self.result.count)
    {
        [cell reloadWithAsset:self.result[sec*4+row]];
    }
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(PhotoSel2CellA_slide, PhotoSel2CellA_slide);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section==0)
    {
        return UIEdgeInsetsMake(4.f, 4.f, 2.f, 4.f);
    }
    return UIEdgeInsetsMake(2.f, 4.f, 4.f, 4.f);
}

#pragma mark -
#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark -
#pragma mark - others

- (void)finish
{
    self.doUpdata(self.selected);
}

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

- (void)AnalysisImages
{
//    for(PHAsset *asset in self.result)
//    {
//        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
//        option.resizeMode = PHImageRequestOptionsResizeModeFast;
//        [[PHCachingImageManager defaultManager] requestImageForAsset:asset
//                                                          targetSize:PHImageManagerMaximumSize
//                                                         contentMode:PHImageContentModeAspectFill
//                                                             options:option
//                                                       resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
//                                                           
//                                                           
//                                                           
//                                                       }];
//        
//
//    }
}
@end
