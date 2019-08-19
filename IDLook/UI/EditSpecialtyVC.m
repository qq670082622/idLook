//
//  EditSpecialtyVC.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditSpecialtyVC.h"
#import "EditBasicCell.h"
#import "PublicPickerView.h"
#import "CustTableViewCell.h"
#import "EditInfoVC.h"

@interface EditSpecialtyVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation EditSpecialtyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"专业信息"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"保存" Target:self action:@selector(save)]]];
   
    NSString *occouption=@"";
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if ([UserInfoManager getUserOccupation] == [dic[@"attrid"] integerValue]) {
            occouption=dic[@"attrname"];
        }
    }
    
    self.dataSource = [[NSMutableArray alloc]initWithObjects:
                       @{@"title":@"职业",@"content":occouption,@"desc":@"未填写",@"type":@(EditTypeOther),@"placeholder":@"",@"isSave":@(NO),@"parameter":@"",@"isRequired":@(YES)},
                       @{@"title":@"毕业院校",@"content":[UserInfoManager getUserSchoolInfo],@"desc":@"未填写",@"type":@(EditTypeGraduatSchool),@"placeholder":@"请填写毕业院校",@"isSave":@(NO),@"parameter":@"region",@"isRequired":@(NO)},
                       @{@"title":@"年级",@"content":[UserInfoManager getUserGrade],@"desc":@"未填写",@"type":@(EditTypeOther),@"placeholder":@"",@"isSave":@(NO),@"parameter":@"",@"isRequired":@(NO)},
                       @{@"title":@"专业",@"content":[UserInfoManager getUserSpecialty],@"type":@(EditTypeSpecialty),@"placeholder":@"请填写专业",@"isSave":@(NO),@"parameter":@"region",@"desc":@"未填写",@"isRequired":@(NO)},nil];
    [self tableV];
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    NSInteger occupation=0;
    
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if ([dic[@"attrname"] isEqualToString:self.dataSource[0][@"content"]]) {
            occupation = [dic[@"attrid"] integerValue];
        }
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicAry =@{@"userid":[UserInfoManager getUserUID],
                            @"occupation":@(occupation),
                            @"academy":self.dataSource[1][@"content"],
                            @"grade":self.dataSource[2][@"content"],
                            @"specialty":self.dataSource[3][@"content"]
                            };
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
    
    if (indexPath.row==1 || indexPath.row==3) {
        EditInfoVC *editVC=[[EditInfoVC alloc]init];
        editVC.info=self.dataSource[indexPath.row];
        WeakSelf(self);
        editVC.didSelectBlock = ^(NSString *select) {
            NSDictionary *dic = weakself.dataSource[indexPath.row];
            
            NSDictionary *dic2 = @{@"title":dic[@"title"],@"content":select,@"desc":dic[@"desc"],@"isRequired":dic[@"isRequired"]};
            
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:dic2];
            
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:editVC animated:YES];
    }
    else
    {
        PublicPickerView *pickerV = [[PublicPickerView alloc] init];
        pickerV.title=self.dataSource[indexPath.row][@"title"];
        WeakSelf(self);
        pickerV.didSelectBlock = ^(NSString *select) {
            if ([select isEqualToString:@"暂不填写"]) {
                select=@"";
            }
            
            NSDictionary *dic = weakself.dataSource[indexPath.row];
            NSDictionary *dic2 = @{@"title":dic[@"title"],@"content":select,@"desc":dic[@"desc"],@"isRequired":dic[@"isRequired"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:dic2];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [pickerV showWithPickerType:indexPath.row+6 withDesc:self.dataSource[indexPath.row][@"content"]];
    }
}

@end
