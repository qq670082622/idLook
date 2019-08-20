//
//  ProjectDetailVC2.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectDetailVC2.h"
#import "TZImagePickerController.h"
#import "ProjectModel.h"
#import "ProjectNumberCell.h"
#import "ProjectDescCell.h"
#import "ProjectOptionsCell.h"
#import "ProjectOptionsCell2.h"
#import "DatePickPopV.h"
#import "CitySelectStep1.h"
#import "UseSelectPopView.h"
#import "ProjectEnsureCell.h"
#import "ProjectScreenCell.h"
#import "mediaModel.h"
#import "LookBigImageVC.h"
#import "VideoPlayer.h"
#import "ProjectCastingCell.h"
#import "CastingModel.h"
#import "ProjectCastingAddVC.h"
#import "EditHistoryVC.h"
#import "NoticeActorVC.h"
#import "CitySelectView.h"
#import "HotelCalendarViewController.h"
#import "NSCalendar+Ex.h"
@interface ProjectDetailVC2 ()<UITableViewDelegate,UITableViewDataSource,ProjectDescCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,TableVTouchDelegate,ProjectOptionsCellDelegate,ProjectOptionsCell2Delegate,ProjectEnsureCellDelegate,ProjectCastingCellDelegate,HotelCalendarViewDelegate,HotelCalendarViewDataSource>
{
    VideoPlayer *_player;
}
@property(nonatomic,copy)NSString *navTitle;
@property (weak, nonatomic) IBOutlet UIView *checkView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UILabel *projectNum;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *photoArray;    //脚本，图片数组
@property(nonatomic,strong)NSMutableArray *selectedAssets; //脚本，图片数组
@property(nonatomic,strong)ProjectModel *projectModel;

//编辑提示相关
@property(nonatomic,strong)NSArray *effectOrders;
@property(nonatomic,strong)NSArray *effectActors;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)timeAction:(id)sender;
- (IBAction)closeAction:(id)sender;
@property(nonatomic,strong) NSTimer *btnTimer;
@property(nonatomic,assign) NSInteger time;
@end

