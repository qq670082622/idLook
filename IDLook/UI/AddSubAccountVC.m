//
//  AddSubAccountVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AddSubAccountVC.h"
#import "AddSubAccountCell.h"

@interface AddSubAccountVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation AddSubAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"添加子账号"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self getData];
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    self.dataSource = [[NSMutableArray alloc]initWithObjects:
                       @{@"title":@"账号昵称",@"content":@"",@"placeholder":@"请填写子账号昵称",@"type":@(AddSubCellTypeNick)},
                       @{@"title":@"手机号",@"content":@"",@"placeholder":@"请填写手机号",@"type":@(AddSubCellTypePhone)},
                       @{@"title":@"验证码",@"content":@"",@"placeholder":@"请填写验证码",@"type":@(AddSubCellTypeCode)},
                       @{@"title":@"账号密码",@"content":@"",@"placeholder":@"请填写子账号密码",@"type":@(AddSubCellTypePassword)}
                       , nil];
}

-(void)commitAction
{
    for (int i=0; i<self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        if ([dic[@"content"] length]==0) {
            [SVProgressHUD showImage:nil status:dic[@"placeholder"]];
            return;
        }
    }
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor = Public_LineGray_Color;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
        _tableV.tableFooterView=[self tableFootV];
    }
    return _tableV;
}

-(UIView*)tableFootV
{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 108)];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor=Public_Red_Color;
    commitBtn.layer.cornerRadius=5.0;
    commitBtn.layer.masksToBounds=YES;
    [commitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [footV addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footV);
        make.left.mas_equalTo(footV).offset(15);
        make.centerY.mas_equalTo(footV);
        make.height.mas_equalTo(48);
    }];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    static NSString *identifer = @"AddSubAccountCell";
    AddSubAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[AddSubAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    [cell reloadUIWithDic:dic];
    WeakSelf(self);
    cell.textFieldChangeBlock = ^(NSString *text) {
        NSDictionary *newDic = @{@"title":dic[@"title"],@"content":text,@"placeholder":dic[@"placeholder"],@"type":dic[@"type"]};
        [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:newDic];
    };
    cell.getVerificationCodeBlock = ^{
        [weakself getVerificationCodeAction];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

-(void)getVerificationCodeAction
{
    NSDictionary *dic = self.dataSource[1];
    
    if(!IsCorrectPhoneNumber(dic[@"content"]))
    {
        [SVProgressHUD showErrorWithStatus:@"请填写正确的手机号码"];
        return;
    }
    
    AddSubAccountCell *cell = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [cell beganTimerAction];

}


@end
