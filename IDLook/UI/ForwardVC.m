//
//  ForwardVC.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ForwardVC.h"
#import "ForwardHeadView.h"
#import "ForwardCellA.h"
#import "ForwardCellB.h"
#import "AccountManageVC.h"
#import "AddBankCardVC.h"

@interface ForwardVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>

@property (nonatomic,strong)TouchTableV *tableV;
@property (nonatomic,strong)ForwardHeadView *headView;
@property (nonatomic,assign)NSInteger cureIndex;
@property (nonatomic,strong)NSDictionary *accountInfo;

@end

@implementation ForwardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"提现"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"账户管理" Target:self action:@selector(AccountManage)]]];

    self.cureIndex=0;
    
    [self headView];
    [self tableV];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self getBankAndAlipay];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getBankAndAlipay
{
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID]};
    [AFWebAPI_JAVA getCardAndAliPayListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            self.accountInfo=dic;
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

//账户管理
-(void)AccountManage
{
    AccountManageVC *manageVC= [[AccountManageVC alloc]init];
    [self.navigationController pushViewController:manageVC animated:YES];
}

-(ForwardHeadView*)headView
{
    if (!_headView) {
        _headView=[[ForwardHeadView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 44.5)];
        [self.view addSubview:_headView];
        WeakSelf(self);
        _headView.forwardTypeClickBlock = ^(NSInteger type) {
            weakself.cureIndex=type;
            [weakself.tableV reloadData];
        };
    }
    return _headView;
}

- (TouchTableV *)tableV
{
    if(!_tableV)
    {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0, 45, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-45) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
        _tableV.bounces=YES;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.tableFooterView = [self tableFootV];
    }
    return _tableV;
}

-(UIView*)tableFootV
{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 150)];

    UIButton *confrimBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [footV addSubview:confrimBtn];
    confrimBtn.layer.cornerRadius=5;
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.backgroundColor=Public_Red_Color;
    [confrimBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footV);
        make.left.mas_equalTo(footV).offset(15);
        make.top.mas_equalTo(footV).offset(30);
        make.height.mas_equalTo(48);
    }];
    [confrimBtn addTarget:self action:@selector(confrimAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *promtV=[[UIImageView alloc]init];
    [footV addSubview:promtV];
    promtV.contentMode=UIViewContentModeScaleAspectFill;
    promtV.image=[UIImage imageNamed:@"order_promt"];
    [promtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(confrimBtn.mas_bottom).offset(18);
        make.left.mas_equalTo(footV).offset(15);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    UILabel *descLab = [[UILabel alloc]init];
    descLab.numberOfLines=0;
    descLab.font=[UIFont systemFontOfSize:12.0];
    descLab.textColor=Public_DetailTextLabelColor;
    [footV addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footV).offset(32);
        make.right.mas_equalTo(footV).offset(-15);
        make.top.mas_equalTo(confrimBtn.mas_bottom).offset(15);
    }];
    
    NSString *str=@"申请提现后，脸探平台会在24小时内处理。如有疑问，请联系脸探平台客服。(客服电话：400-833-6969）";
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#47AEFF"]} range:NSMakeRange(str.length-13,12)];
    descLab.attributedText=attStr;
    
    return footV;
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 120;
    }
    return 144;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *identifer = @"ForwardCellB";
        ForwardCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[ForwardCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithDic:self.accountInfo withType:self.cureIndex];
        return cell;
    }
    else if (indexPath.row==1)
    {
        static NSString *identifer = @"ForwardCellA";
        ForwardCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[ForwardCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithTotal:self.totalMoney];
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        
        NSDictionary *bankCardInfo = (NSDictionary*)safeObjectForKey(self.accountInfo, @"bankCardInfo");  //银行卡信息
        NSDictionary *aliPayInfo = (NSDictionary*)safeObjectForKey(self.accountInfo, @"aliPayInfo");  //支付宝信息
        
        AddBankCardVC *bankVC=[[AddBankCardVC alloc]init];
        bankVC.type=self.cureIndex;
        bankVC.accountInfo=self.cureIndex==0?bankCardInfo:aliPayInfo;
        bankVC.refreshUI = ^{
            [self getBankAndAlipay];
        };
        [self.navigationController pushViewController:bankVC animated:YES];
    
    }
}

//确认提现
-(void)confrimAction
{
    ForwardCellA *cell = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (cell.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请输入金额"];
        return;
    }
    if ([cell.textField.text floatValue]>self.totalMoney ) {
        [SVProgressHUD showImage:nil status:@"您提现的金额超出总余额"];
        return;
    }
    if ([cell.textField.text floatValue]<=0) {
        [SVProgressHUD showImage:nil status:@"您提现的金额需大于零元"];
        return;
    }
    
     [SVProgressHUD showWithStatus:@"提现中" maskType:SVProgressHUDMaskTypeClear];
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]init];
    [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userId"];
    [dicArg setObject:cell.textField.text forKey:@"drawPrice"];

    NSDictionary *bankCardInfo = (NSDictionary*)safeObjectForKey(self.accountInfo, @"bankCardInfo");  //银行卡信息
    NSDictionary *aliPayInfo = (NSDictionary*)safeObjectForKey(self.accountInfo, @"aliPayInfo");  //支付宝信息
    
    if (self.cureIndex==0) {
        if (bankCardInfo==nil) {
            [SVProgressHUD showImage:nil status:@"请添加银行卡"];
            return;
        }
        [dicArg setObject:bankCardInfo forKey:@"bankCardInfo"];
    }
    else
    {
        if (aliPayInfo==nil) {
            [SVProgressHUD showImage:nil status:@"请添加支付宝"];
            return;
        }
        [dicArg setObject:aliPayInfo forKey:@"aliPayInfo"];
    }
    
    [AFWebAPI_JAVA getwithdrawCashWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"提现申请已提交，请等待后台审核"];
            self.refreshUI();
            [self onGoback];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
    
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
