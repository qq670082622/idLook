//
//  AskCalendarVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/4.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AskCalendarVC.h"
#import "AskPriceCell.h"
#import "AskDescCell.h"
#import "AskCastingCell.h"
#import "AskOtherCell.h"
#import "ProjectModel2.h"
#import "AskNoPojectCell.h"
#import "ApplyPriceVC.h"
#import "VIPViewController.h"
#import "OfferTypePopV3.h"
#import "MyProjectVC2.h"
#import "ProjectDetailVC2.h"
#import "ProjectCastingListVC.h"
#import "InsuranceVC.h"
#import "AskCalendarTipView.h"
#import "ActorPriceListVC.h"
#import "AskCalendarPriceModel.h"

@interface AskCalendarVC ()<UITableViewDelegate,UITableViewDataSource,ProjectDetailVC2Delegate,AskOtherCellDelegate,ActorPriceListVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(nonatomic,strong)ProjectModel2 *model;
//@property(nonatomic,strong)NSDictionary *photoDic;
//@property(nonatomic,strong)NSDictionary *videoDic;
//@property(nonatomic,strong)NSDictionary *groupDic;
@property(nonatomic,assign) NSInteger priceCellHeight;

@property(nonatomic,assign) NSInteger descCellHeight;

@property(nonatomic,copy)NSString *testTime;
@property(nonatomic,copy)NSString *adornTime;
@property(nonatomic,assign)BOOL needNewPhoto;
@property(nonatomic,assign)NSInteger applyPrice;
@property(nonatomic,copy)NSString *applyReason;
@property(nonatomic,assign) NSInteger otherCellHeight;

@property(nonatomic,strong)CastingModel *casting;
@end

