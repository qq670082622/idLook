//
//  PublishGradeViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/21.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "PublishGradeViewController.h"
#import "GradeModel.h"
#import "GradeCell.h"
#import "OrderModel.h"
#import "GradeEnsureCell.h"
#import "CheckGradeModel.h"
@interface PublishGradeViewController ()<UITableViewDelegate,UITableViewDataSource,GradeCellDelegate,GradeEnsureCellDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSArray *tipsArray;
@end

@implementation PublishGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    if(_checkModel.id>0) {
          [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改评价"]];
    }else{
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"发表评价"]];
    }
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    self.tableView.tableFooterView = [UIView new];
    [self dataSource];
    [self.tableView reloadData];
}
//匿名
-(void)cellAnonymity:(BOOL)anonymity withIndexPath:(NSIndexPath *)indexPath
{
    GradeModel *model = self.dataSource[indexPath.section];
    model.anonymity = anonymity;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
//评总分（差好坏）
-(void)cellGrade:(NSInteger)grade withIndexPath:(NSIndexPath *)indexPath
{
     GradeModel *model = self.dataSource[indexPath.section];
    if (model.gradeLevel != grade) {
        model.gradeLevel = grade;
        [model.gradeStrings removeAllObjects];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
//选或者取消标签
-(void)cellClickTip:(NSString *)tip withSelect:(BOOL)select withIndexPath:(NSIndexPath *)indexPath
{
    GradeModel *model = self.dataSource[indexPath.section];
    if (select) {
        [model.gradeStrings addObject:tip];
    }else{
     [model.gradeStrings removeObject:tip];
    }
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
//评单项星星
//price_starType,  //性价比
//act_starType,  //表演力
//match_starType,       //配合度
//feeling_starType,   //好感度
-(void)cellSroce:(NSInteger)scorce withType:(NSInteger)starType withIndexPath:(NSIndexPath *)indexPath
{
     GradeModel *model = self.dataSource[indexPath.section];
    if (starType == 0) {//性价比
        model.pricePower = scorce;
    }else if (starType == 1){//表演力
        model.actPower = scorce;
    }else if (starType == 2){//配合度
        model.matchPower = scorce;
    }else{//好感度
        model.feeling = scorce;
    }
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
//确认评价
-(void)ensureGrade
{
    for(GradeModel *gm in _dataSource){
        if (gm.gradeLevel==0) {
            [SVProgressHUD showImage:nil status:@"请评价完整"];
            return;
        }
        if (gm.pricePower==0) {
            [SVProgressHUD showImage:nil status:@"请评价完整"];
            return;
        }
        if (gm.actPower==0) {
            [SVProgressHUD showImage:nil status:@"请评价完整"];
            return;
        }
        if (gm.matchPower==0) {
            [SVProgressHUD showImage:nil status:@"请评价完整"];
            return;
        }
        if (gm.feeling==0) {
            [SVProgressHUD showImage:nil status:@"请评价完整"];
            return;
        }
    }
    NSDictionary *evaluateTags11 = [NSDictionary dictionaryWithObjectsAndKeys:@"11",@"attrid",@"表演有亮点",@"attrname", nil];
    NSDictionary *evaluateTags12 = [NSDictionary dictionaryWithObjectsAndKeys:@"12",@"attrid",@"理解脚本能力强",@"attrname", nil];
    NSDictionary *evaluateTags13 = [NSDictionary dictionaryWithObjectsAndKeys:@"13",@"attrid",@"现场配合度高",@"attrname", nil];
    NSDictionary *evaluateTags14 = [NSDictionary dictionaryWithObjectsAndKeys:@"14",@"attrid",@"提前到场准备",@"attrname", nil];
    NSDictionary *evaluateTags15 = [NSDictionary dictionaryWithObjectsAndKeys:@"15",@"attrid",@"有专业互动",@"attrname", nil];
    NSDictionary *evaluateTags16 = [NSDictionary dictionaryWithObjectsAndKeys:@"16",@"attrid",@"有礼貌",@"attrname", nil];
 
    NSDictionary *evaluateTags21 = [NSDictionary dictionaryWithObjectsAndKeys:@"21",@"attrid",@"理解脚本能力一般",@"attrname", nil];
    NSDictionary *evaluateTags22 = [NSDictionary dictionaryWithObjectsAndKeys:@"22",@"attrid",@"演技一般",@"attrname", nil];
    NSDictionary *evaluateTags23 = [NSDictionary dictionaryWithObjectsAndKeys:@"23",@"attrid",@"准时到场",@"attrname", nil];
    NSDictionary *evaluateTags24 = [NSDictionary dictionaryWithObjectsAndKeys:@"24",@"attrid",@"表演配合良好",@"attrname", nil];
    NSDictionary *evaluateTags25 = [NSDictionary dictionaryWithObjectsAndKeys:@"25",@"attrid",@"偶有情绪般",@"attrname", nil];
   
    NSDictionary *evaluateTags31 = [NSDictionary dictionaryWithObjectsAndKeys:@"31",@"attrid",@"理解能力有待提高",@"attrname", nil];
    NSDictionary *evaluateTags32 = [NSDictionary dictionaryWithObjectsAndKeys:@"32",@"attrid",@"演技有待提高",@"attrname", nil];
    NSDictionary *evaluateTags33 = [NSDictionary dictionaryWithObjectsAndKeys:@"33",@"attrid",@"迟到半小时以上",@"attrname", nil];
    NSDictionary *evaluateTags34 = [NSDictionary dictionaryWithObjectsAndKeys:@"34",@"attrid",@"表演不配合",@"attrname", nil];
    NSDictionary *evaluateTags35 = [NSDictionary dictionaryWithObjectsAndKeys:@"35",@"attrid",@"容易情绪化",@"attrname", nil];
  
  self.tipsArray = [NSArray arrayWithObjects:evaluateTags11,evaluateTags12, evaluateTags13,evaluateTags14,evaluateTags15, evaluateTags16,evaluateTags21,evaluateTags22,evaluateTags23,evaluateTags24,evaluateTags25,evaluateTags31,evaluateTags32,evaluateTags33,evaluateTags34,evaluateTags35,nil];
    NSMutableArray *jsonGrdeArray = [NSMutableArray new];
     GradeModel *model = [_dataSource firstObject];
    for (NSString *gradeStr in model.gradeStrings) {
        for(NSDictionary *gradeDi in _tipsArray){
            NSString *attrname = gradeDi[@"attrname"];
            NSString *attrid = gradeDi[@"attrid"];
            if ([attrname isEqualToString:gradeStr]) {
                [jsonGrdeArray addObject:attrid];
            }
        }
    }
  
    if (_checkModel.id>0) {//说明是修改评价
             NSDictionary *dic = @{
                                    @"actingPower":@(model.actPower),
                                    @"comment": model.gradeText,
                                    @"coordination":@(model.pricePower),
                                    @"favor":@(model.feeling),
                                    @"level": @(model.gradeLevel),
                                    @"performance":@(model.matchPower),
                                    @"tag": [jsonGrdeArray componentsJoinedByString:@","]
                                    };
              NSDictionary *dicArg = @{
                                       @"id":@(_checkModel.id),
                                       @"status":@(0),
                                       @"userId":@([[UserInfoManager getUserUID] integerValue]),
                                       @"anonymous": model.anonymity==YES?@(2):@(1),//1:不匿名; 2:匿名"
                                       @"evaluateInfo":dic
                                       };
              [AFWebAPI_JAVA modifyGradeWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
                  if (success) {
                      [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                      [self.navigationController popViewControllerAnimated:YES];
                  }else{
                      [SVProgressHUD showErrorWithStatus:object];
                  }
              }];
          }else{//新的评价
            //   GradeModel *model = [_dataSource firstObject];
              NSDictionary *evaluateInfo = @{
                                             @"actingPower":@(model.actPower),
                                             @"comment": model.gradeText,
                                             @"coordination":@(model.pricePower),
                                             @"favor":@(model.feeling),
                                             @"level": @(model.gradeLevel),
                                             @"performance":@(model.matchPower),
                                             @"tag": [jsonGrdeArray componentsJoinedByString:@","]
                                             };
              NSDictionary *gradeDic = @{
                                         @"actorId":@(model.actorId),
                                         @"anonymous":model.anonymity==YES?@(2):@(1),//1:不匿名; 2:匿名",
                                         @"userId":@([[UserInfoManager getUserUID] integerValue]),
                                         @"evaluateInfo":evaluateInfo
                                         };
              [AFWebAPI_JAVA gradeActorWithArg:gradeDic callBack:^(BOOL success, id  _Nonnull object) {
                  if (success) {
                      [SVProgressHUD showSuccessWithStatus:@"评价成功"];
                      [self.navigationController popViewControllerAnimated:YES];
                  }else{
                      [SVProgressHUD showErrorWithStatus:object];
                  }
              }];
          }

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count>0?_dataSource.count+1:_dataSource.count;//此处要加个确认按钮
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _dataSource.count) {//说明是最后一个 用确定按钮
      
        return 93;
    }
    GradeModel *model = self.dataSource[indexPath.section];
    if (model.gradeLevel==0) {
        return 345;//144;
    }
    return 600;//415;
}
//预估行高，否则刷新某行时table会抖动
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _dataSource.count) {//说明是最后一个 用确定按钮
        
        return 93;
    }
    GradeModel *model = self.dataSource[indexPath.section];
    if (model.gradeLevel==0) {
        return 345;
    }
    return 625;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _dataSource.count) {//说明是最后一个 用确定按钮
        GradeEnsureCell *btnCell = [GradeEnsureCell cellWithTableView:tableView];
        btnCell.delegate = self;
        return btnCell;
    }
  //  NSLog(@"section is %d",indexPath.section);
    GradeCell *cell = [GradeCell cellWithTableView:tableView];
    cell.textView.delegate = self;
    [cell.textView setTag:indexPath.section];
    GradeModel *model = self.dataSource[indexPath.section];
    model.indexPath = indexPath;
    cell.model = model;
    cell.delegate = self;
    return cell;
}
-(void)textViewDidChange:(UITextView *)textView//用户输入中 键盘还在
{
    NSInteger tag = textView.tag;
    GradeCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:tag]];
    
    if([textView.text length]>0)
    {
        cell.textTip.hidden=YES;
    }
    else
    {
        cell.textTip.hidden=NO;
    }
    GradeModel *model = self.dataSource[tag];
    model.gradeText = textView.text;
     cell.textCount.text = [NSString stringWithFormat:@"%ld/500",textView.text.length];
}
- (void)textViewDidEndEditing:(UITextView *)textView//用户输入完成 键盘取消
{
    NSInteger tag = textView.tag;
    GradeCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:tag]];
        if([textView.text length]>0)
        {
            cell.textTip.hidden=YES;
        }
        else
        {
            cell.textTip.hidden=NO;
        }
    GradeModel *model = self.dataSource[tag];
    model.gradeText = textView.text;
    cell.textCount.text = [NSString stringWithFormat:@"%ld/500",textView.text.length];
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>499) {
        if (text.length==0) {//在删除
            return YES;
        }else if (text.length>0 && ![text isEqualToString:@"\n"]) //还想加字，不允许
        {
            [SVProgressHUD showImage:nil status:@"不能超过500字"];
            return NO;
        }
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}
-(NSMutableArray *)dataSource
{
  
    NSDictionary *evaluateTags11 = [NSDictionary dictionaryWithObjectsAndKeys:@"11",@"attrid",@"表演有亮点",@"attrname", nil];
    NSDictionary *evaluateTags12 = [NSDictionary dictionaryWithObjectsAndKeys:@"12",@"attrid",@"理解脚本能力强",@"attrname", nil];
    NSDictionary *evaluateTags13 = [NSDictionary dictionaryWithObjectsAndKeys:@"13",@"attrid",@"现场配合度高",@"attrname", nil];
    NSDictionary *evaluateTags14 = [NSDictionary dictionaryWithObjectsAndKeys:@"14",@"attrid",@"提前到场准备",@"attrname", nil];
    NSDictionary *evaluateTags15 = [NSDictionary dictionaryWithObjectsAndKeys:@"15",@"attrid",@"有专业互动",@"attrname", nil];
     NSDictionary *evaluateTags16 = [NSDictionary dictionaryWithObjectsAndKeys:@"16",@"attrid",@"有礼貌",@"attrname", nil];
    NSArray *goodArr = [NSArray arrayWithObjects:evaluateTags11,evaluateTags12,evaluateTags13,evaluateTags14,evaluateTags15,evaluateTags16, nil];
//    NSDictionary *goodDic = [NSDictionary dictionaryWithObjectsAndKeys:goodArr,@"good", nil];
    
    NSDictionary *evaluateTags21 = [NSDictionary dictionaryWithObjectsAndKeys:@"21",@"attrid",@"理解脚本能力一般",@"attrname", nil];
    NSDictionary *evaluateTags22 = [NSDictionary dictionaryWithObjectsAndKeys:@"22",@"attrid",@"演技一般",@"attrname", nil];
    NSDictionary *evaluateTags23 = [NSDictionary dictionaryWithObjectsAndKeys:@"23",@"attrid",@"准时到场",@"attrname", nil];
      NSDictionary *evaluateTags24 = [NSDictionary dictionaryWithObjectsAndKeys:@"24",@"attrid",@"表演配合良好",@"attrname", nil];
      NSDictionary *evaluateTags25 = [NSDictionary dictionaryWithObjectsAndKeys:@"25",@"attrid",@"偶有情绪般",@"attrname", nil];
     NSArray *normalArr = [NSArray arrayWithObjects:evaluateTags21,evaluateTags22,evaluateTags23,evaluateTags24,evaluateTags25, nil];
//     NSDictionary *normalDic = [NSDictionary dictionaryWithObjectsAndKeys:normalArr,@"normal", nil];
    
    NSDictionary *evaluateTags31 = [NSDictionary dictionaryWithObjectsAndKeys:@"31",@"attrid",@"理解能力有待提高",@"attrname", nil];
    NSDictionary *evaluateTags32 = [NSDictionary dictionaryWithObjectsAndKeys:@"32",@"attrid",@"演技有待提高",@"attrname", nil];
    NSDictionary *evaluateTags33 = [NSDictionary dictionaryWithObjectsAndKeys:@"33",@"attrid",@"迟到半小时以上",@"attrname", nil];
    NSDictionary *evaluateTags34 = [NSDictionary dictionaryWithObjectsAndKeys:@"34",@"attrid",@"表演不配合",@"attrname", nil];
    NSDictionary *evaluateTags35 = [NSDictionary dictionaryWithObjectsAndKeys:@"35",@"attrid",@"容易情绪化",@"attrname", nil];
     NSArray *badArr = [NSArray arrayWithObjects:evaluateTags31,evaluateTags32,evaluateTags33,evaluateTags34,evaluateTags35, nil];
//     NSDictionary *badDic = [NSDictionary dictionaryWithObjectsAndKeys:badArr,@"bad", nil];
    
    self.tipsArray = [NSArray arrayWithObjects:evaluateTags11,evaluateTags12, evaluateTags13,evaluateTags14,evaluateTags15, evaluateTags16,evaluateTags21,evaluateTags22,evaluateTags23,evaluateTags24,evaluateTags25,evaluateTags31,evaluateTags32,evaluateTags33,evaluateTags34,evaluateTags35,nil];
    NSArray *allStrings = [NSArray arrayWithObjects:goodArr,normalArr,badArr, nil];

      //************测试而加的数据**********************
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
       //  OrderModel *ormo = [OrderModel new];
        if (_checkModel.id>0) {//说明是修改评价
            NSArray *userModels = [NSArray arrayWithObject:_checkModel];
            for(int i=0;i<userModels.count;i++){
                CheckGradeModel *userM = userModels[i];
                GradeModel *gm = [GradeModel new];
                NSDictionary *actorInfo = userM.actorInfo;
                gm.actorName = actorInfo[@"actorName"];
                gm.actorUrl = actorInfo[@"actorHead"];
                gm.sex =[actorInfo[@"sex"] integerValue];
                gm.city = actorInfo[@"region"];
                gm.anonymity = userM.anonymous==1?NO:YES;
                gm.gradeStrings = [NSMutableArray new];
                gm.gradeAllStrings = [NSArray arrayWithArray:allStrings];
                gm.gradeLevel = userM.level;
                gm.actorId = [actorInfo[@"actorId"] integerValue];
               //Array *gradeStrings;//标签//选中的标签
                gm.gradeStrings = [NSMutableArray arrayWithArray:userM.gradeStrings];
                gm.pricePower=userM.coordination;//性价比
                gm.actPower=userM.actingPower;//表演力
                gm.matchPower=userM.performance;//配合度
                gm.feeling=userM.favor;//好感度
                gm.gradeText = userM.comment;//评语
                //  gm.orderId = orderModel.orderId;
                [self.dataSource addObject:gm];
            }
        }else{//说明是直接点评
        NSArray *userModels = [NSArray arrayWithObject:_userModel];
        for(int i=0;i<userModels.count;i++){
            UserDetialInfoM *userM = userModels[i];
            GradeModel *gm = [GradeModel new];
            gm.actorName = userM.nickName;
            gm.actorUrl = userM.avatar;
            gm.sex = userM.sex;
            gm.city = userM.region;
            gm.anonymity = YES;
            gm.gradeStrings = [NSMutableArray new];
            gm.gradeAllStrings = [NSArray arrayWithArray:allStrings];
            gm.gradeText = @"";
            gm.actorId = userM.actorId;
          //  gm.orderId = orderModel.orderId;
            [self.dataSource addObject:gm];
        }
    }
    }
    return _dataSource;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     GradeCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textView resignFirstResponder];
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
 
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
   GradeModel *model = [_dataSource objectAtIndex:0];
    if (model.gradeLevel>0) {
        [UIView animateWithDuration:duration animations:^{
            self.tableView.frame = CGRectMake(0.0f, -300, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    

}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    GradeModel *model = [_dataSource objectAtIndex:0];
    if (model.gradeLevel>0) {
//    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    }
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    self.tableView.height-=34;
}
@end