@implementation ProjectDetailVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    self.timeBtn.layer.cornerRadius = 5;
    self.timeBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    self.photoArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.selectedAssets=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (_type==1) {
        self.model = [ProjectModel2 new];
        self.navTitle = [NSString stringWithFormat:@"新建项目"];
    }else if (_type==2){
        self.navTitle =[NSString stringWithFormat:@"编辑项目"];
        UIButton *his = [UIButton buttonWithType:0];
        [his setTitle:@"修改历史" forState:0];
        [his setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        his.titleLabel.font = [UIFont systemFontOfSize:15];
        [his addTarget:self action:@selector(checkEditHistory) forControlEvents:UIControlEventTouchUpInside];
         [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:his]];
        WeakSelf(self);
        [self checkEffectOrdersbackArry:^(NSArray *arr) {
                        NSMutableArray *effectOders = [NSMutableArray new];
            NSMutableArray *effectActors = [NSMutableArray new];
                        for (NSDictionary *orderDic in arr) {
                            NSString *shotStart = orderDic[@"shotStart"];
                            NSString *shotEnd = orderDic[@"shotEnd"];
                            NSString *orderId = orderDic[@"orderId"];
                            NSDictionary *orderDic2 = @{
                                                        @"shotStart":shotStart,
                                                        @"shotEnd":shotEnd,
                                                        @"orderId":orderId
                                                        };
                            [effectOders addObject:orderDic2];
                            
                            NSDictionary *actorInfo = orderDic[@"actorInfo"];
                            NSString *orderState = orderDic[@"orderState"];
                            NSString *subState = orderDic[@"subState"];
                            NSDictionary *roleInfo =orderDic[@"roleInfo"];
                            NSString *roleName = roleInfo[@"roleName"];
                           NSDictionary *actorDic = @{
                                                   @"actorInfo":actorInfo,
                                                   @"orderState":orderState,
                                                   @"subState":subState,
                                                   @"shotStart":shotStart,
                                                   @"shotEnd":shotEnd,
                                                   @"roleName":roleName,
                                                   @"orderId":orderId
                                                   };
                            [effectActors addObject:actorDic];
                        }
            weakself.effectOrders = [effectOders copy];
            weakself.effectActors = [effectActors copy];
        }];
    }else{
        self.navTitle =[NSString stringWithFormat:@"查看项目"];
    }
    if(_type!=1){//查看和编辑需要带图片
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //cutUrl": "string","duration": 0,"id": 0,"type": "1:图片; 2:视频","url": "string"
        NSMutableArray *vdo = [NSMutableArray new];
        NSMutableArray *img = [NSMutableArray new];
        for (NSDictionary *viDic in _model.projectScriptList) {
            NSInteger type = [viDic[@"type"] integerValue];
            if (type==1) {
                [img addObject:viDic];
            }else{
                [vdo addObject:viDic];
            }
        }
            __block   NSInteger screenCount = _model.projectScriptList.count;
            for(int i=0;i<vdo.count;i++){
                NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                    NSString *videoUrl = vdo[i][@"cutUrl"];
                    NSString *videoPlayerUrl = vdo[i][@"url"];
                    NSString *videoId = [NSString stringWithFormat:@"%@",vdo[i][@"id"]];
                    NSString *duration =[NSString stringWithFormat:@"%@",vdo[i][@"duration"]];
                    UIImage *videoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:vdo[i][@"cutUrl"]]]];
                    
                    if(!videoImg){
                        videoImg = [UIImage imageNamed:@"default_home"];
                    }
                    NSDictionary *videoModelDic = @{@"type":[NSNumber numberWithInt:mediaTypeVideoOld],@"image":videoImg,@"url":videoUrl,@"id":videoId,@"duration":duration,@"videourl":videoPlayerUrl};
                    dispatch_async(dispatch_get_main_queue(), ^{
                        screenCount--;
                        if (videoUrl.length>5) {
                            [self.selectedAssets addObject:videoImg];
                            [self.photoArray addObject:[mediaModel yy_modelWithDictionary:videoModelDic]];
                            
                            if (screenCount==0) {
                                [self sortPhotoArray];
                                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                            }
                        }
                    } );
                }];
                [queue addOperation:op];
            }
        for(int i=0;i<img.count;i++){
                NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                    NSString *url = img[i][@"url"];
                    NSString *imageId = [NSString stringWithFormat:@"%@",img[i][@"id"]];
                    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                    if(!img){
                        img = [UIImage imageNamed:@"default_home"];
                    }
                    NSDictionary *imageModelDic = @{@"type":[NSNumber numberWithInt:mediaTypePhotoOld],@"image":img,@"url":url,@"id":imageId};
                    dispatch_async(dispatch_get_main_queue(), ^{
                        screenCount--;
                        if (url.length>5) {
                            [self.selectedAssets addObject:img];
                            [self.photoArray addObject:[mediaModel yy_modelWithDictionary:imageModelDic]];
                            
                            if (screenCount==0) {
                                [self sortPhotoArray];
                                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                            }
                        }
                    } );
                    
                }];
                [queue addOperation:op];
            }
            }
    
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:_navTitle]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    if (_type == 3) {//查看
        self.editView.hidden = YES;
    }else if(_type == 1){//新建则没有编号
        self.tableView.y=0;
        self.checkView.hidden = YES;
        self.tableView.height+=42;
    }else{//编辑
        self.projectNum.text = _model.projectId;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    
    if (indexPath.row==0){
        ProjectDescCell *descCell = [ProjectDescCell cellWithTableView:tableView];
        
        descCell.textViewChangeBlock = ^(NSString * _Nonnull text) {
            weakself.model.projectDesc = text;
        };
        descCell.textFieldChangeBlock = ^(NSString * _Nonnull text) {
            weakself.model.projectName = text;
        };
        descCell.model = _model;
        if (_type==3) {
            descCell.checkStyle = YES;
        }

        [descCell reloadUIWithArray:_photoArray withAssets:self.selectedAssets];
        
        descCell.delegate = self;
        
        return descCell;
    }else if(indexPath.row==1){
     
            ProjectOptionsCell *optionsCell = [ProjectOptionsCell cellWithTableView:tableView];
            optionsCell.delegate = self;
            optionsCell.model = _model;
            if (_type==3) {
                optionsCell.checkStyle = YES;
            }
            optionsCell.actionType = ^(NSInteger actionType) {
                if(actionType == actionTypeStartDay){
                    NSDate *minimumDate = [NSDate date];
                    NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*365*2)];
                    // NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:(24*3600*_model.auditiondays*2)];
                    DatePickPopV *popV = [[DatePickPopV alloc]init];
                    [popV showWithMinDate:minimumDate maxDate:maximumDate];
                    popV.dateString = ^(NSString * _Nonnull str) {
                        if ([weakself.model.projectStart isEqualToString:str]) {//选了一样的天数 不操作

                        }else{//选择了不一样的天数
                            weakself.model.projectStart = str;
                            weakself.model.projectEnd = @"";
                        }

                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                    };
                }else if(actionType == actionTypeEndDay){
                    NSDate *minimumDate = [self dateWithString:_model.projectStart];
                    NSDate *maximumDate = [self start:_model.projectStart WithAudition:_model.shotDays];
                    DatePickPopV *popV = [[DatePickPopV alloc]init];
                    [popV showWithMinDate:minimumDate maxDate:maximumDate];
                    popV.dateString = ^(NSString * _Nonnull str) {
                        weakself.model.projectEnd = str;
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                    };
                }
            };
            return optionsCell;
