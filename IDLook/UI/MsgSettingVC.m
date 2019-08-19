//
//  MsgSettingVC.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MsgSettingVC.h"
#import "MsgSettingCell.h"

@interface MsgSettingVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)CustomTableV *tableV;

@end

@implementation MsgSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"消息设置"]];
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
        _tableV.separatorColor =Public_LineGray_Color;
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
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"MsgSettingCell";
    MsgSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[MsgSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        WeakSelf(self);
        cell.MsgSettingCellABlock = ^(BOOL on) {
            [weakself msgSettingWithOpen:on withIndexPath:indexPath];
        };
    }
    [cell reloadUIWithType:(indexPath.row+indexPath.section)];
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,UI_SCREEN_WIDTH,50}];
    
    UILabel *label = [[UILabel alloc] init];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = Public_DetailTextLabelColor;
    [view addSubview:label];
    if (section==0)
    {
        label.text=@"关闭后将不会接收到脸探肖像最新通知和订单消息";
    }
    else if (section==1)
    {
        label.text=@"当脸探肖像运行时，您可以设置是否需要声音或振动";
    }
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    
    return view;
}

-(void)msgSettingWithOpen:(BOOL)open withIndexPath:(NSIndexPath*)indexpath
{
    NSInteger sec = indexpath.section;
    NSInteger row =indexpath.row;
    if (sec==0) {
        if ([UserInfoManager getIsJavaService]) {
            NSString *openStr = open==YES?@"1":@"0";
            NSNumber *userId = @([[UserInfoManager getUserUID] integerValue]);
            NSDictionary *dic = @{@"userId":userId,
                                  @"notifySet":openStr};
            [AFWebAPI_JAVA setUserNewMsgWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    
                  //  [UserInfoManager setMsgNotify:open];
                    [DeviceSettingManager setMsgNotify:open];
                   
                }
                else
                {
                    AF_SHOW_JAVA_ERROR
                }
            }];
        }else{
        NSDictionary *dic = @{@"userid":[UserInfoManager getUserUID],
                              @"notify":@(open)};
        [AFWebAPI setUserNewMsgWithArg:dic callBack:^(BOOL success, id object) {
            if (success) {
                
              //  [UserInfoManager setMsgNotify:open];
                 [DeviceSettingManager setMsgNotify:open];
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    }
    else if (sec==1)
    {
        if (row==0) {
         //   [UserInfoManager setUserSoundOn:open];
            [DeviceSettingManager setUserSoundOn:open];
        }
        else if (row==1)
        {
          //  [UserInfoManager setUserVibirateOn:open];
            [DeviceSettingManager setUserVibirateOn:open];
        }
    }
}


@end
