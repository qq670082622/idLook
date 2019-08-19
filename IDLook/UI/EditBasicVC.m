//
//  EditBasicVC.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditBasicVC.h"
#import "EditBasicCell.h"
#import "PublicPickerView.h"
#import "CustTableViewCell.h"
#import "EditInfoVC.h"
#import "SelectLanguageV.h"

@interface EditBasicVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation EditBasicVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"基本资料"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"保存" Target:self action:@selector(save)]]];
    
    self.dataSource = [[NSMutableArray alloc]initWithObjects:
                       @{@"title":@"艺名",@"content":[UserInfoManager getUserNick],@"desc":@"未填写",@"type":@(EditTypeNick),@"placeholder":@"请输入艺名",@"isSave":@(NO),@"isRequired":@(NO)},
                       @{@"title":@"语言",@"content":[[UserInfoManager getUserLanguage] stringByReplacingOccurrencesOfString:@"|" withString:@"、"]
                         ,@"desc":@"未填写",@"type":@(EditTypeOther),@"placeholder":@"",@"isSave":@(NO),@"isRequired":@(NO)},
                       @{@"title":@"身高",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeHeight]),@"isRequired":@(YES)},
                       @{@"title":@"体重",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeWeight]),@"isRequired":@(YES)},
                       @{@"title":@"胸围",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeBust]),@"isRequired":@(YES)},
                       @{@"title":@"腰围",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeWaist]),@"isRequired":@(YES)},
                       @{@"title":@"臀围",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeHipline]),@"isRequired":@(YES)},
                       @{@"title":@"鞋码",@"content":@([UserInfoManager getUserBasicInfoWithType:PickerTypeShoeSize]),@"isRequired":@(YES)},nil];
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    for (int i =2; i<self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        BOOL isRequired = [dic[@"isRequired"] boolValue];
        NSInteger value =[dic[@"content"] integerValue];
        if (isRequired==YES && value==0) {
            [SVProgressHUD showImage:nil status:@"请将带*内容填写完整"];
            return;
        }
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicAry =@{@"userid":[UserInfoManager getUserUID],
                            @"nick":self.dataSource[0][@"content"],
                            @"language":[self.dataSource[1][@"content"] stringByReplacingOccurrencesOfString:@"、" withString:@"|"],
                            @"height":[NSString stringWithFormat:@"%@",self.dataSource[2][@"content"]],
                            @"weight":[NSString stringWithFormat:@"%@",self.dataSource[3][@"content"]],
                            @"bust":[NSString stringWithFormat:@"%@",self.dataSource[4][@"content"]],
                            @"waistline":[NSString stringWithFormat:@"%@",self.dataSource[5][@"content"]],
                            @"hipline":[NSString stringWithFormat:@"%@",self.dataSource[6][@"content"]],
                            @"shoesize":[NSString stringWithFormat:@"%@",self.dataSource[7][@"content"]]};
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
    if (indexPath.row<2) {
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
    else
    {
        static NSString *identifer = @"EditBasicCell";
        EditBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[EditBasicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithDic:self.dataSource[indexPath.row] withType:indexPath.row-2];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeakSelf(self);
    if (indexPath.row==0) {
        EditInfoVC *editVC=[[EditInfoVC alloc]init];
        editVC.info=self.dataSource[indexPath.row];
        editVC.didSelectBlock = ^(NSString *select) {
            NSDictionary *dic = weakself.dataSource[indexPath.row];
            NSDictionary *dic2 = @{@"title":dic[@"title"],@"content":select,@"desc":@"未填写",@"type":dic[@"type"],@"placeholder":dic[@"placeholder"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:dic2];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:editVC animated:YES];
    }
    else if (indexPath.row==1)
    {
        NSDictionary *dic = weakself.dataSource[indexPath.row];
        SelectLanguageV *selectV = [[SelectLanguageV alloc]init];
        selectV.languageSelectAction = ^(NSString *content) {
            NSDictionary *dic2 = @{@"title":dic[@"title"],@"content":content,@"desc":@"未填写",@"type":dic[@"type"],@"placeholder":dic[@"placeholder"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:dic2];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        
        NSArray* array;
        if ([dic[@"content"] length]) {
            array=[dic[@"content"] componentsSeparatedByString:@"、"];
        }
        
        [selectV showWithArray:array withType:0];
    }
    else
    {
        PublicPickerView *pickerV = [[PublicPickerView alloc] init];
        pickerV.title=self.dataSource[indexPath.row][@"title"];
        pickerV.didSelectBlock = ^(NSString *select) {
            NSDictionary *dic = weakself.dataSource[indexPath.row];
            
            NSDictionary *dic2 = @{@"title":dic[@"title"],@"content":select,@"isRequired":dic[@"isRequired"]};
            [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:dic2];
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [pickerV showWithPickerType:indexPath.row-2 withDesc:self.dataSource[indexPath.row][@"content"]];
    }
}

@end

