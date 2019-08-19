//
//  PlaceAuditionVCM.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditionVCM.h"

NSString * const kPlaceAuditionVCMCellClass =  @"kPlaceAuditionVCMCellClass";
NSString * const kPlaceAuditionVCMCellHeight = @"kPlaceAuditionVCMCellHeight";
NSString * const kPlaceAuditionVCMCellData =   @"kPlaceAuditionVCMCellData";

@implementation PlaceAuditionVCM

-(NSMutableArray*)ds
{
    if (!_ds) {
        _ds=[NSMutableArray new];
    }
    return _ds;
}

-(void)refreshAuditionInfo
{
    [self.ds removeAllObjects];
    
    NSMutableArray *sec0= [NSMutableArray new];
    NSMutableArray *sec1= [NSMutableArray new];
    NSMutableArray *sec2= [NSMutableArray new];

    [sec0 addObject:@{kPlaceAuditionVCMCellData:self.info,
                      kPlaceAuditionVCMCellClass:@"PlaceAuditItemCellA",
                      kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:74]}];
    
    [sec1 addObject:@{kPlaceAuditionVCMCellData:self.info,
                      kPlaceAuditionVCMCellClass:@"PlaceAuditCellC",
                      kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:93]}];
    
    NSDictionary *dic= @{@"title":@"试镜方式",@"placeholder":@"请选择试镜方式",@"isEdit":@(NO)};
    OrderStructM *model = [[OrderStructM alloc]initWithDic:dic];
    model.content=self.orderInfo.title;
    model.price=self.orderInfo.price;
    model.type=self.orderInfo.type;
    [sec1 addObject:@{kPlaceAuditionVCMCellData:model,
                      kPlaceAuditionVCMCellClass:@"PlaceOrderCustomCell",
                      kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:48]}];
    
    if (self.orderInfo.type==1||self.orderInfo.type==2) {   //自备场地和影棚试镜有保险
        [sec2 addObject:@{kPlaceAuditionVCMCellData:self.info,
                          kPlaceAuditionVCMCellClass:@"PlaceAuditCellD",
                          kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:48]}];
    }

    
    [self.ds addObject:sec0];
    [self.ds addObject:sec1];
    [self.ds addObject:sec2];

    
    if(self.newDataNeedRefreshed)
    {
        self.newDataNeedRefreshed();
    }
    
}

-(void)addItemRefreshCell
{
    NSMutableArray *sec0= [NSMutableArray new];

    [sec0 addObject:@{kPlaceAuditionVCMCellData:self.info,
                      kPlaceAuditionVCMCellClass:@"PlaceAuditItemCellC",
                      kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:89]}];
    
    [sec0 addObject:@{kPlaceAuditionVCMCellData:@(NO),
                      kPlaceAuditionVCMCellClass:@"PlaceAuditItemCellB",
                      kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:148]}];
    
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
    NSDictionary *dic ;
    if (expend==NO) {
        dic=@{kPlaceAuditionVCMCellData:@(expend),
              kPlaceAuditionVCMCellClass:@"PlaceAuditItemCellB",
              kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:148]};
    }
    else
    {
        CGFloat width = (UI_SCREEN_WIDTH -30-16)/3;
        CGFloat urlHeight=0;
        NSInteger count = model.vdo.count+model.img.count;  //图片+视频个数
        if (count>0) {
            urlHeight = ((count-1)/3+1)*(width+10);
        }
        
        CGFloat descH = [self heighOfString:model.desc font:[UIFont systemFontOfSize:16] width:UI_SCREEN_WIDTH-30];
        
        CGFloat totalH = 41 + descH + urlHeight + 220;
        
        dic=@{kPlaceAuditionVCMCellData:@(expend),
              kPlaceAuditionVCMCellClass:@"PlaceAuditItemCellB",
              kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:totalH]};
    }
    
    if (sec.count==2) {
        [sec replaceObjectAtIndex:1 withObject:dic];
    }
}

-(void)refreshInsuranceCellWithModel:(OrderStructM *)model
{
    if (model.type==1||model.type==2) {
        if (self.ds.count==2) {
            NSMutableArray *sec= [NSMutableArray new];
            [sec addObject:@{kPlaceAuditionVCMCellData:self.info,
                              kPlaceAuditionVCMCellClass:@"PlaceAuditCellD",
                              kPlaceAuditionVCMCellHeight:[NSNumber numberWithFloat:48]}];
            [self.ds addObject:sec];
        }
    }
    else
    {
        if (self.ds.count==3) {
            [self.ds removeLastObject];
        }
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

@end
