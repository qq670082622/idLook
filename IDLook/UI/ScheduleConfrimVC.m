//
//  ScheduleConfrimVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleConfrimVC.h"
#import "ScheduleCellA.h"
#import "ScheduleCellB.h"
#import "ScheduleCellC.h"
#import "CalenderPopV.h"

@interface ScheduleConfrimVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ScheduleConfrimVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"档期再确认"]];
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
                       @{@"title":@"试镜时间",@"content":@"",@"placeholder":@"请选择试镜时间"},
                       @{@"title":@"定妆时间",@"content":@"",@"placeholder":@"请选择定妆时间"},
                       @{@"title":@"拍摄时间",@"start":self.info.shotStart,@"end":self.info.shotEnd},
                       nil];
    

}

//提交
-(void)submitAction
{

    NSDictionary *dic1 = self.dataSource[0];
    NSDictionary *dic2 = self.dataSource[1];
    NSDictionary *dic3 = self.dataSource[2];
    if ([dic3[@"start"]length]==0 || [dic3[@"end"]length]==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄日期"];
        return;
    }
    
    
    ScheduleCellA *cellA=[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSDictionary *dicArg = @{@"operate":@(2),
                             @"orderId":self.info.orderId,
                             @"rescheduleInfo":@{@"auditionDate":dic1[@"content"],
                                                 @"makeupDate":dic2[@"content"],
                                                 @"shotStartDate":dic3[@"start"],
                                                 @"shotEndDate":dic3[@"end"],
                                                 @"reason":cellA.textView.text
                                                 },
                             @"userId":[UserInfoManager getUserUID]
                             };
    [SVProgressHUD showWithStatus:@"正在提交。。。"];
    [AFWebAPI_JAVA getBuyerProcesssWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
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

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
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
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 108)];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor=Public_Red_Color;
    commitBtn.layer.cornerRadius=5.0;
    commitBtn.layer.masksToBounds=YES;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [footV addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footV);
        make.left.mas_equalTo(footV).offset(15);
        make.centerY.mas_equalTo(footV);
        make.height.mas_equalTo(48);
    }];
    [commitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 200;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *identifer = @"ScheduleCellA";
        ScheduleCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[ScheduleCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUI];
        return cell;
    }
    else
    {
        if (indexPath.row==2) {
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
        else
        {
            static NSString *identifer = @"ScheduleCellB";
            ScheduleCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if(!cell)
            {
                cell = [[ScheduleCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor whiteColor];
            }
            [cell reloadUIWithDic:self.dataSource[indexPath.row]];
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        NSDictionary *dic = self.dataSource[indexPath.row];
        WeakSelf(self);
        if (indexPath.row<=1) {
            CalenderPopV *popV= [[CalenderPopV alloc]init];
            [popV showWithType:0 withStart:[PublicManager string1FromDate:[NSDate date]] withEnd:[PublicManager getTimeWithNowDateWithDay:90] withSelectStart:dic[@"content"] withSelectEnd:@""];
            popV.CalenderPopVBlock = ^(NSString * _Nonnull startDay, NSString * _Nonnull endDay) {
                NSDictionary *newDic = @{@"title":dic[@"title"],@"content":startDay,@"placeholder":dic[@"placeholder"]};
                [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:newDic];
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else
        {
            CalenderPopV *popV= [[CalenderPopV alloc]init];
            [popV showWithType:1 withStart:self.info.projectInfo[@"projectStart"] withEnd:self.info.projectInfo[@"projectEnd"] withSelectStart:dic[@"start"] withSelectEnd:dic[@"end"]];
            popV.CalenderPopVBlock = ^(NSString * _Nonnull startDay, NSString * _Nonnull endDay) {
                NSDictionary *newDic = @{@"title":dic[@"title"],@"start":startDay,@"end":endDay};
                [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:newDic];
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }

    }

}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
