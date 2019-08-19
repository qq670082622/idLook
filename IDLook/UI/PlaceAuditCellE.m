//
//  PlaceAuditCellE.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditCellE.h"
#import "AddSubButton.h"
#import "TZImagePickerController.h"

static NSString *cellReuseIdentifer = @"UploadSubCellA";

@interface PlaceAuditCellE ()<UICollectionViewDelegate,UICollectionViewDataSource,ScriptSubCellADelegate>
@property(nonatomic,strong)UICollectionView *collectV;
@property(nonatomic,strong)NSMutableArray *dataS;
@property(nonatomic,strong)NSMutableArray *assets;

@end

@implementation PlaceAuditCellE
@synthesize delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

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

-(NSMutableArray*)assets
{
    if (!_assets) {
        _assets=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _assets;
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
        [_collectV registerClass:[ScriptSubCellA class] forCellWithReuseIdentifier:cellReuseIdentifer];
        [self.contentView addSubview:_collectV];
        [_collectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
        }];
        
    }
    return _collectV;
}

-(void)reloadUIWithArray:(NSArray *)array withAssets:(NSArray *)assets
{
    self.dataS=[NSMutableArray arrayWithArray:array];
    self.assets=[NSMutableArray arrayWithArray:assets];
    
    [self.collectV reloadData];
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataS.count<9) {
        return self.dataS.count+1;
    }
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScriptSubCellA *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.delegate=self;
    
    if (indexPath.row==self.dataS.count && self.dataS.count<9) {
     [cell reloadUIWithImage:nil withDeleBtn:NO withAdd:YES withRow:indexPath.row withVideoDuration:@""];
    }
    else
    {
        [cell reloadUIWithImage:self.dataS[indexPath.row] withDeleBtn:NO withAdd:NO withRow:indexPath.row withVideoDuration:@""];
    }
    return cell;
}

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScriptSubCellWidth,ScriptSubCellWidth);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 9,10,9);
}

#pragma aamrk--
#pragma mark-----ScriptSubCellADelegate
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

@interface ScriptSubCellA ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIButton *deleBtn;
@property(nonatomic,strong)UIButton *timeBtn;
@property(nonatomic,strong)AddSubButton *addBtn;
@property(nonatomic,assign)NSInteger row;
@end
@implementation ScriptSubCellA

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
        _icon.image = [UIImage imageNamed:@"default_home"];
        [_icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];

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
        self.deleBtn = delectBtn;
        
        UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_icon addSubview:timeBtn];
        [timeBtn setImage:[UIImage imageNamed:@"video_icon"] forState:UIControlStateNormal];
        timeBtn.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        timeBtn.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        timeBtn.width = 55;
        timeBtn.height = 17;
        timeBtn.x=5;
        timeBtn.y = self.contentView.height-24;
        timeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        timeBtn.userInteractionEnabled = NO;
        self.timeBtn = timeBtn;
    }
    return _icon;
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

-(void)reloadUIWithImage:(UIImage *)image withDeleBtn:(BOOL)hideDele withAdd:(BOOL)add withRow:(NSInteger)row withVideoDuration:(NSString *)duration
{
    self.row=row;
    if (add) {
        self.addBtn.imageN=@"icon_upload";
        self.addBtn.title=@"图片/视频";
        self.addBtn.hidden=NO;
        self.icon.hidden=YES;
    }
    else
    {
//        if (![image isKindOfClass:[UIImage class]]) {
//            NSString *imageStr = (NSString*)image;
//            [self.icon sd_setImageWithUrlStr:imageStr];
//        }else{
        self.icon.image=image;
//        }
        self.icon.hidden=NO;
        self.addBtn.hidden=YES;
    }
    if (hideDele) {
        self.deleBtn.hidden = YES;
    }
    if (duration.length>0) {
        self.timeBtn.hidden = NO;
       
        [self.timeBtn setTitle:[self timeWithDuration:duration] forState:0];
        NSLog(@"timeBtn's frame is %@ content is %@",NSStringFromCGRect(_timeBtn.frame),NSStringFromCGRect(self.contentView.frame));
        
    }else{
        self.timeBtn.hidden = YES;
    }
}
-(void)click
{
    self.photoCellClick(_row);
}
-(NSString *)timeWithDuration:(NSString *)duration
{
    NSInteger duration_int = [duration integerValue];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(duration_int%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",duration_int%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
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

