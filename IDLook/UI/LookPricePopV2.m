//
//  LookPricePopV2.m
//  IDLook
//
//  Created by 吴铭 on 2018/12/13.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LookPricePopV2.h"
#import "PlaceOrderModel.h"
#import "LookPricePopV2Cell.h"
const NSInteger backGroudWidth = 305;
const NSInteger backGroudHeight = 420;
@interface LookPricePopV2()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSource_video;
@property(nonatomic,strong)NSMutableArray *dataSource_photo;
@property(nonatomic,strong)NSMutableArray *dataSource_screen;
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)UIView *progress;
@property(nonatomic,strong)UILabel *tipsLabel;
@property(nonatomic,strong)UIView *bg;
@property(nonatomic,assign)NSInteger viewType;
@end
@implementation LookPricePopV2



- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        self.selectedType = 1;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)showWithArray:(NSArray *)array
{
    NSInteger viewType=1;//页面是组合还是单个 默认单个  1视频 2平面 3组合
    BOOL isVideo = false;
    BOOL isPhoto = false;
    [self.dataSource_video removeAllObjects];
     [self.dataSource_photo removeAllObjects];
    for (int i=0; i<array.count; i++) {
        PriceModel *model = [[PriceModel alloc]initWithDic:array[i]];
        if (model.type == 1) {
            isVideo = YES;
            [self.dataSource_video addObject:model];
        }else if (model.type == 2){
            isPhoto = YES;
            [self.dataSource_photo addObject:model];
        }
       
    }
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"subType" ascending:YES];
    //这个数组保存的是排序好的对象
    if (_dataSource_video.count>0) {
        NSArray *videoSort = [_dataSource_video sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];//0,1,2
        self.dataSource_video = [NSMutableArray arrayWithArray:videoSort];
    }
    if (_dataSource_photo.count>0) {
        NSArray *photoSort = [_dataSource_photo sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];//升序排列
        self.dataSource_photo = [NSMutableArray arrayWithArray:photoSort];
    }
    
    
    NSArray *auditionArr = [PlaceOrderModel getAuditionWay];
    [self.dataSource_screen addObjectsFromArray:auditionArr];

    if (isVideo==YES && isPhoto==YES) {
        viewType = 3;
    }else if(isVideo==NO && isPhoto==YES){
        viewType = 2;
    }
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    
    if(!showWindow)return;
    //当window上有视图时移除
    for (UIView *view in showWindow.subviews) {
        if ([view isKindOfClass:[LookPricePopV2 class]]) {
            return;
        }
    }
    
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0;
        }];
    self.viewType = viewType;
      [self creatClickLayoutWithType:viewType];


}
-(void)creatClickLayoutWithType:(NSInteger)viewType
{
    // 1视频 2平面 3组合
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    self.bg = bg;
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(backGroudWidth, backGroudHeight));
    }];
    
    
    
    
