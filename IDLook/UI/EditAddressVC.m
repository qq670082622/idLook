//
//  EditAddressVC.m
//  IDLook
//
//  Created by HYH on 2018/8/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditAddressVC.h"
#import "CustTableViewCell.h"
#import "RegionChooseVC.h"
#import "EditInfoVC.h"

@interface EditAddressVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation EditAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"联系地址"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"保存" Target:self action:@selector(save)]]];
    
    [self getData];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    
    self.dataSource = [[NSMutableArray alloc]initWithObjects:
                       @{@"title":@"所在地",@"content":[UserInfoManager getUserRegion],@"desc":@"暂未填写",@"type":@(EditTypeRegion),@"placeholder":@"",@"isSave":@(NO),@"parameter":@"region",@"isRequired":@(YES)},
                       @{@"title":@"详细通讯地址",@"content":[UserInfoManager getUserAddress],@"desc":@"暂未填写",@"type":@(EditTypeAddress),@"placeholder":@"请输入详细通讯地址",@"isSave":@(NO),@"parameter":@"address",@"isRequired":@(YES)},
                       @{@"title":@"邮政编码",@"content":[UserInfoManager getUserPostalCode],@"desc":@"暂未填写",@"type":@(EditTypePostCode),@"placeholder":@"请输入邮政编码",@"isSave":@(NO),@"parameter":@"postalcode",@"isRequired":@(NO)},
                       @{@"title":@"电子邮箱",@"content":[UserInfoManager getUserEmail],@"desc":@"暂未填写",@"type":@(EditTypeEmail),@"placeholder":@"请输入电子邮箱",@"isSave":@(NO),@"parameter":@"email",@"isRequired":@(NO)},
                       @{@"title":@"紧急联系人",@"content":[UserInfoManager getUserContactnumber1],@"desc":@"暂未填写",@"type":@(EditTypeUrgentName),@"placeholder":@"请输入紧急联系人",@"isSave":@(NO),@"parameter":@"contactnumber1",@"isRequired":@(YES)},
                       @{@"title":@"紧急联系人电话",@"content":[UserInfoManager getUserContactnumber2],@"desc":@"暂未填写",@"type":@(EditTypeUrgentPhone1),@"placeholder":@"请输入紧急联系人电话",@"isSave":@(NO),@"parameter":@"contactnumber2",@"isRequired":@(YES)}, nil];
    
    [self.tableV reloadData];
}

-(void)save
{
    
    for (int i =0; i<self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        BOOL isRequired = [dic[@"isRequired"] boolValue];
        if (isRequired==YES && [dic[@"content"] length]==0) {
            [SVProgressHUD showImage:nil status:@"请将带*内容填写完整"];
            return;
        }
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicAry =@{@"userid":[UserInfoManager getUserUID],
                            @"region":self.dataSource[0][@"content"],
                            @"address":self.dataSource[1][@"content"],
                            @"postalcode":self.dataSource[2][@"content"],
                            @"email":self.dataSource[3][@"content"],
                            @"contactnumber1":self.dataSource[4][@"content"],
                            @"contactnumber2":self.dataSource[5][@"content"]};
    [AFWebAPI modifMyotherInfoWithAry:dicAry callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            NSDictionary *dic = [object objectForKey:JSON_data];
            
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            [UserInfoManager setUserLoginfo:uinfo];
            
            [self onGoback];
            self.saveRefreshUI();
        }
        else
        {
            AF_SHOW_RESULT_ERROR
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
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"CustTableViewCell";
    CustTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[CustTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell reloadUIWithDic:self.dataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row==0)
    {
        RegionChooseVC *regionVC=[[RegionChooseVC alloc]init];
        [self.navigationController pushViewController:regionVC animated:YES];
        WeakSelf(self);
        regionVC.selectCity = ^(NSString *city)
        {
            NSDictionary *dic = weakself.dataSource[indexPath.row];
            NSDictionary *dic2 = @{@"title":dic[@"title"],@"content":city,@"desc":@"暂未填写",@"type":dic[@"type"],@"placeholder":dic[@"placeholder"],@"isRequired":dic[@"isRequired"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:dic2];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
    else
    {
        EditInfoVC *editVC=[[EditInfoVC alloc]init];
        editVC.info=self.dataSource[indexPath.row];
        WeakSelf(self);
        editVC.didSelectBlock = ^(NSString *select) {
            NSDictionary *dic = weakself.dataSource[indexPath.row];
            NSDictionary *dic2 = @{@"title":dic[@"title"],@"content":select,@"desc":@"暂未填写",@"type":dic[@"type"],@"placeholder":dic[@"placeholder"],@"isRequired":dic[@"isRequired"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:dic2];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:editVC animated:YES];
    }
}



@end
