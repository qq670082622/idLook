//
//  AccountManageVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AccountManageVC.h"
#import "AccountManageTopV.h"
#import "AccountManageCell.h"
#import "AddBankCardVC.h"

@interface AccountManageVC ()<UITableViewDelegate,UITableViewDataSource,CustomTableViewDelegate>
@property (nonatomic,strong)CustomTableV *tableV;
@property (nonatomic,strong)AccountManageTopV *topV;
@property (nonatomic,assign)NSInteger cureIndex;
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong)UIView *footV;
@property(nonatomic,strong)UILabel *descLab;
@end

@implementation AccountManageVC

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@[],@[], nil];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"账户管理"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.cureIndex=0;
    [self topV];
    [self tableV];
    
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
            
            NSDictionary *bankCardInfo = (NSDictionary*)safeObjectForKey(dic, @"bankCardInfo");  //银行卡信息
            NSDictionary *aliPayInfo = (NSDictionary*)safeObjectForKey(dic, @"aliPayInfo");  //支付宝信息
            
            [self.dataSource removeAllObjects];
            NSMutableArray *sec0 = [NSMutableArray new];  //银行卡
            NSMutableArray *sec1 = [NSMutableArray new];  //支付宝
            
            if (bankCardInfo!=nil) {
                [sec0 addObject:bankCardInfo];
            }
            if (aliPayInfo!=nil) {
                [sec1 addObject:aliPayInfo];
            }
            
            [self.dataSource addObject:sec0];
            [self.dataSource addObject:sec1];
            [self.tableV reloadData];
            [self reloadTableView];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

-(AccountManageTopV*)topV
{
    if (!_topV) {
        _topV=[[AccountManageTopV alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 44.5)];
        [self.view addSubview:_topV];
        WeakSelf(self);
        _topV.AccountManageTypeClickBlock = ^(NSInteger type) {
            weakself.cureIndex=type;
            [weakself.tableV reloadData];
            [weakself reloadTableView];
        };
    }
    return _topV;
}


- (CustomTableV *)tableV
{
    if(!_tableV)
    {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0, 45, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-45) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.bounces=YES;
        _tableV.dele=self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.tableFooterView=[self tableFootV];
    }
    return _tableV;
}

-(UIView*)tableFootV
{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 50)];
    
    UIImageView *promtV=[[UIImageView alloc]init];
    [footV addSubview:promtV];
    promtV.contentMode=UIViewContentModeScaleAspectFill;
    promtV.image=[UIImage imageNamed:@"order_promt"];
    [promtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footV).offset(0);
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
        make.top.mas_equalTo(footV).offset(0);
    }];
    
    NSString *str=@"仅可添加一张银行卡，如有疑问，请联系脸探平台客服。 (客服电话：400-833-6969）";
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#47AEFF"]} range:NSMakeRange(str.length-13,12)];
    descLab.attributedText=attStr;
    self.descLab=descLab;
    self.footV=footV;
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
    return [self.dataSource[self.cureIndex] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"AccountManageCell";
    AccountManageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[AccountManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    NSDictionary *dic = self.dataSource[self.cureIndex][indexPath.row];
    [cell reloadUIWithDic:dic withType:self.cureIndex];
    WeakSelf(self);
    cell.modifyAccountBlock = ^{  //修改
        AddBankCardVC *bankVC=[[AddBankCardVC alloc]init];
        bankVC.type=weakself.cureIndex;
        bankVC.accountInfo=dic;
        bankVC.refreshUI = ^{
            [weakself getBankAndAlipay];
        };
        [weakself.navigationController pushViewController:bankVC animated:YES];
    };
    return cell;
}


-(void)reloadTableView
{
    NSArray *array = self.dataSource[self.cureIndex];
    [self.tableV hideNoDataScene];
    if (array.count==0) {
        [self.tableV showWithNoDataType:self.cureIndex==0?NoDataTypeBankCard:NoDataTypeAlipay];
        self.footV.hidden=YES;
    }
    else
    {
        self.footV.hidden=NO;
    }
    
    
    NSString *str=@"";
    if (self.cureIndex==0) {
        str=@"仅可添加一张银行卡，如有疑问，请联系脸探平台客服。 (客服电话：400-833-6969）";
    }
    else
    {
        str=@"仅可添加一个支付宝账号，如有疑问，请联系脸探平台客服。 (客服电话：400-833-6969）";
    }
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#47AEFF"]} range:NSMakeRange(str.length-13,12)];
    self.descLab.attributedText=attStr;
}

#pragma mark--CustomTableViewDelegate
-(void)CustomTableViewButtonClicked
{
    AddBankCardVC *bankVC=[[AddBankCardVC alloc]init];
    bankVC.type=self.cureIndex;
    bankVC.refreshUI = ^{
        [self getBankAndAlipay];
    };
    [self.navigationController pushViewController:bankVC animated:YES];
}

@end