//    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
//    titleLab.textColor = Public_Text_Color;
//    [self addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.top.mas_equalTo(bg).offset(15);
//    }];
//    titleLab.text =@"查看报价";
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [videoBtn addTarget:self action:@selector(videoSelected) forControlEvents:UIControlEventTouchUpInside];
    [videoBtn setTitle:@"视频" forState:0];
    [videoBtn setTitleColor:Public_Text_Color forState:0];
   // [videoBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
    videoBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    videoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn addTarget:self action:@selector(photoSelected) forControlEvents:UIControlEventTouchUpInside];
    [photoBtn setTitle:@"平面" forState:0];
    [photoBtn setTitleColor:Public_Text_Color forState:0];
   // [photoBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
    photoBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
  photoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    UIButton *screeningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [screeningBtn addTarget:self action:@selector(screeningSelected) forControlEvents:UIControlEventTouchUpInside];
    [screeningBtn setTitle:@"试镜" forState:0];
    [screeningBtn setTitleColor:Public_Text_Color forState:0];
    // [photoBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
    screeningBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
     screeningBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //红色指示条
    UIView *ProgressBar = [UIView new];
    ProgressBar.backgroundColor = Public_Red_Color;
    ProgressBar.alpha = 1;
    [bg addSubview:ProgressBar];
    CGFloat progressWid = viewType==3?((backGroudWidth-30)/3):((backGroudWidth-30)/2);
    [ProgressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(progressWid);
        make.height.mas_equalTo(3);
        make.top.mas_equalTo(bg.mas_top).offset(45);
        make.left.mas_equalTo(bg).mas_offset(15);
    }];
    self.progress = ProgressBar;
    // CGFloat screeningBtnWid = viewType==3?(backGroudWidth/3):(backGroudWidth*2/3);
    CGFloat screenLeft = viewType==3?((backGroudWidth-30)*2/3):((backGroudWidth-30)/2);
      [bg addSubview:screeningBtn];
    [screeningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(progressWid);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(bg);
        make.left.mas_equalTo(screenLeft+15);
    }];
    if (viewType==1) {//视频
      //  videoBtn.userInteractionEnabled = NO;
         [bg addSubview:videoBtn];
       
        [videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(progressWid);
            make.height.mas_equalTo(45);
            make.top.mas_equalTo(bg);
            make.left.mas_equalTo(15);
                }];
    
    }else if(viewType==2){//平面
      //  photoBtn.userInteractionEnabled = NO;
          [bg addSubview:photoBtn];
        
        [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(progressWid);
            make.height.mas_equalTo(45);
            make.top.mas_equalTo(bg);
            make.left.mas_equalTo(15);
        }];
     
    }else{//组合
         [bg addSubview:videoBtn];
          [bg addSubview:photoBtn];
       
[videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(progressWid);
            make.height.mas_equalTo(45);
            make.top.mas_equalTo(bg);
            make.left.mas_equalTo(15);
        }];
        [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(progressWid);
            make.height.mas_equalTo(45);
            make.top.mas_equalTo(bg);
            make.left.mas_equalTo(progressWid+15);
        }];
   

    }

  
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(ProgressBar.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *topTip = [[UILabel alloc] init];
    topTip.text = @"▴ 视频+平面套拍，平面最低享6折优惠 ▴";
    topTip.textColor = [UIColor colorWithHexString:@"FF6600"];
    topTip.font = [UIFont systemFontOfSize:14.0];
    topTip.textAlignment = 1;
    self.tipsLabel = topTip;
    [self addSubview:topTip];
    [topTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(0);
        make.width.mas_equalTo(backGroudWidth);
        make.top.mas_equalTo(lineV.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    UITableView *tableV= [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator=YES;
    tableV.showsHorizontalScrollIndicator=YES;
    tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor whiteColor];
    tableV.tableFooterView = footView;
    [self addSubview:tableV];
    tableV.estimatedRowHeight = 0;
    tableV.estimatedSectionHeaderHeight = 0;
    tableV.estimatedSectionFooterHeight = 0;
    tableV.backgroundColor=[UIColor clearColor];
 
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.top.mas_equalTo(topTip.mas_bottom);
        make.width.mas_equalTo(backGroudWidth);
        make.height.mas_equalTo(165);
    }];
    self.tableV=tableV;
    
    tableV.tag=836913;                 //
    [tableV flashScrollIndicators];   //让tableview滚动条一直显示
   
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.text = @"• 报价说明";
    bottomLabel.textColor = Public_Text_Color;
    bottomLabel.font = [UIFont boldSystemFontOfSize:13.0];
    [bottomLabel setTag:10];
     bottomLabel.textAlignment = 0;
    
    UILabel *bottomLabel2 = [[UILabel alloc] init];
    NSString *tpString = @"此价格为购买演员的实际支付价，包含演员酬劳，平台服务费，6.4%增值税。\n下单后会有客服在半小时内和您联系，确认订单相关细节，您有任何疑惑都可直接咨询。\n跟单员费用按项目收取，300元/天，不会因购买多位演员重复收取。";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:tpString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tpString length])];
    [bottomLabel2 setAttributedText:attributedString];
   bottomLabel2.textColor = [UIColor colorWithHexString:@"#999999"];
    bottomLabel2.font = [UIFont systemFontOfSize:12.0];
     bottomLabel2.textAlignment = 0;
    bottomLabel2.numberOfLines = 0;
    [bottomLabel2 setTag:11];
   [self addSubview:bottomLabel];
     [self addSubview:bottomLabel2];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(15);
        make.right.mas_equalTo(bg).offset(-15);
        make.top.mas_equalTo(tableV.mas_bottom).offset(15);
        make.height.mas_equalTo(19);
    }];
    [bottomLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(15);
        make.right.mas_equalTo(bg).offset(-15);
        make.top.mas_equalTo(bottomLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(110);
    }];
 
}
-(void)videoSelected
{
    //progress动画+table刷新
    self.selectedType = 1;
    UILabel *bottomLabel = [self viewWithTag:11];
    bottomLabel.hidden = NO;
    UILabel *bottomLabel0 = [self viewWithTag:10];
    bottomLabel0.hidden = NO;
  self.tipsLabel.textColor = [UIColor colorWithHexString:@"FF6600"];
    [_tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(44);
        
    }];
    [_tableV mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_tipsLabel.mas_bottom);
        
    }];
    [self layoutIfNeeded];
   
    WeakSelf(self);
  
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
        weakself.tableV.height = 165;
      
        weakself.progress.transform = CGAffineTransformMakeTranslation(0, 0);//xy移动距离;
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
        
    }];
    [self.tableV reloadData];
}
-(void)photoSelected
{
    //progress动画+table刷新
    self.selectedType = 2;
    UILabel *bottomLabel0 = [self viewWithTag:10];
    bottomLabel0.hidden = NO;
    UILabel *bottomLabel = [self viewWithTag:11];
    bottomLabel.hidden = NO;
  self.tipsLabel.textColor = [UIColor colorWithHexString:@"FF6600"];
   
    [_tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(44);
        
    }];
    [_tableV mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_tipsLabel.mas_bottom);
        
    }];
     [self layoutIfNeeded];
   
    WeakSelf(self);
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
         weakself.tableV.height = 165;
       CGFloat offSetX = weakself.viewType==3?weakself.progress.width:0;
        weakself.progress.transform = CGAffineTransformMakeTranslation(offSetX, 0);//xy移动距离;
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
        
    }];
    [self.tableV reloadData];
}
-(void)screeningSelected
{
   self.selectedType = 3;
    UILabel *bottomLabel0 = [self viewWithTag:10];
    bottomLabel0.hidden = YES;
    UILabel *bottomLabel = [self viewWithTag:11];
    bottomLabel.hidden = YES;
   self.tipsLabel.textColor = [UIColor whiteColor];
    [_tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(0.1);
        
    }];
    [_tableV mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_tipsLabel.mas_bottom).offset(20);
        
    }];
    [self layoutIfNeeded];
    WeakSelf(self);
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
        weakself.tableV.height = 250;
        CGFloat offSetX = weakself.viewType==3?weakself.progress.width*2:weakself.progress.width;
        weakself.progress.transform = CGAffineTransformMakeTranslation(offSetX, 0);//xy移动距离;
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
        
    }];
    [self.tableV reloadData];
}
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;//美工要求table底端不能有横线
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectedType == 1) {
        return _dataSource_video.count;
    }else if(_selectedType == 2){
        return self.dataSource_photo.count;
    }else{
        return self.dataSource_screen.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _selectedType==3?78:56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"LookPricePopCell";
    static NSString *identifer2 = @"LookPricePopCell2";
  
    PriceModel *model = [PriceModel new];
    OrderStructM *strucctM = [OrderStructM new];
    if (_selectedType == 1) {
        model = self.dataSource_video[indexPath.row];
    }else if(_selectedType == 2){
         model = self.dataSource_photo[indexPath.row];
    }else{
        strucctM = self.dataSource_screen[indexPath.row];
    }
    if (_selectedType==3) {//用别的cell
        LookPricePopV2Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if(!cell)
        {
            cell = [[LookPricePopV2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        
        [cell reloadUIWithModel:strucctM];
        WeakSelf(self);
        cell.LookPricePopCellBlock = ^ {
            weakself.placeActionBlockWithScreening(strucctM);
            [weakself hide];
        };
      
        return cell;
    }
    
        LookPricePopCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[LookPricePopCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
    
    [cell reloadUIWithModel:model];
    WeakSelf(self);
    cell.LookPricePopCellBlock = ^{
       
            weakself.placeActionBlockWithAudition(model);
        
        [weakself hide];
    };
    
    return cell;
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
}
-(NSMutableArray*)dataSource_video
{
    if (!_dataSource_video) {
        _dataSource_video=[NSMutableArray new];
    }
    return _dataSource_video;
}
-(NSMutableArray*)dataSource_photo
{
    if (!_dataSource_photo) {
        _dataSource_photo=[NSMutableArray new];
    }
    return _dataSource_photo;
}
-(NSMutableArray*)dataSource_screen
{
    if (!_dataSource_screen) {
        _dataSource_screen=[NSMutableArray new];
    }
    return _dataSource_screen;
}
@end
@interface LookPricePopCell2 ()
@property(nonatomic,strong)UIView *bg;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
//@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *priceBtn;
@property(nonatomic,strong)UILabel *priceLabel;
//@property(nonatomic,strong)UIButton *placeOrderBtn;

@end

@implementation LookPricePopCell2
-(UIView*)bg
{
    if (!_bg) {
        _bg=[[UIView alloc]init];
        [self.contentView addSubview:_bg];
        _bg.layer.cornerRadius=5.0;
        _bg.layer.masksToBounds=YES;
        _bg.layer.borderColor = [UIColor colorWithHexString:@"#F7F7F7"].CGColor;
        _bg.layer.borderWidth = 1.5;
        _bg.backgroundColor=[UIColor whiteColor];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(4);
            make.bottom.mas_equalTo(self.contentView).offset(-4);
        }];
    }
    return _bg;
}



-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:13.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(10);
            make.centerY.mas_equalTo(self.bg);
        }];
    }
    return _titleLab;
}