@implementation AskCalendarVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"询问档期"]];
    _applyReason = @"";
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self VCReferesh];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_model.projectId.length>0) {
        return 4;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
AskDescCell *descCell = [AskDescCell cellWithTableView:tableView];
if (_model.projectId.length>0) {//有项目 传描述
        if (indexPath.row==0) {
            return  _priceCellHeight>0?_priceCellHeight:188;
        }else if (indexPath.row==1){
          
            return _descCellHeight>0?_descCellHeight:[descCell reloadUIWithArray:_model.projectScriptList];
          //  return 331;
        }else if (indexPath.row==2){
            return 232;//角色cell
        }else if (indexPath.row==3){
            return _otherCellHeight>0?_otherCellHeight:383;
        }
    }else{//无项目 传添加项目的cell
        if (indexPath.row==0) {
            return  _priceCellHeight>0?_priceCellHeight:188;
        }else if (indexPath.row==1){
            return 306;//添加项目cell
        }else if (indexPath.row==2){
             return _otherCellHeight>0?_otherCellHeight:383;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
 
    
    AskPriceCell *priceCell = [AskPriceCell cellWithTableView:tableView];
    priceCell.info = _info;
    [priceCell setVip_price:_total_vip andNormalPrice:_total_normal];
   _priceCellHeight = [priceCell reloadUIWithArray:_selectArray];
    
    priceCell.vipAction = ^{//申请vip
        VIPViewController *vip = [VIPViewController new];
        vip.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vip animated:YES];
    };
    priceCell.typeAction = ^{//选择拍摄类型（弹窗）
        ActorPriceListVC *apvc = [ActorPriceListVC new];
        apvc.hidesBottomBarWhenPushed = YES;
        apvc.actorId = weakself.info.actorId;
        apvc.projectId = _model.projectId;
        apvc.delegate = weakself;
        apvc.selectArr = weakself.selectArray;//[modelArr copy];
        apvc.year = _orderYear;
        apvc.region = _orderRegion;
        apvc.yidi = _otherArea;
        apvc.pushType = 3;
        [weakself.navigationController pushViewController:apvc animated:YES];
//        OfferTypePopV3 *pop = [[OfferTypePopV3 alloc] init];
//        [pop showOfferTypeWithPriceList:weakself.info.priceInfo[@"quotationList"] withSelectArray:weakself.selectArray withUserModel:nil];
//        pop.typeSelectAction = ^(NSArray * _Nonnull selectArray) {
//            weakself.selectArray = [NSArray arrayWithArray:selectArray];
//            [weakself.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
//        };
    };
    
    AskDescCell *descCell = [AskDescCell cellWithTableView:tableView];
    descCell.model = _model;
    _descCellHeight = descCell.cellHeight;
 //   [descCell reloadUIWithArray:[NSArray array]];//mediaModel模型数组
    descCell.otherSelect = ^{//选择其他项目
        MyProjectVC2 *vc2 = [MyProjectVC2 new];
        vc2.isSelectType = YES;
        vc2.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc2 animated:YES];
        vc2.selectModel = ^(ProjectModel2 * _Nonnull pjModel) {
            weakself.model = pjModel;
            [weakself reLoadUIFromProject:pjModel];
            [weakself.table reloadData];
        };
    };
    
    //        如果没有项目，则应该是另外的cell
    AskNoPojectCell *noProjCell = [AskNoPojectCell cellWithTableView:tableView];
    noProjCell.addProject = ^{//添加项目
        ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
        PDVC.hidesBottomBarWhenPushed=YES;
        PDVC.delegate = weakself;
        PDVC.type = 1;
        [weakself.navigationController pushViewController:PDVC animated:YES];
    };
    
    AskCastingCell *castingCell = [AskCastingCell cellWithTableView:tableView];
    castingCell.model = _casting;
    castingCell.otherSelect = ^{//选择其他角色
        ProjectCastingListVC *list = [ProjectCastingListVC new];
        list.type = 1;
        list.fromAsk = YES;
        list.projectId = weakself.model.projectId;
        list.hidesBottomBarWhenPushed = YES;
        list.selectCasting = ^(CastingModel * _Nonnull casting) {
            weakself.casting = casting;
              [weakself.table reloadData];
        };
      
        [weakself.navigationController pushViewController:list animated:YES];
    };
    
    AskOtherCell *otherCell = [AskOtherCell cellWithTableView:tableView];
    otherCell.testTime = _testTime.length?_testTime:@"";
    otherCell.adornTime = _adornTime.length?_adornTime:@"";
    otherCell.needNewPhoto = _needNewPhoto;
    [otherCell loadUIWithPrice:_applyPrice andReason:_applyReason];
    _otherCellHeight = otherCell.otherCellHeight;
    otherCell.delegate = self;
    otherCell.testTimeBlock = ^(NSString * _Nonnull time) {//选择了试镜时间
        weakself.testTime = time;
    };
    otherCell.adornTimeBlock = ^(NSString * _Nonnull time) {//选择了定妆时间
        weakself.adornTime = time;
    };
    otherCell.priceAction = ^{//点击了议价按钮
        if (weakself.selectArray.count==0) {
            [SVProgressHUD showErrorWithStatus:@"请先选择拍摄类型"];
            return ;
        }
        ApplyPriceVC *apvc = [ApplyPriceVC new];
        apvc.hidesBottomBarWhenPushed = YES;
        apvc.info = weakself.info;
//        NSDictionary *priceInfo = weakself.info.priceInfo;
       // NSInteger startPrice = [priceInfo[@"startPrice"]integerValue];
     //  NSInteger vipStartPrice = [priceInfo[@"startPriceVip"]integerValue];
        NSInteger status = [UserInfoManager getUserStatus];
        if (status>200) {
             apvc.actorPrice = weakself.total_vip;
        }else{
        apvc.actorPrice = weakself.total_normal;
        }
        apvc.castingNameStr = weakself.casting.roleName.length>0?weakself.casting.roleName:@"暂无";
        apvc.applyReason = weakself.applyReason.length>0?weakself.applyReason:@"";
        apvc.applyedPrice = weakself.applyPrice>0?weakself.applyPrice:0;
        apvc.applyPrice = ^(NSInteger price, NSString * _Nonnull reason) {
            weakself.applyPrice = price;
            weakself.applyReason = reason;
            [weakself.table reloadData];
        };
        [weakself.navigationController pushViewController:apvc animated:YES];
    };
    otherCell.switchAction = ^(BOOL needNewPhoto) {//选择了是否要求最新照片
        weakself.needNewPhoto = needNewPhoto;
    };
 
    if (_model.projectId.length>0) {//有项目
        if (indexPath.row==0) {
            return priceCell;
            
        }else if (indexPath.row==1){
            
            return descCell;
        
    }else if (indexPath.row==2){
        return castingCell;
    }else{
        
        return otherCell;
    }
    }else{//无项目
        if (indexPath.row==0) {
            return priceCell;
            
        }else if (indexPath.row==1){
            
            return noProjCell;
            
        }else if (indexPath.row==2){
            return otherCell;
        }
    }
    return [UITableViewCell new];
}
-(void)selectPrices:(NSArray *)prices andYear:(NSInteger)year andRegion:(NSInteger)region andYidi:(NSInteger)yidi andTotal_vip:(NSInteger)total_vip andTotalNormal:(NSInteger)totalNormal
{
   self.selectArray = prices;
    self.orderYear = year;
    self.orderRegion = region;
    self.otherArea = yidi;
    self.total_vip = total_vip;
    self.total_normal = totalNormal;
   [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)askDate
{

  //角色 项目
    if (_model.projectId.length<3) {
        [SVProgressHUD showErrorWithStatus:@"请先选择项目"];
        return;
    }
    if (_casting.roleId==0) {
        [SVProgressHUD showErrorWithStatus:@"请先新建角色"];
        return;
    }
//    if (_testTime.length<3) {
//        [SVProgressHUD showErrorWithStatus:@"请先选择试镜时间"];
//        return;
//    }
//    if (_adornTime.length<3) {
//        [SVProgressHUD showErrorWithStatus:@"请先选择定妆时间"];
//        return;
//    }
    if (_selectArray.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择拍摄类型"];
        return;
    }
    //#import "AskCalendarTipView.h" 此处增加  “检测到您选择的拍摄天数超过了项目的拍摄周期，另外您项目信息中的3年(肖像周期)、中国大陆(肖像范围)和您选择的报价信息不一致，请重新确认。 ”
    //此处需要新增肖像年限，肖像范围，是否异地拍摄。并判断拍摄报价里选择的拍摄时间，肖像年限和范围是否在项目作用域内
   NSInteger dayMergin = [self numberOfDaysWithFromStr:_model.projectStart tosTR:_model.projectEnd];
    BOOL dateBeyond = false;
    NSInteger shotDays = 0;
    for (AskCalendarPriceModel *priM in _selectArray) {
      shotDays+=priM.day;
    }
            if (shotDays>dayMergin+1) {
                dateBeyond = YES;
            }
    BOOL yearBeyond = false;
    if (_orderYear != [[_model.shotCycle stringByReplacingOccurrencesOfString:@"年" withString:@""] integerValue]) {
        yearBeyond = YES;
    }
  
    BOOL regionBeyond = false;
    NSArray *regions = @[@"大陆",@"港澳台",@"海外"];
    NSString *regionStr = [regions objectAtIndex:_orderRegion-1];
    if (![_model.shotRegion containsString:regionStr]) {
        regionBeyond = YES;
    }
    //检测到您选择的拍摄天数超过了项目的拍摄周期，另外您项目信息中的3年(肖像周期)、中国大陆(肖像范围)和您选择的报价信息不一致，请重新确认。
    
    NSString *tip2 = [NSString stringWithFormat:@"您项目信息中的%@年(肖像周期)和您选择的报价信息不一致,",_model.shotCycle];
    NSString *tip3 = [NSString stringWithFormat:@"您项目信息中的%@(肖像范围)和您选择的报价信息不一致,",_model.shotRegion];
    NSString *tip4 = [NSString stringWithFormat:@"您项目信息中的%@(肖像周期)、%@(肖像范围)和您选择的报价信息不一致,",_model.shotCycle,_model.shotRegion];
    NSMutableString *tipString = [NSMutableString new];
    if (dateBeyond) {
        [tipString appendString:@"检测到您选择的拍摄天数超过了项目的拍摄周期"];
        if (yearBeyond && !regionBeyond) {
              [tipString appendString:[NSString stringWithFormat:@"，另外，%@请重新确认。",tip2]];
        }else if (!yearBeyond && regionBeyond){
             [tipString appendString:[NSString stringWithFormat:@"，另外，%@请重新确认。",tip3]];
        }else if (yearBeyond && regionBeyond){
            [tipString appendString:[NSString stringWithFormat:@"，另外，%@请重新确认。",tip4]];
        }else if (!yearBeyond && !regionBeyond){
            [tipString appendString:[NSString stringWithFormat:@"，请重新确认。"]];
        }
    }else{
        if (yearBeyond && !regionBeyond) {
            [tipString appendString:[NSString stringWithFormat:@"检测到%@请重新确认。",tip2]];
        }else if (!yearBeyond && regionBeyond){
            [tipString appendString:[NSString stringWithFormat:@"检测到%@请重新确认。",tip3]];
        }else if (yearBeyond && regionBeyond){
            [tipString appendString:[NSString stringWithFormat:@"检测到%@请重新确认。",tip4]];
        }
    }
    if (tipString.length>0) {
        WeakSelf(self);
        AskCalendarTipView *tipView = [[AskCalendarTipView alloc] init];
       
        [tipView showTitle: [tipString stringByReplacingOccurrencesOfString:@"年年" withString:@"年"]];
        tipView.tipViewAction = ^(NSInteger type) {//0修改项目 1修改报价内容
            if (type==0) {
//                MyProjectVC2 *vc2 = [MyProjectVC2 new];
//                vc2.isSelectType = YES;
//                vc2.hidesBottomBarWhenPushed = YES;
//                [weakself.navigationController pushViewController:vc2 animated:YES];
//                vc2.selectModel = ^(ProjectModel2 * _Nonnull pjModel) {
//                    weakself.model = pjModel;
//                    [weakself reLoadUIFromProject:pjModel];
//                    [weakself.table reloadData];
//                };
                NSDictionary *diaArg = @{
                                         @"projectId":weakself.model.projectId,
                                         @"userId": @([[UserInfoManager getUserUID] integerValue])
                                         };
                [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
                    if (success) {
                        NSDictionary *moDic = [object objectForKey:JSON_body];
                        ProjectModel2 *model = [ProjectModel2 yy_modelWithDictionary:moDic];
                        ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
                        PDVC.hidesBottomBarWhenPushed=YES;
                        PDVC.model = model;
                        PDVC.type = 2;
                        PDVC.delegate = weakself;
                        PDVC.isFromAskCalendar = YES;
                        [weakself.navigationController pushViewController:PDVC animated:YES];
                    }
                }];
            }else if (type==1){
                ActorPriceListVC *apvc = [ActorPriceListVC new];
                apvc.hidesBottomBarWhenPushed = YES;
                apvc.actorId = weakself.info.actorId;
                apvc.projectId = _model.projectId;
                apvc.delegate = weakself;
                apvc.selectArr = weakself.selectArray;
                apvc.year = _orderYear;
                apvc.region = _orderRegion;
                apvc.yidi = _otherArea;
                apvc.pushType = 3;
                [weakself.navigationController pushViewController:apvc animated:YES];
            }
        };
        return;
    }
  
    
#warning cc!!
    NSMutableArray *itemList = [NSMutableArray new];
    for (AskCalendarPriceModel *model in _selectArray) {
  
        NSInteger price = model.price;
        
        NSDictionary *priceDic = @{
                                   @"singleType":@(model.type),
                                   @"days":@(model.day),
                                   @"price":@(price)
                                   };
        [itemList addObject:priceDic];
    }
    NSDictionary *shotOrderType = @{
                                    @"shotCycle":@(_orderYear==4?6:_orderYear),
                                    @"shotRegion":@(_orderRegion+16),
                                    @"shotTravel":@(_otherArea-1)
                                    };
    _testTime = _testTime==nil?@"":_testTime;
    _adornTime = _adornTime ==nil?@"":_adornTime;
    NSDictionary *dicArg = @{
                             @"actorId":@(_info.actorId),
                             @"auditionDate":_testTime,
                             @"makeupDate":_adornTime,
                             @"buyerPrice":@(_applyPrice),
                             @"priceReason":_applyReason,
                             @"latestPhoto":@(_needNewPhoto),
                             @"projectId":_model.projectId,
                             @"roleId":@(_casting.roleId),
                             @"userId":@([[UserInfoManager getUserUID] integerValue]),
                             @"itemList":[itemList copy],
                             @"shotOrderType":shotOrderType
                             };
    [AFWebAPI_JAVA askDateWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            //定义一个数组来接收所有导航控制器里的视图控制器
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"pushToOrderTab" object:@"" userInfo:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
//            NSArray *controllers = self.navigationController.viewControllers;
//            for (int i=0;i<controllers.count;i++) {
//                id vc = controllers[i];
//                 //根据索引号直接pop到指定视图
//                if ([vc isKindOfClass:[UserInfoVC class]]) {
//                       [self.navigationController popToViewController:[controllers objectAtIndex:i] animated:YES];
//                    break;
//                }
//            }
           
}else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
}
//新建项目成功，再调接口拿项目
-(void)VCReferesh
{
  NSDictionary *diaArg = @{
                             @"projectId":@"",
                             @"userId": @([[UserInfoManager getUserUID] integerValue])
                             };
    [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *moDic = [object objectForKey:JSON_body];
            ProjectModel2 *model = [ProjectModel2 yy_modelWithDictionary:moDic];
            _model = model;
            [self reLoadUIFromProject:model];
            
            [self.table reloadData];
        }
    }];
}
-(void)refereshVCWithModelId:(NSString *)modelId
{
    NSDictionary *diaArg = @{
                             @"projectId":modelId,
                             @"userId": @([[UserInfoManager getUserUID] integerValue])
                             };
    [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *moDic = [object objectForKey:JSON_body];
            ProjectModel2 *model = [ProjectModel2 yy_modelWithDictionary:moDic];
            _model = model;
            [self reLoadUIFromProject:model];
            
            [self.table reloadData];
        }
    }];
}
//项目里的脚本用自线程加载不卡进程
-(void)reLoadUIFromProject:(ProjectModel2 *)model
{
      WeakSelf(self);
    NSDictionary *firstRole = [model.roleList firstObject];
    _casting = [CastingModel yy_modelWithDictionary:firstRole];
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
    __block NSMutableArray *mediaArray = [NSMutableArray new];
    _model.projectScriptList = [NSArray new];
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
                    //   [self.selectedAssets addObject:videoImg];
                    [mediaArray addObject:[mediaModel yy_modelWithDictionary:videoModelDic]];
                    
                    if (screenCount==0) {
                        weakself.model.projectScriptList = [mediaArray copy];
                        [weakself.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
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
                    // [self.selectedAssets addObject:img];
                    [mediaArray addObject:[mediaModel yy_modelWithDictionary:imageModelDic]];
                    
                    if (screenCount==0) {
                        // [self sortPhotoArray];
                        weakself.model.projectScriptList = [mediaArray copy];
                        [weakself.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            } );
            
        }];
        [queue addOperation:op];
    }
}
-(NSInteger)numberOfDaysWithFromStr:(NSString *)fromStr tosTR:(NSString *)ToStr {
    // 创建一个标准国际时间的日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 可根据需要自己设置时区.
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [dateFormatter dateFromString:fromStr];
    NSDate *toDate = [dateFormatter dateFromString:ToStr];
    // 获取两个日期的间隔
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay|NSCalendarUnitHour fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];
//    NSInteger hour = (comp.hour - comp.day * 24);
    return comp.day;
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CastingModel *)casting
{
    if (!_casting) {
        _casting = [CastingModel new];
    }
    return _casting;
}
-(NSArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSArray array];
    }
    return _selectArray;
}
@end
