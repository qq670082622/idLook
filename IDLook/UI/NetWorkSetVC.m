/*
 @header  NetWorkSetVC.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/29
 @description
 
 */

#import "NetWorkSetVC.h"
#import "MsgSettingCell.h"
#import "NetworkSetCell.h"

@interface NetWorkSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;

@end

@implementation NetWorkSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"播放设置"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self tableV];
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
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
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<=1) {
        static NSString *identifer = @"NetworkSetCell";
        NetworkSetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[NetworkSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithRow:indexPath.row];
        return cell;
    }
    else
    {
        static NSString *identifer = @"MsgSettingCell";
        MsgSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[MsgSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
       
        }
        
        MsgSettingCellAType type;
        if (indexPath.row==2) {
            type=MsgSettingCellATypeWifiAutoPlay;
        }
        else
        {
            type=MsgSettingCellATypeListIsMute;
        }
        
        [cell reloadUIWithType:type];
        cell.MsgSettingCellABlock = ^(BOOL on) {
            if (indexPath.row==2) {
                [UserInfoManager setWifiAuthPlay:on];
            }
            else if (indexPath.row==3)
            {
                [UserInfoManager setListPlayIsMute:on];
            }
        };
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        [UserInfoManager setWWanAuthPlay:YES];
        [self.tableV reloadData];
    }
    else if (indexPath.row==1)
    {
        [UserInfoManager setWWanAuthPlay:NO];
        [self.tableV reloadData];
    }
}


@end