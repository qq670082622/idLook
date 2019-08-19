//
//  LookPricePopV.m
//  IDLook
//
//  Created by HYH on 2018/7/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LookPricePopV.h"
#import "PlaceOrderModel.h"

@interface LookPricePopV()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UITableView *tableV;
@end

@implementation LookPricePopV

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)showWithArray:(NSArray *)array
{
    [self.dataSource removeAllObjects];
    for (int i=0; i<array.count; i++) {
        PriceModel *model = [[PriceModel alloc]initWithDic:array[i]];
        [self.dataSource addObject:model];
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
        if ([view isKindOfClass:[LookPricePopV class]]) {
            return;
        }
    }
    
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self creatClickLayout];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    
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

-(void)hidekeyboard
{
    [self endEditing:YES];
}

-(void)creatClickLayout
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(305, 350));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text =@"查看报价";
    
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
        make.top.mas_equalTo(bg).offset(45);
        make.height.mas_equalTo(0.5);
    }];
    
    UITableView *tableV= [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator=YES;
    tableV.showsHorizontalScrollIndicator=YES;
    tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:tableV];
    tableV.estimatedRowHeight = 0;
    tableV.estimatedSectionHeaderHeight = 0;
    tableV.estimatedSectionFooterHeight = 0;
    tableV.backgroundColor=[UIColor clearColor];
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(45);
        make.bottom.mas_equalTo(bg);
    }];
    self.tableV=tableV;
    
    tableV.tag=836913;                 //
    [tableV flashScrollIndicators];   //让tableview滚动条一直显示

}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return .1f;
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
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"LookPricePopCell";
    LookPricePopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[LookPricePopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    PriceModel *model = self.dataSource[indexPath.row];
    [cell reloadUIWithModel:model];
    WeakSelf(self);
    cell.LookPricePopCellBlock = ^{
        if(weakself.placeActionBlock)
        {
            weakself.placeActionBlock(indexPath.row,model.title);
        }
        [weakself hide];
    };
    return cell;
}


@end

@interface LookPricePopCell ()
@property(nonatomic,strong)UIView *bg;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *placeOrderBtn;

@end

@implementation LookPricePopCell

-(UIView*)bg
{
    if (!_bg) {
        _bg=[[UIView alloc]init];
        [self.contentView addSubview:_bg];
        _bg.layer.cornerRadius=5.0;
        _bg.layer.masksToBounds=YES;
        _bg.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(25);
            make.right.mas_equalTo(self.contentView).offset(-25);
            make.top.mas_equalTo(self.contentView).offset(8);
            make.bottom.mas_equalTo(self.contentView).offset(-8);
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

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        [self.contentView addSubview:_priceLab];
        _priceLab.font=[UIFont systemFontOfSize:13.0];
        _priceLab.textColor=Public_Red_Color;
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.placeOrderBtn.mas_left).offset(-15);
            make.centerY.mas_equalTo(self.bg);
        }];
    }
    return _priceLab;
}

-(UIButton*)placeOrderBtn
{
    if (!_placeOrderBtn) {
        _placeOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bg addSubview:_placeOrderBtn];
        _placeOrderBtn.backgroundColor=Public_Red_Color;
        _placeOrderBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [_placeOrderBtn setTitle:@"下单" forState:UIControlStateNormal];
        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bg);
            make.top.mas_equalTo(self.bg);
            make.bottom.mas_equalTo(self.bg);
            make.width.mas_equalTo(49);
        }];
        [_placeOrderBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeOrderBtn;
}

-(void)reloadUIWithModel:(PriceModel *)model
{
    [self bg];
    self.priceLab.text=[NSString stringWithFormat:@"%.f元/天",[PlaceOrderModel getRatioWithSinglePrice:model.price]*model.price+300];
    self.titleLab.text = model.title;
    [self placeOrderBtn];
}

-(void)placeOrderAction
{
    if (self.LookPricePopCellBlock) {
        self.LookPricePopCellBlock();
    }
}


@end
