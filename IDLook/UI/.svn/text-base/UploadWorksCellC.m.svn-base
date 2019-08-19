//
//  UploadWorksCellC.m
//  IDLook
//
//  Created by HYH on 2018/6/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadWorksCellC.h"
#import "AddSubButton.h"
#import "TZImagePickerController.h"

static NSString *cellReuseIdentifer = @"UploadSubCellA";

@interface UploadWorksCellC ()<UICollectionViewDelegate,UICollectionViewDataSource,UploadWorkSubCellDelegate>
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)UICollectionView *collectV;
@property(nonatomic,strong)NSMutableArray *dataS;
@property(nonatomic,strong)NSMutableArray *times;

@end

@implementation UploadWorksCellC
@synthesize delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(NSMutableArray*)dataS
{
    if (!_dataS) {
        _dataS=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataS;
}

-(NSMutableArray*)times
{
    if (!_times) {
        _times=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _times;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:12.0];
        _desc.numberOfLines=0;
        _desc.textAlignment=NSTextAlignmentCenter;
        _desc.text=@"*要求：视频时长60S 大小50M以内.";
        _desc.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(31);
            make.right.mas_equalTo(self.contentView).offset(-31);
            make.top.mas_equalTo(self.contentView.mas_bottom).offset(-40);
        }];
    }
    return _desc;
}

-(UICollectionView*)collectV
{
    if (!_collectV) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        flowLayout.minimumLineSpacing = 10;
//        flowLayout.minimumInteritemSpacing = 10;
//        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10,10)];
        
        _collectV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectV.dataSource=self;
        _collectV.delegate=self;
        _collectV.scrollEnabled=NO;
        _collectV.showsHorizontalScrollIndicator=NO;
        _collectV.showsVerticalScrollIndicator=NO;
        [_collectV setBackgroundColor:[UIColor clearColor]];
        [_collectV registerClass:[UploadSubCellA class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [self.contentView addSubview:_collectV];
        [_collectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.desc.mas_top).offset(-20);
        }];
        
    }
    return _collectV;
}

-(void)reloadUIWithArray:(NSArray *)array withTimes:(NSArray *)times
{
    [self desc];
    self.dataS=[NSMutableArray arrayWithArray:array];
    self.times=[NSMutableArray arrayWithArray:times];

    [self.collectV reloadData];
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataS.count<6) {
        return self.dataS.count+1;
    }
    return 6;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UploadSubCellA *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.delegate=self;

    if (indexPath.row==self.dataS.count && self.dataS.count<6) {
        [cell reloadUIWithImage:nil withTime:nil withAdd:YES withRow:indexPath.row];
    }
    else
    {
        [cell reloadUIWithImage:self.dataS[indexPath.row] withTime:self.times[indexPath.row] withAdd:NO withRow:indexPath.row];
    }
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UI_SCREEN_WIDTH-4*10)/3,(UI_SCREEN_WIDTH-4*10)/3 );
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"--%ld",indexPath.row);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 9,10,9);

}

#pragma aamrk--
#pragma mark-----UploadWorkSubCellDelegate
-(void)addWorksAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addVideAction)]) {
        [self.delegate addVideAction];
    }
}

-(void)delectWorksWithRow:(NSInteger)row
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(delectActionWithRow:)]) {
        [self.delegate delectActionWithRow:row];
    }
}

@end

@interface UploadSubCellA ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)AddSubButton *addBtn;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,strong)UIButton *timeBtn;
@end
@implementation UploadSubCellA

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=5.0;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        _icon.clipsToBounds=YES;
        _icon.userInteractionEnabled=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        
        UIButton *delectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_icon addSubview:delectBtn];
        [delectBtn setBackgroundImage:[UIImage imageNamed:@"works_delect"] forState:UIControlStateNormal];
        [delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
        }];
        [delectBtn addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _icon;
}

-(UIButton*)timeBtn
{
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_timeBtn];
        _timeBtn.layer.masksToBounds=YES;
        _timeBtn.layer.cornerRadius=9;
        _timeBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"u_video_s"] forState:UIControlStateNormal];
        [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon).offset(6);
            make.bottom.mas_equalTo(self.icon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}

-(AddSubButton*)addBtn
{
    if (!_addBtn) {
        _addBtn=[[AddSubButton alloc]init];
        [self.contentView addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        WeakSelf(self);
        _addBtn.addAction = ^{
            [weakself addACtion];
        };
    }
    return _addBtn;
}

-(void)reloadUIWithImage:(UIImage *)image withTime:(NSString *)time withAdd:(BOOL)add withRow:(NSInteger)row
{
    self.row=row;
    if (add) {
        self.addBtn.imageN=@"works_video_icon";
        self.addBtn.title=@"添加视频";
        self.addBtn.hidden=NO;
        self.icon.hidden=YES;
        self.timeBtn.hidden=YES;
    }
    else
    {
        self.icon.image=image;
        self.icon.hidden=NO;
        self.addBtn.hidden=YES;
        self.timeBtn.hidden=NO;
        [self.timeBtn setTitle:time forState:UIControlStateNormal];
    }
}

-(void)addACtion
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addWorksAction)]) {
        [self.delegate addWorksAction];
    }
}

-(void)delectAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(delectWorksWithRow:)]) {
        [self.delegate delectWorksWithRow:self.row];
    }
}

@end
