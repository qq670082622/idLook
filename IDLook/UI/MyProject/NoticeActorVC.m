//
//  NoticeActorVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "NoticeActorVC.h"
#import "NoticeActorModel.h"
#import "historyModel.h"
#import "NoticeActorCell.h"
@interface NoticeActorVC ()<UITableViewDelegate,UITableViewDataSource,NoticeActorCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *sectionHeader;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UIView *sectionFooter;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
- (IBAction)ensure:(id)sender;

@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation NoticeActorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.tableFooterView = [UIView new];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通知演员"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    // Do any additional setup after loading the view from its nib.
//    NSDictionary *actorDic = @{
//                            
//                               @"orderState":orderState, "ask_schedule:询问档期; try_video: 试镜; lock_schedule:锁定档期; makeup: 定妆; shot:拍摄; author: 授权书; cancel:取消; finished: 完成",
//                               @"subState":subState, ask_schedule_query:询问档期; ask_schedule_buyerNegoPrice:买方议价; ask_schedule_actorNegoPrice: 演员还价;  try_video_wait_actor_upload: 待演员上传作品; try_video_actor_uploaded: 演员已上传作品; try_video_wait_audition: 待开始试镜;  try_video_on_audition: 试镜中; pending_pay: 待支付; pending_pay_first: 待支付首款; pending_pay_last: 待支付尾款; pay_done: 已付尾款或全部支付;   wait_actor_accept: 待演员确认; actor_accept: 演员接受;  actor_reject: 演员拒绝; over_time: 已过期; cancel: 取消; finish: 完成;"
//                               @"shotStart":shotStart,
//                               @"shotEnd":shotEnd
//                               };
    self.ensureBtn.layer.cornerRadius = 6;
    self.ensureBtn.layer.masksToBounds = YES;
    //装演员
    _data = [NSMutableArray new];
    for (NSDictionary *actorDic in _effectActor) {
        NoticeActorModel *model = [NoticeActorModel yy_modelWithDictionary:actorDic];
        if ([self translateWithDateString:model.shotStart]<[self translateWithDateString:_projectStart] || [self translateWithDateString:model.shotEnd]>[self translateWithDateString:_projectEnd]) {
            model.dateBeyond = YES;
        }
        [_data addObject:model];
    }
    //装修改内容
    NSDictionary *dic = @{
                          @"projectId": _projectId,
                          @"userId": @([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA checkProjectEditHistoryWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        NSDictionary *body = [object objectForKey:@"body"];
        NSArray *projectChangeList = body[@"projectChangeList"];
        NSDictionary *lastestChange = [projectChangeList lastObject];
        NSArray *changeDetailList = lastestChange[@"changeDetailList"];
        NSMutableString *contentStr = [NSMutableString new];
        if (changeDetailList.count>1) {
            for ( int i = 0;i<changeDetailList.count;i++) {
                NSDictionary *changeDic = changeDetailList[i];
                NSString *content = changeDic[@"content"];
                if (i>0) {
                    [contentStr appendString:[NSString stringWithFormat:@"\n● %@",content]];
                }else if(i==0){
                    [contentStr appendString:[NSString stringWithFormat:@"● %@",content]];
                }
            }
        }else{
            NSDictionary *changeDic = changeDetailList[0];
            NSString *content = changeDic[@"content"];
            [contentStr appendString:[NSString stringWithFormat:@"● %@",content]];
        }
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:8];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [contentStr length])];
        [self.headerLabel setAttributedText:attributedString1];
        [self.headerLabel sizeToFit];
//        for(int i = 0;i<_headerLabel.numberOfLines;i++){
//            UIView *pointView = [UIView new];
//            pointView.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
//            pointView.layer.cornerRadius = 2.5;
//            pointView.layer.masksToBounds = YES;
//            pointView.frame = CGRectMake(15, 48+i*(_headerLabel.height/_headerLabel.numberOfLines), 5, 5);
//            [self.sectionHeader addSubview:pointView];
//        }
         [self.table reloadData];
    }];
   
}
#pragma -mark noticeActorCellDelegate
-(void)cellSelectStartDate:(NSString *)startDate withRow:(NSInteger)row
{
    NoticeActorModel *model = _data[row];
    if ([self translateWithDateString:startDate]<[self translateWithDateString:_projectStart] || [self translateWithDateString:model.shotEnd]>[self translateWithDateString:_projectEnd]) {
        model.dateBeyond = YES;
    }else{
         model.dateBeyond = NO;
    }
    model.shotStart = startDate;
     [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)cellSelectEndDate:(NSString *)endDate withRow:(NSInteger)row
{
    NoticeActorModel *model = _data[row];
    if ([self translateWithDateString:model.shotStart]<[self translateWithDateString:_projectStart] || [self translateWithDateString:endDate]>[self translateWithDateString:_projectEnd]) {
        model.dateBeyond = YES;
    }else{
        model.dateBeyond = NO;
    }
    model.shotEnd = endDate;
    [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeActorCell *cell = [NoticeActorCell cellWithTableView:tableView];
    cell.model = _data[indexPath.row];
    cell.delegate = self;
    cell.row = indexPath.row;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeActorModel *model = _data[indexPath.row];
    if (!model.dateBeyond) {
        return 132;
    }
    return 147;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _headerLabel.bottom+14;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _sectionFooter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _sectionFooter.height;
}
- (IBAction)ensure:(id)sender {
    for (NoticeActorModel *model in _data) {
        if (model.shotStart.length==0 || model.shotEnd.length==0 || model.dateBeyond) {
             NSDictionary *infoDic = model.actorInfo;
            NSString *name = infoDic[@"actorName"];
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请确认%@的拍摄日期",name]];
            return;
        }
    }
    
    NSMutableDictionary *arg = [NSMutableDictionary new];
    [arg addEntriesFromDictionary:_projectDic];
    NSMutableArray *ordersArr = [NSMutableArray new];
    for (NSDictionary *orderDic in _effectOrders) {
        NSString *orderId = orderDic[@"orderId"];
        for (NoticeActorModel *model in _data) {
            if ([model.orderId isEqualToString:orderId]) {
                NSDictionary *orderNew = @{
                                           @"shotStart":model.shotStart,
                                           @"shotEnd":model.shotEnd,
                                           @"orderId":orderId
                                           };
                [ordersArr addObject:orderNew];
            }
        }
    }
    [arg setObject:ordersArr forKey:@"orderAdjustList"];
     [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeClear];
    [AFWebAPI_JAVA editProjectWithArg:arg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            
            NSInteger index = [[self.navigationController viewControllers]indexOfObject:self];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
          
            
            
        } else
        {
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}
-(NSInteger)translateWithDateString:(NSString *)datrString//把日期转化成整型比大小
{
  NSString *translate = [datrString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [translate integerValue];
}
- (void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
