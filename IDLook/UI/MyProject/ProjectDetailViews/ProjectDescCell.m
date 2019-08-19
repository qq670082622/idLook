//
//  ProjectDescCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectDescCell.h"
#import "PlaceAuditCellE.h"

@interface ProjectDescCell()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,ScriptSubCellADelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)NSMutableArray *dataS;
@property(nonatomic,strong)NSMutableArray *assets;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end
@implementation ProjectDescCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"ProjectDescCell";
    ProjectDescCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectDescCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}
-(void)setModel:(ProjectModel2 *)model
{
    _model = model;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.scrollEnabled=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView.showsVerticalScrollIndicator=NO;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView registerClass:[ScriptSubCellA class] forCellWithReuseIdentifier:@"ProjectDescCell"];

    self.textView.text = model.projectDesc;//model.desc;
    [self.textView setTag:111];
    self.projectTitle.text = model.projectName;//model.name;
    [self.projectTitle setTag:112];
   if (model.projectDesc.length>0) {//if (model.desc.length>0) {
         self.tipsLab.hidden=YES;
    }
   
}
-(void)setCheckStyle:(BOOL)checkStyle
{
    if (checkStyle) {
        self.checkBtn.hidden = NO;
    }
    _checkStyle = checkStyle;
}
-(void)reloadUIWithArray:(NSArray *)array withAssets:(NSArray *)assets
{
    self.dataS=[NSMutableArray arrayWithArray:array];
    self.assets=[NSMutableArray arrayWithArray:array];
    self.collectionView.height += array.count>2?ScriptSubCellWidth:0;
    if (_checkStyle) {
        if (array.count==3 ||array.count==6) {
            self.collectionView.height -= ScriptSubCellWidth;
        }
    }
    if (array.count<3) {
        self.collectionView.height+=15;
    }
  
    [self.collectionView reloadData];
}

#pragma mark-----ScriptSubCellADelegate
-(void)addWorksAction
{
  
        [self.delegate addAction];
    
}

-(void)delectWorksWithRow:(NSInteger)row
{
    
    
        [self.delegate delectWithRow:row];
    
}
#pragma mark textviewDelegate
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if (textView.text.length>0) {
//        self.tipsLab.hidden = YES;
//    }else if (textView.text.length == 0){
//        self.tipsLab.hidden = NO;
//    }
//}
-(void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
    {
        self.tipsLab.hidden=YES;
    }
    else
    {
        self.tipsLab.hidden=NO;
    }
    if (self.textViewChangeBlock) {
        self.textViewChangeBlock(textView.text);
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textFieldChangeBlock(textField.text);
}
#pragma mark - textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>499) {
        if (text.length==0) {//在删除
            return YES;
        }else if (text.length>0) //还想加字，不允许
        {
            return NO;
        }
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}
//-(BOOL)textfiel
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length>19) {
   if (string.length==0) {//在删除
            return YES;
        }else if (string.length>0) //还想加字，不允许
        {
        return NO;
        }
    }
    if ([string isEqualToString:@"\n"]) {
        
        [textField resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataS.count<9) {
        NSInteger count = _checkStyle?0:1;
        return self.dataS.count+count;
    }
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScriptSubCellA *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectDescCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.delegate=self;
    if (indexPath.row==self.dataS.count && self.dataS.count<9) {
        if (!_checkStyle) {
            [cell reloadUIWithImage:nil withDeleBtn:NO withAdd:YES withRow:indexPath.row withVideoDuration:@""] ;
        }
        
    }
    else
    {
        mediaModel *model = self.dataS[indexPath.row];
        BOOL isVideo = model.type<2?YES:NO;
        if (isVideo) {
             [cell reloadUIWithImage:model.image withDeleBtn:_checkStyle withAdd:NO withRow:indexPath.row withVideoDuration:model.duration];
        }else{
             [cell reloadUIWithImage:model.image withDeleBtn:_checkStyle withAdd:NO withRow:indexPath.row withVideoDuration:@""];
        }
    
    }
    WeakSelf(self);
    cell.photoCellClick = ^(NSInteger row) {
        [weakself.delegate chekBigImageWithRow:row];

    };
//    UIImage *img = _dataS[indexPath.row];
//    if (img) {
//         [cell reloadUIWithImage:self.dataS[indexPath.row] withAsset:self.assets[indexPath.row] withAdd:NO withRow:indexPath.row];
//    }else{
//         [cell reloadUIWithImage:nil withAsset:nil withAdd:YES withRow:indexPath.row];
//    }
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

@end
