//
//  ProjectOrderDetialVCM.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderDetialVCM.h"

NSString * const kProjectOrderDetialVCMCellClass =  @"kProjectOrderDetialVCMCellClass";
NSString * const kProjectOrderDetialVCMCellHeight = @"kProjectOrderDetialVCMCellHeight";
NSString * const kProjectOrderDetialVCMCellType =   @"kProjectOrderDetialVCMCellType";
NSString * const kProjectOrderDetialVCMCellData =   @"kProjectOrderDetialVCMCellData";

@implementation ProjectOrderDetialVCM

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)refreshDataWithOrderId:(NSString *)orderId
{
    NSDictionary *dicArg = @{@"orderId":orderId,
                             @"userId":[UserInfoManager getUserUID]
                             };
    
    [AFWebAPI_JAVA getOrderDetialWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            self.info= [[ProjectOrderInfoM alloc]initWithDic:dic];
            [self analyzeOrderInfo];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

-(void)analyzeOrderInfo
{
    if (self.info==nil) return;
    
    [self.ds removeAllObjects];
    
    //项目状态
    [self.ds addObject:@{kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellA",
                         kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeState],
                         kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:77]}];
    
    //项目信息
    NSString *remark = self.info.projectInfo[@"projectDesc"];
    CGFloat projectH = 185;
    
    CGFloat descH = [self heighOfString:[NSString stringWithFormat:@"项目简介：%@",remark] font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-25];
    
    projectH+=descH;
    
    CGFloat width = (UI_SCREEN_WIDTH -30-3*8)/4;
    NSInteger count = self.info.projectScriptList.count;
    
    if (count>0) {  //脚本高度
        projectH=projectH+(width+10)*((count-1)/4+1)+10;
    }
    
    [self.ds addObject:@{kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellB",
                         kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeProjectInfo],
                         kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:projectH]}];
    
    //询档
    if (self.info.orderType==0) {
        NSString *auditionDate = (NSString*)safeObjectForKey(self.info.askScheduleInfo, @"auditionDate"); //试镜时间
        NSString *makeupDate = (NSString*)safeObjectForKey(self.info.askScheduleInfo, @"makeupDate"); //定妆时间
        BOOL latestPhoto = [(NSNumber*)safeObjectForKey(self.info.askScheduleInfo, @"latestPhoto")boolValue];
        
        NSInteger negoPriceState = [(NSNumber*)safeObjectForKey(self.info.askScheduleInfo, @"negoPriceState")integerValue];  //议价状态 0:无议价; 1:议价中；2:议价成功；3：议价失败
        
        NSString *priceReason = (NSString*)safeObjectForKey(self.info.askScheduleInfo, @"priceReason");
        NSString *reason=@"无";
        if(negoPriceState!=0 && priceReason.length>0)
        {
            reason=priceReason;
        }
        
        NSArray *array = @[@{@"title":@"询档艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                           @{@"title":@"拍摄类别：",@"content":self.info.shotType==nil?@"":self.info.shotType,@"height":@(20)},
                           @{@"title":@"试镜时间：",@"content":auditionDate,@"height":@(20)},
                           @{@"title":@"定妆时间：",@"content":makeupDate,@"height":@(20)},
                           @{@"title":@"要求演员上传最新照片：",@"content":latestPhoto==YES?@"是":@"否",@"height":@(20)},
                           @{@"title":@"申请议价：",@"content":negoPriceState==0?@"无":[NSString stringWithFormat:@"¥%ld",self.info.totalPrice],@"height":@(20)},
                           @{@"title":@"议价理由：",@"content":reason,@"height":@([self heighOfString:reason font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100])}];
        
        NSArray *latestPhotoList = (NSArray*)safeObjectForKey(self.info.askScheduleInfo, @"latestPhotoList");
        CGFloat pWidth = (UI_SCREEN_WIDTH-30-30)/4;
        CGFloat photoH = 0 ;
        if (latestPhotoList.count>0) {
            photoH = (pWidth+10)*((latestPhotoList.count-1)/4+1)+55;
        }
        
        //询档信息
        [self.ds addObject:@{kProjectOrderDetialVCMCellData:@{@"title":@"询档信息",@"list":array},
                             kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellE",
                             kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeAskScheduleInfo],
                             kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:278+[self heighOfString:reason font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100]+photoH]}];
    }
    //试镜
    else if (self.info.orderType==3)
    {
        NSInteger auditionMode =  [self.info.tryVideoInfo[@"auditionMode"] integerValue];

        NSArray *array;
        CGFloat auditheiht = 0;
        
        if (auditionMode==1) {  //自备场地
            NSString *auditionDate = (NSString*)safeObjectForKey(self.info.tryVideoInfo, @"auditionDate");
            NSString *tryVideoAddress = (NSString*)safeObjectForKey(self.info.tryVideoInfo, @"tryVideoAddress");
            NSString *remark = (NSString*)safeObjectForKey(self.info.tryVideoInfo, @"remark");
            
            array = @[@{@"title":@"试镜艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                      @{@"title":@"试镜方式：",@"content":[self.info getAuditionWayWithType:auditionMode],@"height":@(20)},
                      @{@"title":@"试镜时间：",@"content":auditionDate.length==0?@"无":auditionDate,@"height":@(20)},
                      @{@"title":@"试镜地址：",@"content":tryVideoAddress.length==0?@"无":tryVideoAddress,@"height":@([self heighOfString:tryVideoAddress font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100])},
                      @{@"title":@"试镜备注：",@"content":remark.length==0?@"无":remark,@"height":@([self heighOfString:remark font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100])},
                      ];
            auditheiht=210+[self heighOfString:tryVideoAddress font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100]+[self heighOfString:remark font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100];
        }
        else if (auditionMode==2)  //影棚试镜
        {
            NSString *auditionDate = (NSString*)safeObjectForKey(self.info.tryVideoInfo, @"auditionDate");

            array = @[@{@"title":@"试镜艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                      @{@"title":@"试镜方式：",@"content":[self.info getAuditionWayWithType:auditionMode],@"height":@(20)},
                      @{@"title":@"试镜时间：",@"content":auditionDate.length==0?@"无":auditionDate,@"height":@(20)}
                      ];
            auditheiht=200;
        }
        else if ( auditionMode==3) //，手机快速
        {

            array = @[@{@"title":@"试镜艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                      @{@"title":@"试镜方式：",@"content":[self.info getAuditionWayWithType:auditionMode],@"height":@(20)},
                      @{@"title":@"最晚上传作品日期：",@"content":self.info.tryVideoInfo[@"auditionLatestworkTime"],@"height":@(20)}];
            auditheiht=200;
        }
        else if ( auditionMode==4) //，在线试镜
        {
            
            array = @[@{@"title":@"试镜艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                      @{@"title":@"试镜方式：",@"content":[self.info getAuditionWayWithType:auditionMode],@"height":@(20)},
                      @{@"title":@"试镜时间：",@"content":self.info.tryVideoInfo[@"auditionDate"],@"height":@(20)}];
            auditheiht=200;
        }
        //试镜信息
        [self.ds addObject:@{kProjectOrderDetialVCMCellData:@{@"title":@"试镜信息",@"list":array},
                             kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellE",
                             kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeAskScheduleInfo],
                             kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:auditheiht]}];
    }
    //锁档
    else if (self.info.orderType==7)
    {
        NSArray *array = @[@{@"title":@"拍摄艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                           @{@"title":@"拍摄类别：",@"content":self.info.shotType==nil?@"":self.info.shotType,@"height":@(20)},
                           @{@"title":@"拍摄日期：",@"content":[NSString stringWithFormat:@"%@至%@",self.info.shotStart,self.info.shotEnd],@"height":@(20)}];
        //拍摄信息
        [self.ds addObject:@{kProjectOrderDetialVCMCellData:@{@"title":@"拍摄信息",@"list":array},
                             kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellE",
                             kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeAskScheduleInfo],
                             kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:200]}];
        
        //档期预约金
        [self.ds addObject:@{kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellD",
                             kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeScheduleGuarantee],
                             kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:73]}];
    }
    //定妆
    else if (self.info.orderType==5)
    {
        NSInteger makeupType = [(NSNumber*)safeObjectForKey(self.info.makeupInfo, @"makeupType") integerValue];
        NSString *makeupAddress = (NSString*)safeObjectForKey(self.info.makeupInfo, @"makeupAddress");

        NSArray *array = @[@{@"title":@"定妆艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                           @{@"title":@"定妆类别：",@"content":[self.info getMakeupTypeWithType:makeupType],@"height":@(20)},
                           @{@"title":@"定妆时间：",@"content":(NSString*)safeObjectForKey(self.info.makeupInfo, @"makeupDate"),@"height":@(20)},
                           @{@"title":@"定妆地址：",@"content":makeupAddress,@"height":@([self heighOfString:makeupAddress font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100])}];
        //定妆信息
        [self.ds addObject:@{kProjectOrderDetialVCMCellData:@{@"title":@"定妆信息",@"list":array},
                             kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellE",
                             kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeAskScheduleInfo],
                             kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:205+[self heighOfString:makeupAddress font:[UIFont systemFontOfSize:13] width:UI_SCREEN_WIDTH-100]]}];
    }
    //拍摄
    else if (self.info.orderType==4)
    {
        NSArray *array = @[@{@"title":@"拍摄艺人：",@"content":(NSString*)safeObjectForKey(self.info.actorInfo, @"actorName"),@"height":@(20)},
                           @{@"title":@"拍摄类别：",@"content":self.info.shotType==nil?@"":self.info.shotType,@"height":@(20)},
                           @{@"title":@"拍摄日期：",@"content":[NSString stringWithFormat:@"%@至%@",self.info.shotStart,self.info.shotEnd],@"height":@(20)}];
        //拍摄信息
        [self.ds addObject:@{kProjectOrderDetialVCMCellData:@{@"title":@"拍摄信息",@"list":array},
                             kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellE",
                             kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeAskScheduleInfo],
                             kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:200]}];
    }
    
    
    //保险
    [self.ds addObject:@{kProjectOrderDetialVCMCellClass:@"PlaceAuditCellD",
                         kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeInsurance],
                         kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:48]}];
    
    //订单信息
    [self.ds addObject:@{kProjectOrderDetialVCMCellClass:@"ProjectOrderDetialCellC",
                         kProjectOrderDetialVCMCellType:[NSNumber numberWithInteger:ProjectOrderDetialCellTypeOrderInfo],
                         kProjectOrderDetialVCMCellHeight:[NSNumber numberWithFloat:96]}];
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
}

//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 3;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20?20.0:ceilf(size.height);
}

@end
