//
//  UserCenterVC.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserCenterVC.h"
#import "CenterTitleView.h"
#import "EditMainM.h"
#import "EditMainCellA.h"
#import "EditMainCellB.h"
#import "EditMainCellC.h"
#import "EditMainCellD.h"
#import "EditCooperatVC.h"
#import "EditMirrorVC.h"
#import "EditBasicVC.h"
#import "EditAddressVC.h"
#import "EditSpecialtyVC.h"
#import "EditBriefVC.h"
#import "CenterCustomCell.h"
#import "CenterTextViewCell.h"
#import "EditBasicCell.h"
#import "CenterHeadView.h"
#import "PublicPickerView.h"
#import "RegionChooseVC.h"
#import "SelectLanguageV.h"

@interface UserCenterVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TableVTouchDelegate>
@property (nonatomic,strong)TouchTableV *tableV;
@property (nonatomic,strong)EditMainM *dataM;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation UserCenterVC

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;

    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"个人中心"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"保存" Target:self action:@selector(save)]]];

    [self.dataM refreshEditInfo];
    [self tableV];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    for (int i=1; i<self.dataM.dataS.count; i++) {
        NSArray *dataS = self.dataM.dataS[i];
        for (int j=0; j<dataS.count; j++) {
            EditStructM *model = [dataS[j] objectForKey:kEditInfoVCMCellData];
        
            if (model.IsMustInput)
            {
                if (model.type>=UserInfoTypeHeight && model.type<=UserInfoTypeShoeSize) {
                    if ([model.content integerValue]==0) {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请将必填内容填写完整"]];
                        return;
                    }
                }
                else
                {
                    if ([model.content length]==0) {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请将必填内容填写完整"]];
                        return;
                    }

                }
   
            }
        }
    }
    
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithCapacity:0];

    [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userid"];

    
    NSArray *array1 =@[@"nick",@"language",@"dialect",@"height",@"weight",@"bust",@"waistline",@"hipline",@"shoesize"];
    
    for (int i = 0 ; i<array1.count; i++) {
        EditStructM *model=(EditStructM *)[self.dataM.dataS[1][i] objectForKey:kEditInfoVCMCellData];
        
        if (i==1) {
            NSString *str=[model.content stringByReplacingOccurrencesOfString:@"、" withString:@"|"];
            [dicArg setObject:str forKey:array1[i]];
        }
        else
        {
            [dicArg setObject:model.content forKey:array1[i]];
        }
    }
    
    NSArray *array2= @[@"academy",@"grade",@"specialty"];
    
    for (int i = 0 ; i<array2.count; i++) {
        EditStructM *model=(EditStructM *)[self.dataM.dataS[2][i] objectForKey:kEditInfoVCMCellData];
        [dicArg setObject:model.content forKey:array2[i]];
    }
    
    NSArray *array3= @[@"region",@"address",@"postalcode",@"email",@"contactnumber1",@"contactnumber2"];
    for (int i = 0 ; i<array3.count; i++) {
        EditStructM *model=(EditStructM *)[self.dataM.dataS[3][i] objectForKey:kEditInfoVCMCellData];
        [dicArg setObject:model.content forKey:array3[i]];
    }
    
//    EditStructM *model3=(EditStructM *)[self.dataM.dataS[4][1] objectForKey:kEditInfoVCMCellData];
//    [dicArg setObject:[model3.content stringByReplacingOccurrencesOfString:@"、" withString:@"|"] forKey:@"performtype"];
    
    EditStructM *model4=(EditStructM *)[self.dataM.dataS[5][0] objectForKey:kEditInfoVCMCellData];
    [dicArg setObject:model4.content forKey:@"brief"];
    
    EditStructM *model5=(EditStructM *)[self.dataM.dataS[6][0] objectForKey:kEditInfoVCMCellData];
    [dicArg setObject:model5.content forKey:@"representativework"];
    
    [SVProgressHUD showWithStatus:@"保存中，请稍等" maskType:SVProgressHUDMaskTypeClear];

    [AFWebAPI modifMyotherInfoWithAry:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            NSDictionary *dic = [object objectForKey:JSON_data];
            
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            [UserInfoManager setUserLoginfo:uinfo];
            
            [self onGoback];
            if (self.saveRefreshUI) {
                self.saveRefreshUI();
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

-(EditMainM*)dataM
{
    if (!_dataM) {
        _dataM = [[EditMainM alloc]init];
        WeakSelf(self);
        _dataM.reloadTableData = ^{
            [weakself.tableV reloadData];
        };
    }
    return _dataM;
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.bounces=YES;
        _tableV.touchDelegate=self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor = Public_LineGray_Color;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        _tableV.tableHeaderView = [self tableHeadV];
    }
    return _tableV;
}

-(UIView*)tableHeadV
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 42)];
    bg.backgroundColor=[UIColor clearColor];
    UILabel *headState= [[UILabel alloc]init];
    headState.font=[UIFont systemFontOfSize:14];
    headState.textColor=[UIColor colorWithHexString:@"#909090"];
    headState.text=@"完善个人资料，可提高在首页的排名哦。";
    headState.textAlignment=NSTextAlignmentCenter;
    [bg addSubview:headState];
    [headState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(14);
        make.centerY.mas_equalTo(bg);
    }];
    return bg;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 48.0;
    }
    return 58.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataM.dataS count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataM.dataS[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[(NSDictionary *)self.dataM.dataS[indexPath.section][indexPath.row] objectForKey:kEditInfoVCMCellHeight] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dataM.dataS[sec][row] objectForKey:kEditInfoVCMCellClass];
    
    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    
    if ([classStr isEqualToString:@"CenterCustomCell"]) {
        CenterCustomCell *cell = (CenterCustomCell *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        EditStructM *model = (EditStructM *)[self.dataM.dataS[sec][row] objectForKey:kEditInfoVCMCellData];
        [cell reloadUIWithModel:model];
        
        WeakSelf(self);
        cell.BeginEdit = ^{
            weakself.indexPath=indexPath;
        };
        cell.textFieldChangeBlock = ^(NSString *text) {
            [weakself.dataM reloadDataWithIndexPath:indexPath withContent:text];
        };
    }
    else if ([classStr isEqualToString:@"CenterTextViewCell"])
    {
        CenterTextViewCell *cell = (CenterTextViewCell *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        EditStructM *model = (EditStructM *)[self.dataM.dataS[sec][row] objectForKey:kEditInfoVCMCellData];
        
        [cell reloadUIWithModel:model];
        
        WeakSelf(self);
        cell.BeginEdit = ^{
            weakself.indexPath=indexPath;
        };
        cell.textViewChangeBlock = ^(NSString *text) {
            [weakself.dataM reloadDataWithIndexPath:indexPath withContent:text];
        };
    }
    else if ([classStr isEqualToString:@"EditBasicCell"])
    {
        EditBasicCell *cell = (EditBasicCell *)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dic = [(NSDictionary *)self.dataM.dataS[sec][row] objectForKey:kEditInfoVCMCellData];
        [cell reloadUIWithDic:dic withType:row-3];
    }
    
    return obj;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"CenterHeadView";
    CenterHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!headerView)
    {
        headerView = [[CenterHeadView alloc] initWithReuseIdentifier:identifer];
    }
    [headerView reloadUIWithTitle:self.dataM.titleArray[section]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *classStr = [(NSDictionary *)self.dataM.dataS[sec][row] objectForKey:kEditInfoVCMCellClass];
    EditStructM *model = (EditStructM *)[self.dataM.dataS[sec][row] objectForKey:kEditInfoVCMCellData];
    WeakSelf(self);
    if (model.isShowArrow==YES) {
        if (sec==1) {
            if (row==1)
            {
                SelectLanguageV *selectV = [[SelectLanguageV alloc]init];
                selectV.languageSelectAction = ^(NSString *content) {
                    [weakself.dataM reloadDataWithIndexPath:indexPath withContent:content];
                    [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                
                NSArray* array;
                if ([model.content length]) {
                    array=[model.content componentsSeparatedByString:@"、"];
                }
                [selectV showWithArray:array withType:0];
            }
            else
            {
                PublicPickerView *pickerV = [[PublicPickerView alloc] init];
                pickerV.title=model.title;
                pickerV.didSelectBlock = ^(NSString *select) {
                    if ([select isEqualToString:@"暂不填写"]) {
                        select=@"";
                    }
                    [weakself.dataM reloadDataWithIndexPath:indexPath withContent:select];
                    [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                
                NSString *content = @"0";
                if (row==3) {
                    content=@"165";
                }
                else if (row==4)
                {
                    content=@"60";
                }
                else if (row==5)
                {
                    content=@"70";
                }
                else if (row==6)
                {
                    content=@"80";
                }
                else if (row==7)
                {
                    content=@"90";
                }
                else if (row==8)
                {
                    content=@"40";
                }
                
                [pickerV showWithPickerType:indexPath.row-3 withDesc:([model.content integerValue]==0?content:model.content)];
            }
        }
        else if (sec==2)
        {
            PublicPickerView *pickerV = [[PublicPickerView alloc] init];
            pickerV.title=model.title;
            pickerV.didSelectBlock = ^(NSString *select) {
                if ([select isEqualToString:@"暂不填写"]) {
                    select=@"";
                }
                
                [weakself.dataM reloadDataWithIndexPath:indexPath withContent:select];
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
            [pickerV showWithPickerType:indexPath.row+7 withDesc:model.content];
        }
        else if (sec==3)
        {
            RegionChooseVC *regionVC=[[RegionChooseVC alloc]init];
            [self.navigationController pushViewController:regionVC animated:YES];
            regionVC.selectCity = ^(NSString *city)
            {
                [weakself.dataM reloadDataWithIndexPath:indexPath withContent:city];
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
        }
        else if (sec==4)
        {
            SelectLanguageV *selectV = [[SelectLanguageV alloc]init];
            selectV.languageSelectAction = ^(NSString *content) {
                [weakself.dataM reloadDataWithIndexPath:indexPath withContent:content];
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
            NSArray* array;
            if ([model.content length]) {
                array=[model.content componentsSeparatedByString:@"、"];
            }
            [selectV showWithArray:array withType:1];
        }
    }

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

#pragma mark--keyboard Noti
- (void)keyboardFrameWillChange:(NSNotification*)notification
{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //当前Cell在屏幕中的坐标值
    CGRect rectInTableView = [self.tableV rectForRowAtIndexPath:self.indexPath];
    CGRect cellRect = [self.tableV convertRect:rectInTableView toView:[self.tableV superview]];
    
    NSLog(@"--%@--%@",NSStringFromCGRect(rectInTableView),NSStringFromCGRect(cellRect));
    
    if (rect.origin.y-120-cellRect.origin.y<0) {
        [self.tableV setContentOffset:CGPointMake(0,-rect.origin.y+cellRect.origin.y+cellRect.size.height+120+self.tableV.contentOffset.y) animated:YES];
    }
    else
    {
//        [self.tableV setContentOffset:CGPointMake(rectInTableView.origin.x, rectInTableView.origin.y) animated:YES];
    }
}

@end
