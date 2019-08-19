//
//  OrderDetialVCM.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialVCM.h"

NSString * const kOrderDetialVCMCellClass =  @"kOrderDetialVCMCellClass";
NSString * const kOrderDetialVCMCellHeight = @"kOrderDetialVCMCellHeight";
NSString * const kOrderDetialVCMCellType =   @"kOrderDetialVCMCellType";
NSString * const kOrderDetialVCMCellData =   @"kOrderDetialVCMCellData";


@implementation OrderDetialVCM

-(id)init
{
    if (self=[super init]) {
    }
    return self;
}

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)refreshOrderInfoWithOrderModel:(OrderModel *)model withProjM:(OrderProjectModel *)models
{
//    [self analyzeOrderInfoWithOrderModel:model];
    NSDictionary *dicArg = @{@"orderid":model.orderId,
                             @"userid":[UserInfoManager getUserUID],
                             @"projectid":models.projectid
                             };
    [AFWebAPI getOrderDetail:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_data];
            OrderProjectModel *modelA = [[OrderProjectModel alloc]initWithDic:dic];
            [self analyzeOrderInfoWithOrderModel:modelA];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

-(void)analyzeOrderInfoWithOrderModel:(OrderProjectModel *)models
{
    [self.ds removeAllObjects];
    
    OrderModel *model = [models.orderlist firstObject];
    self.model=model;

    OrderType type = model.ordertype;
    
    NSMutableArray *sec0 = [NSMutableArray new];
    NSMutableArray *sec1 = [NSMutableArray new];
    NSMutableArray *sec2 = [NSMutableArray new];
    NSMutableArray *sec3 = [NSMutableArray new];
    
    [sec0 addObject:@{kOrderDetialVCMCellData:model,
                      kOrderDetialVCMCellClass:@"OrderDetialCellA",
                      kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:84],
                      kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
    
    if (type==OrderTypeShot && [model.orderstate isEqualToString:@"paiedone"]) {  //拍摄订单提示付尾款,购买方，有预约金 有提示文字
        if ([UserInfoManager getUserType]==UserTypePurchaser && model.payterms==1) {
            CGFloat cellHeight=0;
            NSString *desc = @"";
            
            //当前时间
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *curDay=[formatter stringFromDate:[NSDate date]];
            int dataCompare = [PublicManager compareOneDay:curDay withAnotherDay:models.end];
            
            if (dataCompare<=0) {
                cellHeight=74;
                desc=@"您已锁定艺人档期，请如期拍摄。如果单方面解除拍摄合约，不可单独申请退还预约金。";
            }
            else
            {
                cellHeight=42;
                desc=@"请在拍摄完成后十个工作日内支付剩余尾款。";
            }
            
            [sec0 addObject:@{kOrderDetialVCMCellData:desc,
                              kOrderDetialVCMCellClass:@"OrderDetialCellO",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:cellHeight],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
    }
    
    [sec0 addObject:@{kOrderDetialVCMCellData:model,
                      kOrderDetialVCMCellClass:@"OrderDetialCellB",
                      kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:40],
                      kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
    if (type==OrderTypeAudition)
    {
        NSString *desc =@"";
        if ([UserInfoManager getUserType]==UserTypeResourcer && model.auditionType==3 ) {  //手机试镜需上传视频
            desc = @"   (请竖屏拍摄视频)";
        }
        
        NSArray *array1 = @[@{@"title":@"项目编号",@"content":models.projectid,@"height":@(27)},
                            @{@"title":@"项目名称",@"content":models.name,@"height":@(27)},
                            @{@"title":@"项目简介",@"content":models.desc,@"height":@([self heighOfString:models.desc font:[UIFont systemFontOfSize:16] width:UI_SCREEN_WIDTH-135]+10)},
                            @{@"title":@"试镜艺人",@"content":model.actorNick,@"height":@(27)},
                            @{@"title":@"试镜方式",@"content":[NSString stringWithFormat:@"%@%@",[model getAuditionWayWithType:model.auditionType],desc],@"height":@(27)},
                            @{@"title":@"最晚上传作品日期",@"content":models.auditionend,@"height":@(27)},
                            ];
        
        CGFloat totalH = 40;
        for (int i =0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            totalH+=[dic[@"height"]floatValue];
        }
        
        [sec0 addObject:@{kOrderDetialVCMCellData:array1,
                          kOrderDetialVCMCellClass:@"OrderDetialCellC",
                          kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:totalH],
                          kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        
        NSArray *array2 = @[@{@"title":@"拍摄天数",@"content":[NSString stringWithFormat:@"%ld天",models.auditiondays],@"height":@(27)},
                            @{@"title":@"拍摄城市",@"content":models.city,@"height":@(27)},
                            @{@"title":@"拍摄日期",@"content":[NSString stringWithFormat:@"%@至%@",models.start,models.end],@"height":@(27)}];
        CGFloat totalH2 = 40;
        for (int i =0; i<array2.count; i++) {
            NSDictionary *dic = array2[i];
            totalH2+=[dic[@"height"]floatValue];
        }
        
        [sec0 addObject:@{kOrderDetialVCMCellData:array2,
                          kOrderDetialVCMCellClass:@"OrderDetialCellC",
                          kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:totalH2],
                          kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        
        if ((models.vdo.count+models.img.count)>0) {
            [sec0 addObject:@{kOrderDetialVCMCellData:models.url,
                              kOrderDetialVCMCellClass:@"OrderDetialCellN",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:48],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
        
        if ([model.orderstate isEqualToString:@"videouploaded"]||[model.orderstate isEqualToString:@"finished"]) {
            [sec1 addObject:@{kOrderDetialVCMCellClass:@"OrderDetialCellH",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:48],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
        
        if ([UserInfoManager getUserType]==UserTypePurchaser) {
            [sec1 addObject:@{kOrderDetialVCMCellData:model.price,
                              kOrderDetialVCMCellClass:@"OrderDetialCellD",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:63],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];}
        else
        {
            NSArray *array = @[@{@"title":@"到手价",@"desc":@"",@"content":[NSString stringWithFormat:@"¥ %ld",[model.profit integerValue]]}];
            [sec1 addObject:@{kOrderDetialVCMCellData:array,
                              kOrderDetialVCMCellClass:@"OrderDetialCellE",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:55],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
        if (model.auditionType==1 || model.auditionType==2) {
            [sec2 addObject:@{kOrderDetialVCMCellData:@"",
                              kOrderDetialVCMCellClass:@"OrderDetialCellM",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:48],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
        
        if ([model.orderstate isEqualToString:@"cancel"] || [model.orderstate isEqualToString:@"rejected"] || [model.orderstate isEqualToString:@"overtime"] || [model.orderstate isEqualToString:@"buydefault"] ||[model.orderstate isEqualToString:@"actordefault"]||[model.orderstate isEqualToString:@"noschedule"])
        {
            CGFloat height = [self heighOfString:model.ordermsg font:[UIFont systemFontOfSize:16] width:UI_SCREEN_WIDTH-140];
            [sec3 addObject:@{kOrderDetialVCMCellClass:@"OrderDetialCellG",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:height+20],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
    }
    else
    {
        
        NSString *advTypeName = @"";
        if (model.shootdays2>0) {
            advTypeName = [NSString stringWithFormat:@"%@/%ld天,%@/%ld天",model.advType,model.shootdays,model.advType2,model.shootdays2];
        }
        else
        {
            advTypeName = [NSString stringWithFormat:@"%@/%ld天",model.advType,model.shootdays];
        }
        
        NSArray *array1 = @[@{@"title":@"项目编号",@"content":models.projectid,@"height":@(27)},
                            @{@"title":@"项目名称",@"content":models.name,@"height":@(27)},
                            @{@"title":@"项目简介",@"content":models.desc,@"height":@([self heighOfString:models.desc font:[UIFont systemFontOfSize:16] width:UI_SCREEN_WIDTH-135])},
                            @{@"title":@"拍摄艺人",@"content":model.actorNick,@"height":@(27)},
                            @{@"title":@"定妆场地",@"content":model.shotordertype==1?@"自备场地":@"平面影棚",@"height":@(27)},
                            @{@"title":@"下单类别",@"content":advTypeName,@"height":@(27)}
                            ];
        
        CGFloat totalH1 = 40;
        for (int i =0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            totalH1+=[dic[@"height"]floatValue];
        }
        
        [sec0 addObject:@{kOrderDetialVCMCellData:array1,
                          kOrderDetialVCMCellClass:@"OrderDetialCellC",
                          kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:totalH1],
                          kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        
        NSArray *array2 = @[
                             @{@"title":@"拍摄城市",@"content":models.city,@"height":@(27)},
                             @{@"title":@"拍摄日期",@"content":[NSString stringWithFormat:@"%@  至  %@",models.start,models.end],@"height":@(27)},
                             @{@"title":@"肖像周期",@"content":models.shotcycle,@"height":@(27)},
                             @{@"title":@"肖像范围",@"content":models.shotregion,@"height":@(27)}];
        CGFloat totalH2 = 40;
        for (int i =0; i<array2.count; i++) {
            NSDictionary *dic = array2[i];
            totalH2+=[dic[@"height"]floatValue];
        }
        
        [sec0 addObject:@{kOrderDetialVCMCellData:array2,
                          kOrderDetialVCMCellClass:@"OrderDetialCellC",
                          kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:totalH2],
                          kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        
        if (models.url.length>0) {
            [sec0 addObject:@{kOrderDetialVCMCellData:models.url,
                              kOrderDetialVCMCellClass:@"OrderDetialCellN",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:48],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
        

        
        NSArray *array;
        CGFloat height ;
        if ([UserInfoManager getUserType]==UserTypePurchaser)
        {
            NSString *fixPrice =fixPrice =[NSString stringWithFormat:@"¥%ld",[model.offerInfo[@"fixedprice"] integerValue]];
            
            NSString *state1  = @"";
            if ([model.orderstate isEqualToString:@"new"]) {
                state1=@"(待支付)";
            }
            else
            {
                state1=@"(已支付)";
            }
            
            height=200;

            BOOL isShowPromt  = YES; //是否显示提示文字
            if ([model.orderstate isEqualToString:@"paiedtwo"] || [model.orderstate isEqualToString:@"finished"]) {
                isShowPromt = NO;
                height=200;
            }
            
//            NSInteger taxesPrice  = (([model.showprice integerValue]-[model.freeprice integerValue])/0.9-([model.showprice integerValue]-[model.freeprice integerValue]));  //税费
            array = @[@{@"title":@"订单总价",@"desc":@"",@"content":[NSString stringWithFormat:@"¥%ld",[model.totalprice integerValue]],@"isShowPromt":@(isShowPromt)},
                      @{@"title":@"定妆费",@"desc":@"",@"content":[NSString stringWithFormat:@"¥ %ld",[model.ordertypeprice integerValue]]},
                      @{@"title":@"演出费",@"desc":@"",@"content":[NSString stringWithFormat:@"¥%ld",[model.showprice integerValue]]},
                      @{@"title":@"演出费优惠",@"desc":@"",@"content":[NSString stringWithFormat:@" - ¥%ld",([model.freeprice integerValue]<0?0:[model.freeprice integerValue])]},
//                      @{@"title":@"税费",@"desc":@"",@"content":[NSString stringWithFormat:@"¥%ld",taxesPrice]},
                      @{@"title":@"保险费",@"desc":@"",@"content":@" ¥30  ¥0"}];
        }
        else
        {
            array = @[@{@"title":@"演出费",@"desc":@"",@"content":[NSString stringWithFormat:@"¥ %ld",[model.totalprofit integerValue]],@"isShowPromt":@(NO)}];
            height=71;
        }
    
        
        [sec1 addObject:@{kOrderDetialVCMCellData:array,
                          kOrderDetialVCMCellClass:@"OrderDetialCellE",
                          kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:height],
                          kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [sec1 addObject:@{kOrderDetialVCMCellData:@"",
                          kOrderDetialVCMCellClass:@"OrderDetialCellM",
                          kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:48],
                          kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        
        if ([model.orderstate isEqualToString:@"cancel"] || [model.orderstate isEqualToString:@"rejected"] || [model.orderstate isEqualToString:@"overtime"] || [model.orderstate isEqualToString:@"buydefault"] ||[model.orderstate isEqualToString:@"actordefault"]||[model.orderstate isEqualToString:@"noschedule"])
        {
            CGFloat height = [self heighOfString:model.ordermsg font:[UIFont systemFontOfSize:16] width:UI_SCREEN_WIDTH-140];
            [sec2 addObject:@{kOrderDetialVCMCellClass:@"OrderDetialCellG",
                              kOrderDetialVCMCellHeight:[NSNumber numberWithFloat:height+20],
                              kOrderDetialVCMCellType:[NSNumber numberWithInteger:0]}];
        }
    }
    
    
    if (sec0.count) {
        [self.ds addObject:sec0];
    }
    if (sec1.count) {
        [self.ds addObject:sec1];
    }
    if (sec2.count) {
        [self.ds addObject:sec2];
    }
    if (sec3.count) {
        [self.ds addObject:sec3];
    }
    
    
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
    contentLab.lineSpacing = 5;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<27.0?27.0:ceilf(size.height);
}

//空字符串进行处理
-(NSString*)dealNULLString:(NSString*)str
{
    return str.length>0?str:@"--";
}

@end