//        ProjectOptionsCell2 *optionsCell = [ProjectOptionsCell2 cellWithTableView:tableView];
//        optionsCell.delegate = self;
//        optionsCell.model = _model;
//        if (_type==3) {
//            optionsCell.checkStyle = YES;
//        }
//
//        return optionsCell;
}else if(indexPath.row == 2){//角色
        ProjectCastingCell *catCell = [ProjectCastingCell cellWithTableView:tableView];
    if (_type==3) {
        catCell.checkStyle = YES;
    }
        id thing = [self.model.roleList firstObject];
        if ([thing isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *list = [NSMutableArray new];
            for (int i =0;i<self.model.roleList.count;i++) {
                NSDictionary *info = self.model.roleList[i];
                CastingModel *cm = [CastingModel yy_modelWithDictionary:info];
             //   cm.roleId = i;
                [list addObject:cm];
            }
            self.model.roleList = [list copy];
        }
     
        catCell.data = self.model.roleList;
        catCell.delegate = self;
        return catCell;
    }else{
        if (_type == 3) {//查看类无按钮cell
            UITableViewCell *noneCell = [UITableViewCell new];
            return noneCell;
        }
        ProjectEnsureCell *ensureCell = [ProjectEnsureCell cellWithTableView:tableView];
        if (_type==2) {//编辑是保存
            ensureCell.btnTitle = @"保存";
        }
        if (_type==1) {//新建是“保存并使用”
            ensureCell.btnTitle = @"保存";
        }
        ensureCell.delegate = self;
        return ensureCell;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
//预估行高，否则刷新某行时table会抖动
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0){
        
        NSInteger mediaCount = _model.projectScriptList.count;

        //若mediacount没有值说明是新建
        if (mediaCount==0) {
             mediaCount = _photoArray.count;
        }
       
        NSInteger heightRadius = 1;
        //275固定 3个以内 height = (screenWid - 40)/3  + 20
        if (mediaCount>2 && mediaCount<6){
            heightRadius = 2;
        }else if (mediaCount>5){
            heightRadius = 3;
        }
        CGFloat cellHeight = 270+(10*heightRadius)+(UI_SCREEN_WIDTH-40)*heightRadius/3;
        if (_type==3) {
            if (mediaCount==3 ||mediaCount==6) {
                cellHeight = 270+mediaCount*(UI_SCREEN_WIDTH-40)/9;
            }
            
        }
        return cellHeight;
    }else if(indexPath.row == 1){//
    
            return 248;//拍摄

        
    }else if(indexPath.row==2){ 
        return [ProjectCastingCell castingCellHeightWithCastingsCount:_model.roleList.count];
    }else{//查看时，没有此cell（按钮cell）
        if (_type==3) {
            return 0.5;
        }
        return 113;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0){
        NSInteger heightRadius = 1;
        //275固定 3个以内 height = (screenWid - 40)/3  + 20
        if (self.photoArray.count>2 && self.photoArray.count<6){
            heightRadius = 2;
        }else if (self.photoArray.count>5){
            heightRadius = 3;
        }
        CGFloat cellHeight = 314+(10*heightRadius)+(UI_SCREEN_WIDTH-40)*heightRadius/3;
        if (_type==3) {
            if (_photoArray.count==3 ||_photoArray.count==6) {
                cellHeight = 314+_photoArray.count*(UI_SCREEN_WIDTH-40)/9;
            }
            
        }
        return cellHeight;
    }else if(indexPath.row == 1){//
      
            return 248;//拍摄
//        if (_type==3) { 新版在此
//            return 251;
//        }else{
//            return 297;
//        }
        
    }else if (indexPath.row==2){//角色
         return [ProjectCastingCell castingCellHeightWithCastingsCount:_model.roleList.count];
    }else{//查看时，没有此cell（按钮cell）
        if (_type==3) {
            return 0.5;
        }
        return 113;
    }
    return 0;
}
#pragma -mark castingCellDelegate 角色的cell的代理
//点击角色进行编辑的代理
-(void)castingActionWithInfo:(CastingModel *)model
{
      WeakSelf(self);
    ProjectCastingAddVC *add = [ProjectCastingAddVC new];
    add.type = 2;
    add.model = model;
    add.projectId = _model.projectId;
    add.VCAdd = ^(CastingModel * _Nonnull infoModel, NSInteger type) {
        NSMutableArray *arr = [NSMutableArray new];
        [arr addObjectsFromArray:weakself.model.roleList];
        for (CastingModel *md in arr) {
            if (md.roleId == infoModel.roleId) {
                md.roleName = infoModel.roleName;
                md.sex = infoModel.sex;
                md.heightMin = infoModel.heightMin;
                md.heightMax = infoModel.heightMax;
                md.remark = infoModel.remark;
                md.ageMin = infoModel.ageMin;
                md.ageMax = infoModel.ageMax;
                md.typeName = infoModel.typeName;
            }
        }
        weakself.model.roleList = [arr copy];
        [weakself.tableView reloadData];
    };
    add.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:add animated:YES];
}
//添加角色
-(void)castingAdd
{
    WeakSelf(self);
    ProjectCastingAddVC *add = [ProjectCastingAddVC new];
    add.type = 1;
    add.VCAdd = ^(CastingModel * _Nonnull infoModel, NSInteger type) {
        NSMutableArray *arr = [NSMutableArray new];
        [arr addObjectsFromArray:weakself.model.roleList];
        [arr addObject:infoModel];
        weakself.model.roleList = [NSArray arrayWithArray:arr] ;
        [weakself.tableView reloadData];
    };
    add.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:add animated:YES];
}
#pragma -optionCellDelegate 拍摄项目的选项代理
-(void)ProjectOptionsCellSelectOptionWithType:(NSInteger)type
{
    WeakSelf(self);
    if(type == actionTypeDays){
        UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
        NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
        popv.dataSource = [NSArray arrayWithObjects:@"1天",@"2天",@"3天",@"4天",@"5天",nil];
        popv.title = @"拍摄天数";
        popv.selectStr = [NSString stringWithFormat:@"%ld天",(long)_model.shotDays];
        [popv initSubviews];
        popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
            NSString *auditionsDay = [string stringByReplacingOccurrencesOfString:@"天" withString:@""];
            if (weakself.model.shotDays != [auditionsDay integerValue]) {
                weakself.model.shotDays = [auditionsDay integerValue];
                weakself.model.projectEnd = @"";
                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            }
        };
    }
    else if(type == actionTypeCity){
        //selectedArr  artistRegin 演员所在地
        CitySelectStep1 *cityStep = [CitySelectStep1 new];
        cityStep.selectedArr = [_model.projectCity componentsSeparatedByString:@"、"];
        cityStep.hidesBottomBarWhenPushed=YES;
        cityStep.selectCity = ^(NSString *city) {
            //取出选择的城市，用、
            weakself.model.projectCity = city;
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:cityStep animated:YES];
    }else if (type == actionTypeUseTime){
        UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
        NSLog(@"popv's frame is %@",NSStringFromCGRect(popv.frame));
        popv.dataSource = [NSArray arrayWithObjects:@"1年",@"2年",@"3年",@"4年",@"5年",nil];
        popv.title = @"肖像周期";
        popv.selectStr = _model.shotCycle;
        [popv initSubviews];
        popv.selectID = ^(NSString * _Nonnull string) {//选择的周期和范围
            weakself.model.shotCycle = string;
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }else if (type == actionTypeUseRange){
        UseSelectPopView *popv = [[UseSelectPopView alloc] initWithFrame:self.view.frame];
        popv.dataSource = [NSArray arrayWithObjects:@"中国大陆",@"港澳台",@"海外其他",nil];
        popv.title = @"肖像范围";
        popv.selectStr = _model.shotRegion;
        [popv initSubviews];
        popv.selectID = ^(NSString * _Nonnull string) {//选择的天数和范围
            weakself.model.shotRegion = string;
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
}
#pragma -optionCell2Delegate 拍摄项目的选项代理
-(void)ProjectOptionsCell2SelectOptionWithType:(NSInteger)type andObj:(id)obj
{
    WeakSelf(self);
    if (type==optioncellActionTypeCity) {
        CitySelectView *cv = [[CitySelectView alloc] init];
        [cv showTypeWithSelectCities:[_model.projectCity componentsSeparatedByString:@"、"]];
        cv.citySelectAction = ^(NSArray * _Nonnull cities) {
            NSString *cityStr = [cities componentsJoinedByString:@"、"];
            weakself.model.shotCycle = cityStr;
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }else if (type==optioncellActionTypeDays){//拍摄天数
        NSInteger days = (NSInteger)obj;
        self.model.shotDays = days;
        self.model.projectEnd = @"";
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }else if (type==optioncellActionTypedate){//拍摄周期
        if (self.model.shotDays==0) {
            [SVProgressHUD showImage:nil status:@"请先选择拍摄天数"];
            return;
        }
        HotelCalendarViewController *vc = [[HotelCalendarViewController alloc]init];
        vc.delegate = self;
        vc.dataSource = self;
        vc.toDay = self.model.shotDays+2;
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:NO completion:nil];
       
    }else if (type==optioncellActionTypeUseTime){//肖像使用时间
        self.model.shotCycle = [NSString stringWithFormat:@"%ld年",(NSInteger)obj];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }else if (type==optioncellActionTypeUseRange){//肖像使用范围
        self.model.shotRegion = (NSString *)obj;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma mark - HotelCalendarViewDataSource
- (NSDate *)minimumDateForHotelCalendar {
    NSDate *nowDate = [NSDate new];
    NSDate *lastDate = nowDate;//[NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:nowDate];
    return lastDate;
}

- (NSDate *)maximumDateForHotelCalendar {
    return [NSCalendar date:[NSDate new] addMonth:2];
}

- (NSDate *)defaultSelectFromDate {//初始开始是哪一天
//    NSDate *nowDate = [NSDate new];
//    return [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:nowDate];//[NSDate new];
    return nil;
}
//改初始化持续天数 改selectCollection代码两处
- (NSDate *)defaultSelectToDate {//初始结束是哪一天 一共多少天
//    NSDate *nowDate = [NSDate new];
//
//    NSDate *nextDate = [NSDate dateWithTimeInterval:24 * 60 * 60*self.model.shotDays+2 sinceDate:[NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:nowDate]];
//    return nextDate;
    return nil;
}

#pragma mark - HotelCalendarViewDelegate
- (NSInteger)rangeDaysForHotelCalendar {
    return 365;
}

- (void)selectNSStringFromDate:(NSString *)fromDate toDate:(NSString *)toDate {
    if (!fromDate) {
        NSLog(@"未完成日期选择");
        return;
    }
     self.model.projectStart = fromDate;
    self.model.projectEnd = toDate;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
 
}

- (NSInteger)itemWidthForHotelCalendar{
    return 50;
}
#pragma - mark ensureCellDelegate    确认按钮点击后/接口
-(void)ProjectEnsureCellClicked
{
//    if (_uploadCount>0) {
//        [SVProgressHUD showImage:nil status:@"脚本还未完成上传"];
//        return;
//    }
    if (_model.projectName.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写项目名称"];
        return;
    }
    if (_model.projectDesc.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写项目简介"];
        return;
    }

    if (_model.shotDays==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄天数"];
        return;
    }
    if (_model.projectCity.length == 0) {
        [SVProgressHUD showImage:nil status:@"请选择城市"];
        return;
    }
    if (_model.projectStart.length==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄开始日期"];
        return;
    }
    if (_model.projectEnd.length==0) {
        [SVProgressHUD showImage:nil status:@"请选择拍摄结束日期"];
        return;
    }
    
if (_model.shotCycle.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择肖像周期"];
            return;
        }
        if (_model.shotRegion.length==0) {
            [SVProgressHUD showImage:nil status:@"请选择肖像范围"];
            return;
        }

    
  __block  NSMutableDictionary *projectDic = [NSMutableDictionary new];
    [projectDic setObject:_model.projectName forKey:@"projectName"];
    [projectDic setObject:_model.projectDesc forKey:@"projectDesc"];
    [projectDic setObject:_model.projectCity forKey:@"projectCity"];
    [projectDic setObject:_model.projectStart forKey:@"projectStart"];
    [projectDic setObject:_model.projectEnd forKey:@"projectEnd"];
    [projectDic setObject:[NSString stringWithFormat:@"%ld",(long)_model.shotDays] forKey:@"shotDays"];
    [projectDic setObject:@([[UserInfoManager getUserUID]integerValue]) forKey:@"userId"];
    if (_model.projectId.length>1) {
        [projectDic setObject:_model.projectId forKey:@"projectId"];
    }
    
  
    
    //厘清4种media
    //老照片//老视频//新照片//新视频
//    NSMutableArray *oldPhotos = [NSMutableArray new];
//    NSMutableArray *oldVideos = [NSMutableArray new];
//    NSMutableArray *newPhotos = [NSMutableArray new];
//    NSMutableArray *newVideos = [NSMutableArray new];
//    for (mediaModel *model in _photoArray) {
//        if (model.type==mediaTypePhotoOld) {
//            [oldPhotos addObject:model.url];
//        }
//        else if (model.type==mediaTypeVideoOld) {
//            [oldVideos addObject:model.url];
//        }
//        else if (model.type==mediaTypePhotoNew){
//            [newPhotos addObject:model.image];
//        }
//        else if (model.type==mediaTypeVideoNew){
//            [newVideos addObject:model.data];
//        }
//    }
    NSMutableArray *projectScriptList = [NSMutableArray new];
    for (mediaModel *media in _photoArray) {
        if (media.type==mediaTypePhotoOld || media.type==mediaTypePhotoNew) {
            if ([media.id isEqualToString:@""]) {
                continue;
            }
            NSDictionary *mediaDic = @{
                                       @"id":@([media.id integerValue]),
                                       @"type": @(1),
                                       @"url": media.url
                                       };
            [projectScriptList addObject:mediaDic];
        }else if (media.type==mediaTypeVideoOld || media.type==mediaTypeVideoNew){
            NSDictionary *mediaDic = @{
                                       @"id":@([media.id integerValue]),
                                       @"type": @(2),
                                       @"url": media.videourl,
                                       @"cutUrl":media.url,
                                       @"duration":media.duration
                                       };
            [projectScriptList addObject:mediaDic];
        }
    }
    [projectDic setObject:projectScriptList forKey:@"projectScriptList"];
    //填角色
    NSMutableArray *roleList = [NSMutableArray new];
 
    [projectDic setObject:@([[UserInfoManager getUserUID]integerValue]) forKey:@"userId"];
    [projectDic setObject:_model.shotCycle forKey:@"shotCycle"];
    [projectDic setObject:_model.shotRegion forKey:@"shotRegion"];
    if(_type == 1){//新建
          [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeClear];
        for (CastingModel *caMo in _model.roleList) {
            NSDictionary *roleDic = @{
                                      @"ageMax":@(caMo.ageMax),
                                      @"ageMin":@(caMo.ageMin),
                                      @"heightMax":@(caMo.heightMax),
                                      @"heightMin":@(caMo.heightMin),
                                      @"remark": caMo.remark,
                                      //                                  @"roleId": "修改时要传",
                                      @"roleName":caMo.roleName,
                                      @"sex":@(caMo.sex),
                                      @"typeName":caMo.typeName
                                      };
            [roleList addObject:roleDic];
        }
        [projectDic setObject:roleList forKey:@"roleList"];
            [AFWebAPI_JAVA addProjectWithArg:projectDic callBack:^(BOOL success, id object) {
                if (success) {
                    NSLog(@"response is %@",object);
                  //  ProjectModel *model = [ProjectModel yy_modelWithDictionary:[object objectForKey:JSON_data]];
                    [SVProgressHUD showSuccessWithStatus:@"新建项目成功"];
                 
                    [self.delegate VCReferesh];
                   
                    [self.navigationController popViewControllerAnimated:YES];
                } else
                {
                    [SVProgressHUD showErrorWithStatus:object];
                }
            }];
            return;
    }else if (_type == 2){//编辑   新老图片（url）
        if (_backView.hidden == YES && _effectOrders.count>0) { //点击编辑先查看是不是有关联订单，有的话弹窗倒计时

            _time = 10;
            self.backView.hidden = NO;
            self.tipView.hidden = NO;
                    self.btnTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUpData) userInfo:nil repeats:YES];
            return;
                }
        
        for (CastingModel *caMo in _model.roleList) {
            NSDictionary *roleDic = @{
                                      @"ageMax":@(caMo.ageMax),
                                      @"ageMin":@(caMo.ageMin),
                                      @"heightMax":@(caMo.heightMax),
                                      @"heightMin":@(caMo.heightMin),
                                      @"remark": caMo.remark,
                                      @"roleId": @(caMo.roleId),
                                      @"roleName":caMo.roleName,
                                      @"sex":@(caMo.sex),
                                      @"typeName":caMo.typeName
                                      };
            [roleList addObject:roleDic];
        }
        [projectDic setObject:roleList forKey:@"roleList"];
     
      
         [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeClear];
       
        [projectDic setObject:_effectOrders forKey:@"orderAdjustList"];
        [AFWebAPI_JAVA editProjectWithArg:projectDic callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"项目编辑成功"];
                if (_isFromAskCalendar) {
                    [self.delegate refereshVCWithModelId:_model.projectId];
                }else{
                [self.delegate VCReferesh];
                }
                if (_effectOrders.count>0) {
                    NoticeActorVC *nvc = [NoticeActorVC new];
                    nvc.effectActor = _effectActors;
                    nvc.projectId = _model.projectId;
                    nvc.projectStart = _model.projectStart;
                    nvc.projectEnd = _model.projectEnd;
                    nvc.effectOrders = _effectOrders;
                    nvc.projectDic = projectDic;
                    nvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:nvc animated:YES];
                    return;
                }
                    [self.navigationController popViewControllerAnimated:YES];
                
               
            } else
            {
                [SVProgressHUD showErrorWithStatus:object];
            }
        }];

         return;
   }
    
}
-(void)checkEffectOrdersbackArry:(void(^)(NSArray *arr))arrayBlock
{
    NSDictionary *dic = @{
                          @"projectId":_model.projectId
                          };
    [AFWebAPI_JAVA checkEffectOdersWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *oders = [object[@"body"] objectForKey:@"projectOrderList"];
//            NSMutableArray *effectOders = [NSMutableArray new];
//            for (NSDictionary *orderDic in oders) {
//                NSString *shotStart = orderDic[@"shotStart"];
//                NSString *shotEnd = orderDic[@"shotEnd"];
//                NSString *orderId = orderDic[@"orderId"];
//                NSDictionary *orderDic2 = @{
//                                            @"shotStart":shotStart,
//                                            @"shotEnd":shotEnd,
//                                            @"orderId":orderId
//                                            };
//                [effectOders addObject:orderDic2];
//            }
            if ([oders isKindOfClass:[NSArray class]]) {
                  arrayBlock([oders copy]);
            }else{
                 arrayBlock([NSArray new]);
            }
          
        }
    }];
}
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ProjectDescCell *descCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextView *textView = [descCell.contentView viewWithTag:111];
    [textView resignFirstResponder];
    UITextView *textField = [descCell.contentView viewWithTag:112];
    [textField resignFirstResponder];
}
#pragma mark---PlaceAuditCellECDelegate
-(void)addAction   //才艺作品添加视频
{
    NSInteger maxCount = 9;
    NSInteger oldCount = 0;
    for (mediaModel *model in _photoArray) {
        if (model.type==mediaTypePhotoOld || model.type==mediaTypeVideoOld) {
            oldCount++;
        }
    }
    if (_type==2) {//编辑页面进来需要减去原本存在的img
        maxCount = 9-oldCount;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    NSMutableArray *PHAssetArray = [NSMutableArray new];
    for (id anything in _selectedAssets) {//编辑界面进来，第一次添加图片可能数组装的是image(因为已经有图片了)，所以全部转PHAsset
        if (![anything isKindOfClass:[UIImage class]]) {
            [PHAssetArray addObject:anything];
        }
    }
    imagePickerVc.selectedAssets = PHAssetArray;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        //        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;//_isAudition?NO:YES;//试镜可选视频，拍摄不能选视频
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = YES; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = NO;
    
    // 设置首选语言 / Set preferred language
    imagePickerVc.preferredLanguage = @"zh-Hans";
    
#pragma mark - 到这里为止
    
    
    // NSTimeInterval time = asset.duration;
    //int times = round(time);
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeClear];
        //去掉相册选择的model
        NSMutableArray *newArr = [NSMutableArray new];
        for(int i=0; i<_photoArray.count;i++){
            mediaModel *model = _photoArray[i];
            if (model.type==mediaTypeVideoOld || model.type==mediaTypePhotoOld) {
                [newArr addObject:model];
            }
        }
        self.photoArray = [NSMutableArray arrayWithArray:newArr];
        [self.selectedAssets setArray:assets];
        //photoArray只是加了视频图片但没有加视频的data
        //装载新的model
        WeakSelf(self);
        __block NSInteger loadCount = 0;
        for (int i=0; i<assets.count;i++) {
            PHAsset *PHAsset =assets[i];
            UIImage *photo = photos[i];
            if (PHAsset.mediaType==2) {//视频
                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
                options.version = PHImageRequestOptionsVersionCurrent;
                options.networkAccessAllowed = true;  //允许网络视频加载
                options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                PHImageManager *manager = [PHImageManager defaultManager];
                [manager requestAVAssetForVideo:PHAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    NSURL *url = urlAsset.URL;
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    NSDictionary *videoModelDic = @{@"type":[NSNumber numberWithInt:mediaTypeVideoNew],@"image":photo,@"data":data,@"PHAssetDate":PHAsset.creationDate,@"duration":[NSString stringWithFormat:@"%f",PHAsset.duration],@"id":@""};
                    [weakself.photoArray addObject:[mediaModel yy_modelWithDictionary:videoModelDic]];
                    loadCount++;
                    if (loadCount == assets.count) {
                        [weakself upLoadShootMedia];
                    }
                }];
                
                
            }else{//图片
                NSDictionary *imageModelDic = @{@"type":[NSNumber numberWithInt:mediaTypePhotoNew],@"image":photo,@"PHAssetDate":PHAsset.creationDate,@"id":@""};
                [self.photoArray addObject:[mediaModel yy_modelWithDictionary:imageModelDic]];
                loadCount++;
                if (loadCount == assets.count) {
                    [weakself upLoadShootMedia];
                }
            }
            
        }
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)upLoadShootMedia
{

    [self sortPhotoArray];
 
        WeakSelf(self);

  __block  NSInteger uploadCount=0;
    for (mediaModel *mm in _photoArray) {
        if (mm.type==mediaTypePhotoNew || mm.type==mediaTypeVideoNew) {
            uploadCount++;
        }
    }

    for(int i =0;i<_photoArray.count;i++){
        mediaModel *model = _photoArray[i];
            if (model.type==mediaTypeVideoNew) {
                 NSString *pid;
                if (_type!=1) {
                    pid = [NSString stringWithFormat:@"%@",_model.projectId];
                }else{
                    pid = [NSString stringWithFormat:@""];
                }
                NSDictionary *dicArg = @{
                                         @"projectId":pid,
                                         @"userId":[UserInfoManager getUserUID]
                                         };
                [AFWebAPI_JAVA upLoadShootMediaIsImage:NO WithArg:dicArg data:model.data callBack:^(BOOL success, id  _Nonnull object) {
                    NSLog(@"obj  is %@",object);
                    uploadCount--;
                    if (success) {
                         NSDictionary *reponse = [object objectForKey:JSON_body];
                        model.id = [NSString stringWithFormat:@"%@",[reponse objectForKey:@"id"] ];
                        model.videourl = [NSString stringWithFormat:@"%@",[reponse objectForKey:@"url"]];
                    model.url = [NSString stringWithFormat:@"%@",[reponse objectForKey:@"cutUrl"]];
                        model.duration =  [NSString stringWithFormat:@"%@",[reponse objectForKey:@"duration"]];
                      }else{
                    
                    }
                 if (uploadCount==0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                            [self.tableView reloadData];
                        });
                    }
                }];
              
            }
            if (model.type==mediaTypePhotoNew) {
                NSString *pid;
                if (_type!=1) {
                    pid = [NSString stringWithFormat:@"%@",_model.projectId];
                }else{
                    pid = [NSString stringWithFormat:@""];
                }
                NSDictionary *dicArg = @{
                                         @"projectId":pid,
                                         @"userId":[UserInfoManager getUserUID]
                                         };
                //UIImagePNGRepresentation([PublicManager scaleImageWithSize:400 image:model.image])
          [AFWebAPI_JAVA upLoadShootMediaIsImage2:YES WithArg:dicArg data:UIImagePNGRepresentation([PublicManager scaleImageWithSize:400 image:model.image]) callBack:^(BOOL success, id  _Nonnull object) {
                 uploadCount--;
                    if (success) {
                        NSDictionary *reponse = [object objectForKey:JSON_body];
                        model.id = [NSString stringWithFormat:@"%@",[reponse objectForKey:@"id"] ];
                        model.url = [NSString stringWithFormat:@"%@",[reponse objectForKey:@"url"] ];
                       }
                    else{
                   
                    }
                 if (uploadCount==0) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                                    [self.tableView reloadData];
                                });
                          }
                }];
           }
       
     }
}

