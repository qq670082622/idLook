//
//  RoleServiceDetialVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "RoleServiceDetialVC.h"
#import "AuditServiceDetialCellA.h"
#import "AuditServiceDetialCellB.h"
#import "PayWaysVC.h"

@interface RoleServiceDetialVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)UIView *bottomV;
@end

@implementation RoleServiceDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"订单详情"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self tableV];
    [self initUI];
    [self refreshBottomView];

}

-(void)onGoback
{
    self.refreshDataBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

//去支付
-(void)payAction
{
    PayWaysVC *payVC=[[PayWaysVC alloc]init];
    payVC.orderids=self.model.orderId;
    payVC.totalPrice=self.model.totalPrice;
    WeakSelf(self);
    payVC.refreshData = ^{
        [weakself paySuccessBack];
    };
    [self.navigationController pushViewController:payVC animated:YES];
}

//刷新底部view
-(void)refreshBottomView
{
    if (self.model.status==0) {
        self.bottomV.hidden=NO;
    }
    else{
        self.bottomV.hidden=YES;
    }
}

-(void)initUI
{
    UIView *bg = [[UIView alloc]init];
    [self.view addSubview:bg];
    bg.backgroundColor=[UIColor whiteColor];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(48+SafeAreaTabBarHeight_IphoneX);
    }];
    self.bottomV=bg;
    
    UIButton *payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [bg addSubview:payBtn];
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    payBtn.layer.cornerRadius=4;
    payBtn.layer.masksToBounds=YES;
    payBtn.backgroundColor=Public_Red_Color;
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bg).offset(7);
        make.right.mas_equalTo(self.view).offset(-9);
        make.size.mas_equalTo(CGSizeMake(112, 35));
    }];
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];

}

-(UITableView*)tableV
{
    if (!_tableV) {
        CGFloat height = 0;
        if (self.model.status==0) {
            height=48+SafeAreaTabBarHeight_IphoneX;
        }
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-height) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
    }
    return _tableV;
}


#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 77+54+75+[self heighOfString:self.model.remark font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100];
    }
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *identifer = @"AuditServiceDetialCellA";
        AuditServiceDetialCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuditServiceDetialCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithModel:self.model];
        return cell;
    }
    else
    {
        static NSString *identifer = @"AuditServiceDetialCellB";
        AuditServiceDetialCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuditServiceDetialCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithModel:self.model];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 5;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20?20:ceilf(size.height);
}


-(void)paySuccessBack
{
    NSDictionary *dicArg = @{@"orderIdList":@[self.model.orderId],
                             @"orderType":@(11),
                             @"status":@"paied",
                             @"userId":[UserInfoManager getUserUID]
                             };
    [AFWebAPI_JAVA getPaySuccessBackWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            self.model.status=1;
            [self refreshBottomView];
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

@end