-(UILabel *)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        [self.contentView addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:12.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(10);
            make.top.mas_equalTo(self.titleLab).offset(2);
        }];
    }
    return _descLab;
}
//-(UILabel*)priceLab
//{
//    if (!_priceLab) {
//        _priceLab=[[UILabel alloc]init];
//        [self.contentView addSubview:_priceLab];
//        _priceLab.font=[UIFont systemFontOfSize:13.0];
//        _priceLab.textColor=Public_Red_Color;
//        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.placeOrderBtn.mas_left).offset(-15);
//            make.centerY.mas_equalTo(self.bg);
//        }];
//    }
//    return _priceLab;
//}
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        [self.bg addSubview:_priceLabel];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = Public_Red_Color;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bg).offset(-10);
            make.left.mas_equalTo(self.titleLab.mas_right);
            make.centerY.mas_equalTo(self.bg);
        }];
    }
    return _priceLabel;
}
-(UIButton *)priceBtn
{
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bg addSubview:_priceBtn];
//        _priceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        _priceBtn.titleLabel.textColor = Public_Red_Color;
//        [_priceBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
//        _priceBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bg).offset(-10);
            make.left.mas_equalTo(self.bg);
             make.centerY.mas_equalTo(self.bg);
        }];
        [_priceBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceBtn;
}
//-(UIButton*)placeOrderBtn
//{
//    if (!_placeOrderBtn) {
//        _placeOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [self.bg addSubview:_placeOrderBtn];
//        _placeOrderBtn.backgroundColor=Public_Red_Color;
//        _placeOrderBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
//        _placeOrderBtn.layer.cornerRadius=5.0;
//        _placeOrderBtn.layer.masksToBounds=YES;
//        [_placeOrderBtn setTitle:@"下单" forState:UIControlStateNormal];
//        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.bg).offset(-4);
//            make.top.mas_equalTo(self.bg).offset(4);
//            make.bottom.mas_equalTo(self.bg).offset(-4);
//            make.width.mas_equalTo(54);
//        }];
//        [_placeOrderBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _placeOrderBtn;
//}

-(void)reloadUIWithModel:(PriceModel *)model
{
    [self bg];
   
    [self titleLab];
    [self priceLabel];
    [self priceBtn];
//[self priceLab];
    self.titleLab.text = model.title;
//    [self placeOrderBtn];
    
    NSString *price = [NSString stringWithFormat:@"%.f元/天",[PlaceOrderModel getRatioWithSinglePriceWithNew:model.price]*model.price];
    NSString *string = @"(含税总价)";
    NSString *priceString = [NSString stringWithFormat:@"%@%@",price,string];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:priceString];
    [AttributedStr addAttribute:NSForegroundColorAttributeName

                          value:[UIColor colorWithHexString:@"464646"]

                          range:NSMakeRange(price.length,string.length)];

    [AttributedStr addAttribute:NSFontAttributeName

                          value:[UIFont systemFontOfSize:13]

                          range:NSMakeRange(price.length,string.length)];
    self.priceLabel.attributedText = AttributedStr;
    
}

-(void)placeOrderAction
{
    if (self.LookPricePopCellBlock) {
        self.LookPricePopCellBlock();
    }
}
@end
