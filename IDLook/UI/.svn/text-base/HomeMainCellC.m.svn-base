//
//  HomeMainCell.m
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeMainCellC.h"
#import "CollectionCustomCell.h"
#import "HomeArtistCell.h"

static NSString *cellReuseIdentifer = @"HomeArtistCell";

@interface HomeMainCellC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIImageView *titleV;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HomeMainCellC

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self titleV];
        [self moreBtn];
        [self collectionView];
    }
    return self;
}

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

-(UIImageView*)titleV
{
    if (!_titleV) {
        _titleV=[[UIImageView alloc]init];
        [self.contentView addSubview:_titleV];
        _titleV.image=[UIImage imageNamed:@"home_actor_banner"];
        [_titleV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(_titleV.mas_bottom).offset(10);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _titleV;
}

-(UIButton*)moreBtn
{
    if (!_moreBtn) {
        _moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_moreBtn];
        [_moreBtn setImage:[UIImage imageNamed:@"home_more_arrow"] forState:UIControlStateNormal];
        [_moreBtn setTitle:@"More" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _moreBtn.titleLabel.font=[UIFont boldSystemFontOfSize:12.0];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleV);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
        
        _moreBtn.titleLabel.backgroundColor = _moreBtn.backgroundColor;
        _moreBtn.imageView.backgroundColor = _moreBtn.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = _moreBtn.titleLabel.bounds.size;
        CGSize imageSize = _moreBtn.imageView.bounds.size;
        CGFloat interval = 1.0;
        _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        _moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + 5), 0, imageSize.width + 5);
        
        [_moreBtn addTarget:self action:@selector(entryMoreRecommend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10,10)];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.showsVerticalScrollIndicator=NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[HomeArtistCell class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [self.contentView addSubview:_collectionView];
//        _collectionView.backgroundColor=[UIColor redColor];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(2.5);
            make.right.mas_equalTo(self.contentView).offset(-2.5);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.titleV.mas_bottom).offset(15);
        }];
    }
    return _collectionView;
}

-(void)reloadUIWithArray:(NSArray *)array
{
    [self titleV];
    [self.dataSource setArray:array];
    [self.collectionView reloadData];
}

#pragma mark---
-(void)entryMoreRecommend
{
    self.EntryMoreRecommendBlock(9);  
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

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
    HomeArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithHexString:@"#FBFBFB"];
    UserInfoM *info = self.dataSource[indexPath.row];
    [cell reloadUIWithModel:info];
    WeakSelf(self);
    cell.clickUserInfo = ^{
        weakself.HomeMainCellClickBlock(info);
    };
    cell.lookUserOffer = ^{
        weakself.lookUserPriceBlock(info);
    };
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellCWidth, cellCWidth*1.57);
}


//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10,-7.5,10,7.5);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{

}

@end
