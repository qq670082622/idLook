//
//  UserDetialInfoVC.m
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserDetialInfoVC.h"
#import "UserInfoDVCM.h"
#import "DetialHeaderV.h"
#import "BasicInfoCell.h"
#import "GraduatedSchoolCell.h"
#import "BriefInfoCell.h"
#import "CertificateCell.h"

@interface UserDetialInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property (nonatomic,strong)UserInfoDVCM *dataM;

@end

@implementation UserDetialInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"个人详情"]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self dataM];
    [self tableV];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UserInfoDVCM *)dataM
{
    if (!_dataM)
    {
        _dataM = [[UserInfoDVCM alloc] init];
        _dataM.info=self.info;
        [_dataM refreshUserInfo];
    }
    return _dataM;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX) style:UITableViewStyleGrouped];
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
        _tableV.backgroundColor=[UIColor clearColor];
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataM.ds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataM.ds[section]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dataM.ds[indexPath.section][indexPath.row] objectForKey:kUserInfoDVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kUserInfoDVCMCellClass];
    UserInfoCellDType type = [[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kUserInfoDVCMCellType] integerValue];
    
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }

     if (type==UserInfoCellDTypeCertificate) {
        CertificateCell *cell = (CertificateCell *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *url = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kUserInfoDVCMCellData];
        [cell reloadUIWithUrl:url];
    }
    
    else if (type==UserInfoCellDTypeBasicinfo)
    {
        BasicInfoCell *cell = (BasicInfoCell *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row%2==0) {
            cell.backgroundColor=[UIColor colorWithHexString:@"#FAFAFA"];
        }
        else
        {
            cell.backgroundColor=[UIColor whiteColor];
        }
        NSArray *array = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kUserInfoDVCMCellData];
        [cell reloadUIWithArray:array];
    }
    
    else if (type==UserInfoCellDTypeSchool)
    {
        GraduatedSchoolCell *cell = (GraduatedSchoolCell *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row%2==0) {
            cell.backgroundColor=[UIColor colorWithHexString:@"#FAFAFA"];
        }
        else
        {
            cell.backgroundColor=[UIColor whiteColor];
        }
        NSString *content = [(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kUserInfoDVCMCellData];
        [cell reloadUiWithContent:content];
    }
    else if (type==UserInfoCellDTypeBrief || type==UserInfoCellDTypeWorks)
    {
        BriefInfoCell *cell = (BriefInfoCell *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *content=[(NSDictionary *)self.dataM.ds[sec][row] objectForKey:kUserInfoDVCMCellData];
        if (content.length==0) {
            if (type==UserInfoCellDTypeBrief) {
                content=@"暂无简介";
            }
            else
            {
                content=@"暂无代表作品";
            }
        }
        [cell reloadUiWithContent:content];
    }
    
    
    return obj;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = self.dataM.ds[section] ;
    UserInfoCellDType type = [[(NSDictionary *)[array firstObject] objectForKey:kUserInfoDVCMCellType] integerValue];
    static NSString *identifer = @"DetialHeaderV";
    DetialHeaderV *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!headerView)
    {
        headerView = [[DetialHeaderV alloc] initWithReuseIdentifier:identifer];
        [headerView.backgroundView setBackgroundColor:[UIColor clearColor]];
    }
    
    [headerView reloadUIWithType:type];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoCellDType type = [[(NSDictionary *)self.dataM.ds[indexPath.section][indexPath.row] objectForKey:kUserInfoDVCMCellType] integerValue];
    if (type==UserInfoCellDTypeCertificate) {
        CertificateCell *cell =[self.tableV cellForRowAtIndexPath:indexPath];
        NSString *url = [(NSDictionary *)self.dataM.ds[indexPath.section][indexPath.row] objectForKey:kUserInfoDVCMCellData];
        NSArray *array = @[url];
        LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
        [lookImage showWithImageArray:array curImgIndex:0 AbsRect:cell.contentView.bounds];
        [self.navigationController pushViewController:lookImage animated:YES];
        lookImage.downPhotoBlock = ^(NSInteger index) {};
    }
}

@end
