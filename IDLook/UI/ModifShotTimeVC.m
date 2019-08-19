//
//  ModifShotTimeVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ModifShotTimeVC.h"
#import "ScheduleCellC.h"
#import "CalenderPopV.h"

@interface ModifShotTimeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ModifShotTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改拍摄时间"]];
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
                       @{@"title":@"拍摄时间",@"start":self.info.shotStart,@"end":self.info.shotEnd},
                       nil];
    
    
}

//提交
-(void)submitAction
{
    NSDictionary *dic = self.dataSource[0];
    if ([dic[@"start"]length]==0 || [dic[@"end"]length]==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄日期"];
        return;
    }
    
    NSDictionary *dicArg = @{@"operate":@(307),
                             @"orderIdList":@[self.info.orderId],
                             @"userId":[UserInfoManager getUserUID],
                             @"userType":@([UserInfoManager getUserType]),
                             @"shotOrderInfo":@{
                                                 @"shotStartDate":dic[@"start"],
                                                 @"shotEndDate":dic[@"end"],
                                                 },
                             @"userId":[UserInfoManager getUserUID]
                             };
    [SVProgressHUD showWithStatus:@"正在提交。。。"];
    [AFWebAPI_JAVA getLockScheduleProcessWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [self onGoback];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
        _tableV.tableFooterView=[self tableFootV];

    }
    return _tableV;
}

-(UIView*)tableFootV
{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 190)];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor=Public_Red_Color;
    commitBtn.layer.cornerRadius=5.0;
    commitBtn.layer.masksToBounds=YES;
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [footV addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footV);
        make.left.mas_equalTo(footV).offset(15);
        make.top.mas_equalTo(footV).offset(110);
        make.height.mas_equalTo(48);
    }];
    [commitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLab=[[UILabel alloc]init];
    titleLab.font=[UIFont systemFontOfSize:13.0];
    titleLab.textColor=Public_Text_Color;
    titleLab.text=@"• 温馨提示";
    [footV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footV).offset(15);
        make.top.mas_equalTo(footV).offset(12);
    }];
    
    MLLabel *descLab=[[MLLabel alloc]init];
    descLab.numberOfLines=0;
    descLab.lineSpacing=5.0;
    descLab.textAlignment=NSTextAlignmentLeft;
    descLab.font=[UIFont systemFontOfSize:12.0];
    descLab.textColor=Public_DetailTextLabelColor;
    [footV addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footV).offset(15);
        make.centerX.mas_equalTo(footV);
        make.top.mas_equalTo(footV).offset(30);
    }];
    descLab.text=@"脸探平台会在24小时内通知演员回复您的定妆通知，演员如若不接受或没有回复您的定妆通知，请及时联系脸探平台，客服电话：400-8336969。";
    
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
    return 1.f;
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
    static NSString *identifer = @"ScheduleCellC";
    ScheduleCellC *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[ScheduleCellC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell reloadUIWithDic:self.dataSource[indexPath.row]];
    WeakSelf(self);
    cell.dateSelectWithType = ^(NSInteger type) {
        
    };
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataSource[indexPath.row];
    WeakSelf(self);
    CalenderPopV *popV= [[CalenderPopV alloc]init];
    [popV showWithType:1 withStart:self.info.projectInfo[@"projectStart"] withEnd:self.info.projectInfo[@"projectEnd"] withSelectStart:dic[@"start"] withSelectEnd:dic[@"end"]];
    popV.CalenderPopVBlock = ^(NSString * _Nonnull startDay, NSString * _Nonnull endDay) {
        NSDictionary *newDic = @{@"title":dic[@"title"],@"start":startDay,@"end":endDay};
        [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:newDic];
        [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };    
}

@end