//删除图片
-(void)delectWithRow:(NSInteger)row
{
    if (self.photoArray.count>row) {
        mediaModel *deleteModel = _photoArray[row];
        if (deleteModel.type==mediaTypePhotoNew || deleteModel.type==mediaTypeVideoNew) {
            for (int i=0;i<_selectedAssets.count;i++) {
                PHAsset *set = _selectedAssets[i];
                if ([set.creationDate isEqualToDate:deleteModel.PHAssetDate]) {//说明删除了相册中选中的视频或图片
                    [_selectedAssets removeObjectAtIndex:i];
                }
            }
        }
        
        [self.photoArray removeObjectAtIndex:row];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
}

//查看大图
-(void)chekBigImageWithRow:(NSInteger)row
{
    if (_type==1 || _type==2) {//新建,n编辑 不能查看图片
        return;
    }
    mediaModel *clickModel = _photoArray[row];
    if (clickModel.type<2) {
        //说明点击的是视频
        [self playWorkVideoWithUrl:clickModel.videourl];
        return;
    }
    //图片
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    lookImage.downPhotoBlock = ^(NSInteger index) {};
    
    //装载所有图片类url
    NSMutableArray *urls = [NSMutableArray new];
    for (int i = 0;i<_photoArray.count;i++) {
        mediaModel *model = _photoArray[i];
        if (model.type>1) {
            [urls addObject:model.url];
        }
    }
    for(int j =0;j<urls.count;j++){
        NSString *url = urls[j];
        if ([url isEqualToString:clickModel.url]) {//确定点击图片在新数组中的下标
            row = j;
        }
    }
    [lookImage showWithImageArray:urls curImgIndex:row AbsRect:CGRectMake(0, 0,0,0)];
    [self.navigationController pushViewController:lookImage animated:YES];
}
- (void)onGoback
{
    [self.delegate VCReferesh]; //编辑了直接返回刷新列表，不然下次编辑会把修改过的model带入编辑页面];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)setModel:(ProjectModel2 *)model
{
    _model = model;
}
//根据开始时间生成结束时间 (n+2)个天数
-(NSDate *)start:(NSString *)start WithAudition:(NSInteger)auditionDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date1 = [dateFormatter dateFromString:start];
    
    NSTimeInterval  auditionDayInterval = 24 * 60 * 60 * (auditionDay+1);
    //  NSDate *date2 = [date1 initWithTimeIntervalSinceNow:auditionDayInterval];
    NSDate *date2 = [date1 dateByAddingTimeInterval:auditionDayInterval];
    return date2;
}
//将时间转化为date
-(NSDate *)dateWithString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date1 = [dateFormatter dateFromString:dateString];
    return date1;
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    if (_type == 3) {//查看
        // self.editView.hidden = YES;
        self.tableView.frame=CGRectMake(0, 42, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-105-42);
    }else if(_type == 1){//新建则没有编号
        //  self.tableView.y=0;
        //   self.checkView.hidden = YES;
        self.tableView.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-105);
    }else{//编辑
        //  self.projectNum.text = _model.projectid;
        self.tableView.frame=CGRectMake(0, 42, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-105-42);
    }
    
    
}
-(void )sortPhotoArray
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES];
    //这个数组保存的是排序好的对象
    NSArray *tempArray = [_photoArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];//升序排列 老视频、新视频、老图片、新图片
    self.photoArray = [NSMutableArray arrayWithArray:tempArray];
}
//播放视频组
-(void)playWorkVideoWithUrl:(NSString *)url
{
    
    
    [_player destroyPlayer];
    _player = nil;
    
    _player = [[VideoPlayer alloc] init];
    _player.videoUrl =url;
    _player.onlyFullScreen=YES;
    
    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
    WeakSelf(self);
    _player.dowmLoadBlock = ^{
        //   [weakself VideostatisticsWithWorkModel:model withType:2];
    };
    
    //    [self VideostatisticsWithWorkModel:model withType:1];
}
-(void)checkEditHistory
{
    EditHistoryVC *editHis = [EditHistoryVC new];
    editHis.projectId = _model.projectId;
    editHis.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editHis animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_player destroyPlayer];
    _player = nil;
}
- (IBAction)cancel:(id)sender {
    self.backView.hidden = YES;
    self.tipView.hidden = YES;
    [self.btnTimer invalidate];
    self.btnTimer = nil;
}
- (IBAction)timeAction:(id)sender {
       [self ProjectEnsureCellClicked];
     [self closeAction:nil];
}

- (IBAction)closeAction:(id)sender {
    self.backView.hidden = YES;
    self.tipView.hidden = YES;
    [self.btnTimer invalidate];
    self.btnTimer = nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.btnTimer invalidate];
    self.btnTimer = nil;
}
-(void)timeUpData
{
    
  
    if (_time>1) {
        _time--;
        [self.timeBtn setTitle:[NSString stringWithFormat:@"%ldS",_time] forState:0];
        self.timeBtn.userInteractionEnabled = NO;
    }else{
        [self.timeBtn setTitle:@"确定" forState:0];
        self.timeBtn.titleLabel.textColor = [UIColor colorWithHexString:@"464646"];
       // self.time = 10;
        self.timeBtn.userInteractionEnabled = YES;
        [self.btnTimer invalidate];
        self.btnTimer = nil;
    }
 }
@end
