//
//  AskDescCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AskDescCell.h"
#import "PlaceAuditCellE.h"
@interface AskDescCell()<UICollectionViewDelegate,UICollectionViewDataSource,ScriptSubCellADelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property(nonatomic,strong) NSMutableArray *dataS;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *days;
@property (weak, nonatomic) IBOutlet UILabel *startEnd;
@property (weak, nonatomic) IBOutlet UILabel *cycle;
@property (weak, nonatomic) IBOutlet UILabel *region;
- (IBAction)otherSelect:(id)sender;

@end
@implementation AskDescCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"AskDescCell";
    AskDescCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AskDescCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.backView.layer.cornerRadius = 8;
//    cell.backView.layer.masksToBounds = YES;
        return cell;
}

-(void)setModel:(ProjectModel2 *)model
{
    _model = model;
    self.name.text = [NSString stringWithFormat:@"项目名称：%@",model.projectName];
    self.desc.text= [NSString stringWithFormat:@"项目简介：%@",model.projectDesc];
    self.city.text = [NSString stringWithFormat:@"拍摄城市：%@",model.projectCity];
    self.days.text = [NSString stringWithFormat:@"拍摄天数：%ld天",(long)model.shotDays];
    self.startEnd.text = [NSString stringWithFormat:@"预拍周期：%@至%@",model.projectStart,model.projectEnd];
    self.cycle.text = [NSString stringWithFormat:@"肖像周期：%@",model.shotCycle];
    self.region.text = [NSString stringWithFormat:@"肖像范围：%@",model.shotRegion];
     [self.desc sizeToFit];
     self.desc.frame = CGRectMake(12, _name.bottom+5, _desc.width, _desc.height);

    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:_name.text];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,5)];
    self.name.attributedText=attStr;
    
    NSMutableAttributedString * attStr2 = [[NSMutableAttributedString alloc] initWithString:_desc.text];
    [attStr2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,5)];
    self.desc.attributedText=attStr2;
    
    NSMutableAttributedString * attStr3 = [[NSMutableAttributedString alloc] initWithString:_city.text];
    [attStr3 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,5)];
    self.city.attributedText=attStr3;
    
    NSMutableAttributedString * attStr4 = [[NSMutableAttributedString alloc] initWithString:_days.text];
    [attStr4 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,5)];
    self.days.attributedText=attStr4;
    
    NSMutableAttributedString * attStr5 = [[NSMutableAttributedString alloc] initWithString:_startEnd.text];
    [attStr5 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,5)];
    self.startEnd.attributedText=attStr5;
    
    NSMutableAttributedString * attStr6 = [[NSMutableAttributedString alloc] initWithString:_cycle.text];
    [attStr6 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,5)];
    self.cycle.attributedText=attStr6;
    
    NSMutableAttributedString * attStr7 = [[NSMutableAttributedString alloc] initWithString:_region.text];
    [attStr7 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#909090"]} range:NSMakeRange(0,5)];
    self.region.attributedText=attStr7;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collection.collectionViewLayout = flowLayout;
    self.collection.dataSource=self;
    self.collection.delegate=self;
    self.collection.scrollEnabled=NO;
    self.collection.showsHorizontalScrollIndicator=NO;
    self.collection.showsVerticalScrollIndicator=NO;
    [self.collection setBackgroundColor:[UIColor clearColor]];
    [self.collection registerClass:[ScriptSubCellA class] forCellWithReuseIdentifier:@"AskDescCell"];
    self.dataS=[NSMutableArray arrayWithArray:model.projectScriptList];

 //   self.collection.height += _dataS.count>2?ScriptSubCellWidth:0;
 CGFloat cellWid  = ((UI_SCREEN_WIDTH-24-4*10)/3);
    if (_dataS.count==0) {
        self.collection.height=0.1;
    }
    
    if (_dataS.count<4 && _dataS.count>0) {
        self.collection.height = cellWid+20;
    }
    if (_dataS.count>3 && _dataS.count<7) {
         self.collection.height = cellWid*2+30;
    }
    if (_dataS.count>6) {
         self.collection.height = cellWid*3+40;
    }
    _collection.y = _desc.bottom+7;

    self.city.frame = CGRectMake(12, _collection.bottom+7, _city.width, _city.height);
    self.days.frame = CGRectMake(12, _city.bottom+5, _days.width, _days.height);
    self.startEnd.frame = CGRectMake(12, _days.bottom+5, _startEnd.width, _startEnd.height);
    self.cycle.frame = CGRectMake(12, _startEnd.bottom+5, _cycle.width , _cycle.height);
    self.region.frame = CGRectMake(12, _cycle.bottom+5, _region.width, _region.height);

    self.contentView.height = _region.bottom+20;
 _cellHeight = self.contentView.height;
      [self.collection reloadData];

}
-(CGFloat)reloadUIWithArray:(NSArray *)array
{

 return self.contentView.bottom;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)otherSelect:(id)sender {
    self.otherSelect();
}
#pragma mark-----ScriptSubCellADelegate
-(void)addWorksAction
{
    
   // [self.delegate addAction];
    
}

-(void)delectWorksWithRow:(NSInteger)row
{
    
    
   // [self.delegate delectWithRow:row];
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataS.count<9) {
//        NSInteger count = 1;//_checkStyle?0:1;
//        return self.dataS.count+count;
        return _dataS.count;
    }
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     WeakSelf(self);
    ScriptSubCellA *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AskDescCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.delegate=self;
    if (indexPath.row==self.dataS.count && self.dataS.count<9) {
      //  if (!_checkStyle) {
            [cell reloadUIWithImage:nil withDeleBtn:NO withAdd:YES withRow:indexPath.row withVideoDuration:@""] ;
       // }
        
    }
    else
    {
        
        mediaModel *model = self.dataS[indexPath.row];
       BOOL isVideo = model.type==1?NO:YES;//1图片 2视频
        if (isVideo) {
            [cell reloadUIWithImage:model.image withDeleBtn:YES withAdd:NO withRow:indexPath.row withVideoDuration:model.duration];
        }else{
            [cell reloadUIWithImage:model.image withDeleBtn:YES withAdd:NO withRow:indexPath.row withVideoDuration:@""];
        }
    
    }
   
    cell.photoCellClick = ^(NSInteger row) {
        
    };
 
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWid  = ((UI_SCREEN_WIDTH-24-4*10)/3);
    return CGSizeMake(cellWid,cellWid);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 9,10,9);
}
- (NSMutableArray *)dataS
{
    if (!_dataS) {
        _dataS = [NSMutableArray new];
    }
    return _dataS;
}
@end
