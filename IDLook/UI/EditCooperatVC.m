//
//  EditCooperatVC.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditCooperatVC.h"
#import "EditCoopertCell.h"

@interface EditCooperatVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataS;
@end

@implementation EditCooperatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"可合作内容"]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"保存" Target:self action:@selector(save)]]];
    
    [self getData];
    
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    self.dataS =[NSMutableArray new];
    
    NSDictionary *dic =[UserInfoManager getPublicConfig];
    NSArray *array1 = dic[@"categoryType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dicA = array1[i];
        NSInteger cateid =[[dicA objectForKey:@"cateid"] integerValue];
        if (cateid==[UserInfoManager getUserAgeType]) {
            NSArray *arr =dicA[@"attribute"][@"performingType"];
            for (int j=0; j<arr.count; j++) {
                NSDictionary *dicB= arr[j];
                [self.dataS addObject:dicB[@"attrname"]];
            }
        }
    }
}

-(void)save
{
    EditCoopertCell *cell = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (cell.selectArray.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择标签～"];
        return;
    }
    
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSString *tempString = [cell.selectArray componentsJoinedByString:@"|"];//分隔符逗号

    NSDictionary *dicAry =@{@"userid":[UserInfoManager getUserUID],
                            @"performtype":tempString};
    
    [AFWebAPI modifMyotherInfoWithAry:dicAry callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            NSDictionary *dic = [object objectForKey:JSON_data];
            
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            [UserInfoManager setUserLoginfo:uinfo];
            
            self.saveRefreshUI();
            [self onGoback];
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
        _tableV.bounces=NO;
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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120+((self.dataS.count-1)/4+1)*44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"EditCoopertCell";
    EditCoopertCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[EditCoopertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer withDataS:self.dataS];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    return cell;
}


@end
