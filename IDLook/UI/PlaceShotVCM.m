//
//  PlaceShotVCM.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "PlaceShotVCM.h"

NSString * const kPlaceShotVCMCellClass =  @"kPlaceShotVCMCellClass";
NSString * const kPlaceShotVCMCellHeight = @"kPlaceShotVCMCellHeight";
NSString * const kPlaceShotVCMCellData =   @"kPlaceShotVCMCellData";

@implementation PlaceShotVCM

-(NSMutableArray*)ds
{
    if (!_ds) {
        _ds=[NSMutableArray new];
    }
    return _ds;
}

-(void)refreshShotInfo
{
    [self.ds removeAllObjects];
    
    NSMutableArray *sec0= [NSMutableArray new];
    NSMutableArray *sec1= [NSMutableArray new];
    NSMutableArray *sec2= [NSMutableArray new];
    
    [sec0 addObject:@{kPlaceShotVCMCellData:self.info,
                      kPlaceShotVCMCellClass:@"PlaceAuditItemCellA",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:74]}];
    
    [sec1 addObject:@{kPlaceShotVCMCellData:self.info,
                      kPlaceShotVCMCellClass:@"PlaceAuditCellC",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:93]}];
    
    NSArray *array=  @[@{@"title":@"定妆场地",@"placeholder":@"请选择定妆场地",@"isEdit":@(NO)},
                       @{@"title":@"拍摄类别",@"placeholder":@"请选择拍摄类别",@"isEdit":@(NO)},
                       @{@"title":@"档期预约金",@"placeholder":@"为了保障买家和演员双方的利益，减少敲定档期后单方面解除合约的风险，脸探肖像平台推出了档期预约金",@"isEdit":@(NO)}];
    OrderStructM *model1 = [[OrderStructM alloc]initWithDic:array[0]];
    OrderStructM *model2 = [[OrderStructM alloc]initWithDic:array[1]];
    OrderStructM *model3 = [[OrderStructM alloc]initWithDic:array[2]];

    [sec1 addObject:@{kPlaceShotVCMCellData:model1,
                      kPlaceShotVCMCellClass:@"PlaceOrderCustomCell",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:48]}];
    
    [sec1 addObject:@{kPlaceShotVCMCellData:model2,
                      kPlaceShotVCMCellClass:@"ShotStepCellF",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:48]}];
    
    [sec1 addObject:@{kPlaceShotVCMCellData:model3,
                      kPlaceShotVCMCellClass:@"ShotStepCellA",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:84]}];

    
    
    [sec2 addObject:@{kPlaceShotVCMCellData:self.info,
                      kPlaceShotVCMCellClass:@"PlaceAuditCellD",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:48]}];
    
    [self.ds addObject:sec0];
    [self.ds addObject:sec1];
    [self.ds addObject:sec2];
    
    if(self.newDataNeedRefreshed)
    {
        self.newDataNeedRefreshed();
    }
    
}

// 添加项目筛选cell
-(void)addItemRefreshCell
{
    NSMutableArray *sec0= [NSMutableArray new];
    
    [sec0 addObject:@{kPlaceShotVCMCellData:self.info,
                      kPlaceShotVCMCellClass:@"PlaceAuditItemCellC",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:89]}];
    
    [sec0 addObject:@{kPlaceShotVCMCellData:@(NO),
                      kPlaceShotVCMCellClass:@"PlaceAuditItemCellB",
                      kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:148]}];
    
    [self.ds replaceObjectAtIndex:0 withObject:sec0];
    
    if(self.newDataNeedRefreshed)
    {
        self.newDataNeedRefreshed();
    }
}

//项目cell刷新
-(void)isExpendItemWithValue:(BOOL)expend withProjectModel:(ProjectModel *)model
{
    NSMutableArray *sec = [self.ds firstObject];
    NSDictionary *dic;
    if (expend==NO) {
        dic=@{kPlaceShotVCMCellData:@(expend),
              kPlaceShotVCMCellClass:@"PlaceAuditItemCellB",
              kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:148]};
    }
    else
    {
        CGFloat width = (UI_SCREEN_WIDTH -30-16)/3;
        NSArray *urlArray;
        CGFloat urlHeight=0;
        if (model.url.length>0) {
            urlArray = [model.url componentsSeparatedByString:@"|"];
            urlHeight = ((urlArray.count-1)/3+1)*(width+10);
        }
        CGFloat descH = [self heighOfString:model.desc font:[UIFont systemFontOfSize:16] width:UI_SCREEN_WIDTH-30];
        
        CGFloat totalH = 41 + descH + urlHeight + 180;
        
        dic=@{kPlaceShotVCMCellData:@(expend),
              kPlaceShotVCMCellClass:@"PlaceAuditItemCellB",
              kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:totalH]};
    }
    
    if (sec.count==2) {
        [sec replaceObjectAtIndex:1 withObject:dic];
    }
}

/**
 下单类别选择刷新数据
 */
-(void)orderTypeRefreshUI
{
    NSMutableArray *sec = self.ds[1];
    
    NSDictionary *dicA = sec[2];
    OrderStructM *model = [dicA objectForKey:kPlaceShotVCMCellData];
    
    NSDictionary *dic= @{kPlaceShotVCMCellData:model,
                         kPlaceShotVCMCellClass:@"ShotStepCellF",
                         kPlaceShotVCMCellHeight:[NSNumber numberWithFloat:model.videoTypeArray.count<2?48:74]};
    
    [sec replaceObjectAtIndex:2 withObject:dic];

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

@end
