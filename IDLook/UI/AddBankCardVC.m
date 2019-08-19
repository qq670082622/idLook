//
//  AddBankCardVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddBankCardVC.h"
#import "AddCardCell.h"

@interface AddBankCardVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property (nonatomic,strong)TouchTableV *tableV;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation AddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self getData];
    
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//协议
-(void)lookProtocolAction
{
    
}

-(void)getData
{
    //银行卡
    if (self.type==0) {
        NSString *accountName = @"";
        NSString *bankCardNo = @"";
        NSString *bankName = @"";
        NSString *bankBranch = @"";

        if (self.accountInfo!=nil) {
            accountName=(NSString*)safeObjectForKey(self.accountInfo, @"accountName");
            bankCardNo=(NSString*)safeObjectForKey(self.accountInfo, @"bankCardNo");
            bankName=(NSString*)safeObjectForKey(self.accountInfo, @"bankName");
            bankBranch=(NSString*)safeObjectForKey(self.accountInfo, @"bankBranch");
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改银行卡"]];
        }
        else
        {
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"添加银行卡"]];
        }
        self.dataSource=[[NSMutableArray alloc]initWithArray:
                         @[@{@"title":@"持卡人",@"content":accountName,@"placeholder":@"请填写持卡人姓名"},
                           @{@"title":@"银行卡号",@"content":bankCardNo,@"placeholder":@"请填写银行卡号"},
                           @{@"title":@"开户银行",@"content":bankName,@"placeholder":@"请填写开户银行"},
                           @{@"title":@"开户支行",@"content":bankBranch,@"placeholder":@"请填写开户支行"}]];
    }
    else  //支付宝
    {
        NSString *aliPayName = @"";
        NSString *aliPayId = @"";
        if (self.accountInfo!=nil) {
            aliPayName=(NSString*)safeObjectForKey(self.accountInfo, @"aliPayName");
            aliPayId=(NSString*)safeObjectForKey(self.accountInfo, @"aliPayId");
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改支付宝账号"]];
        }
        else
        {
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"添加支付宝账号"]];
        }
        self.dataSource=[[NSMutableArray alloc]initWithArray:
                         @[@{@"title":@"姓名",@"content":aliPayName,@"placeholder":@"请填写支付宝账号姓名"},
                           @{@"title":@"支付宝账号",@"content":aliPayId,@"placeholder":@"请填写支付宝账号"}]];
    }
}

-(void)confrimAction
{
    for (int i=0; i<self.dataSource.count; i++) {
        NSString *content = self.dataSource[i][@"content"];
        if (content.length==0) {
            [SVProgressHUD showImage:nil status:@"请将信息填写完整"];
            return;
        }
    }
    
    if (!IsBankCardNumber(self.dataSource[1][@"content"]) && self.type==0 ) {
        [SVProgressHUD showImage:nil status:@"请输入合法的银行卡号"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"保存中" maskType:SVProgressHUDMaskTypeClear];
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]init];
    [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userId"];
    if (self.type==0) {  //银行卡
        NSDictionary *dic = @{@"accountName":self.dataSource[0][@"content"],@"bankCardNo":self.dataSource[1][@"content"],@"bankName":self.dataSource[2][@"content"],@"bankBranch":self.dataSource[3][@"content"]};
        
        [dicArg setObject:dic forKey:@"bankCardInfo"];
    }
    else{  //支付宝
        NSDictionary *dic = @{@"aliPayName":self.dataSource[0][@"content"],@"aliPayId":self.dataSource[1][@"content"]};
        [dicArg setObject:dic forKey:@"aliPayInfo"];
    }

    [AFWebAPI_JAVA updateBankCardAndAliPayWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        
            if (self.refreshUI) {
                self.refreshUI();
            }
            [self onGoback];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

- (TouchTableV *)tableV
{
    if(!_tableV)
    {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0.5,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.bounces=NO;
        _tableV.touchDelegate=self;
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
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 120)];
    
    UIButton *confrimBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [footV addSubview:confrimBtn];
    confrimBtn.layer.cornerRadius=5;
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.backgroundColor=Public_Red_Color;
    [confrimBtn setTitle:@"保存" forState:UIControlStateNormal];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footV);
        make.left.mas_equalTo(footV).offset(15);
        make.top.mas_equalTo(footV).offset(30);
        make.height.mas_equalTo(48);
    }];
    [confrimBtn addTarget:self action:@selector(confrimAction) forControlEvents:UIControlEventTouchUpInside];
    
#if 0
    UIImageView *icon=[[UIImageView alloc]init];
    [footV addSubview:icon];
    icon.image=[UIImage imageNamed:@"project_prompt"];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footV).offset(15);
        make.left.mas_equalTo(footV).offset(15);
    }];
    
    UILabel *desLab = [[MLLabel alloc] init];
    desLab.font = [UIFont systemFontOfSize:12];
    desLab.textColor = Public_DetailTextLabelColor;
    desLab.text=@"已阅读并同意";
    desLab.numberOfLines=0;
    [footV addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footV).offset(33);
        make.centerY.mas_equalTo(icon);
    }];
    
    UIButton *lookProtBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [footV addSubview:lookProtBtn];
    [lookProtBtn setTitle:@"《脸探平台相关协议》》" forState:UIControlStateNormal];
    [lookProtBtn setTitleColor:[UIColor colorWithHexString:@"#00B0FF"] forState:UIControlStateNormal];
    lookProtBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [lookProtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(desLab);
        make.left.mas_equalTo(desLab.mas_right).offset(0);
    }];
    [lookProtBtn addTarget:self action:@selector(lookProtocolAction) forControlEvents:UIControlEventTouchUpInside];
#endif
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
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"AddCardCell";
    AddCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[AddCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        if (indexPath.row==1) {
            cell.textField.keyboardType=UIKeyboardTypePhonePad;
        }
    }
    [cell reloadUIWithDic:self.dataSource[indexPath.row]];
    WeakSelf(self);
    WeakSelf(cell);
    cell.textFielChangeBlock = ^(NSString * _Nonnull text) {
        NSDictionary *dic = weakself.dataSource[indexPath.row];
        NSDictionary *newDic = @{@"title":dic[@"title"],@"content":text,@"placeholder":dic[@"placeholder"]};
        [weakself.dataSource replaceObjectAtIndex:(NSUInteger)indexPath.row withObject:newDic];
        if (indexPath.row==1&&self.type==0) {
            NSString *bankName = [self returnBankName:text];
            NSLog(@"bankname--%@",bankName);
            NSDictionary *dic1 = weakself.dataSource[2];
            NSDictionary *newDic1 = @{@"title":dic1[@"title"],@"content":bankName,@"placeholder":dic1[@"placeholder"]};
            [weakself.dataSource replaceObjectAtIndex:2 withObject:newDic1];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    };
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

//根据卡号判断银行
- (NSString *)returnBankName:(NSString *)cardName {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"bank" ofType:@"plist"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *bankBin = resultDic.allKeys;
    if (cardName.length < 6) {
        return @"";
    }
    NSString *cardbin_6 ;
    if (cardName.length >= 6) {
        cardbin_6 = [cardName substringWithRange:NSMakeRange(0, 6)];
    }
    NSString *cardbin_8 = nil;
    if (cardName.length >= 8) {
        //8位
        cardbin_8 = [cardName substringWithRange:NSMakeRange(0, 8)];
    }
    if ([bankBin containsObject:cardbin_6]) {
        return [resultDic objectForKey:cardbin_6];
    } else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    } else {
        return @"";
    }
    return @"";
    
}

@end
