//
//  PlaceOrderModel.m
//  IDLook
//
//  Created by HYH on 2018/6/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceOrderModel.h"

@implementation PlaceOrderModel

//试镜方式
+(NSArray*)getAuditionWay
{
    NSArray *array =  @[@{@"title":@"自备场地",@"desc":@"下单后会有客服联系，将演员带到您指定的影棚试镜",@"price":@"120",@"ischoose":@(NO),@"type":@(1)},
                        @{@"title":@"影棚试镜",@"desc":@"专业人员根据脚本，高质高效的拍摄试镜视频",@"price":@"300",@"ischoose":@(NO),@"type":@(2)},
                        @{@"title":@"手机快速试镜",@"desc":@"两小时后响应，24小时内根据脚本，邮件方式提供试镜短视频素材",@"price":@"60",@"ischoose":@(NO),@"type":@(3)},
                        @{@"title":@"在线试镜",@"desc":@"随时随地实时在线视频试镜，和演员沟通更顺畅",@"price":@"60",@"ischoose":@(NO),@"type":@(4)}
                        ];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    
    return array1;
}

//试镜任务要求
+(NSArray*)getAuditionRequirement
{
    NSArray *array=  @[@{@"title":@"拍摄天数",@"placeholder":@"请选择拍摄天数",@"isEdit":@(NO)},
                       @{@"title":@"拍摄城市",@"placeholder":@"请选择拍摄城市（可多选）",@"isEdit":@(NO)},
                       @{@"title":@"拍摄日期",@"placeholder":@"",@"isEdit":@(NO)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    return array1;
    
}

//品牌方介绍
+(NSArray*)getBrandIntroduction
{
    NSArray *array= @[@{@"title":@"项目名称",@"placeholder":@"请输入项目名称（如TVC拍摄）",@"isEdit":@(YES)},
                      @{@"title":@"品牌/品类",@"placeholder":@"请输入产品品牌/品类（如蒙牛）",@"isEdit":@(YES)},
                      @{@"title":@"产品",@"placeholder":@"请输入产品名称（如牛奶）",@"isEdit":@(YES)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    return array1;
}

//品牌方介绍2
+(NSArray*)getBrandIntroduction2
{
    NSArray *array=  @[@{@"title":@"品牌/品类",@"placeholder":@"请输入产品品牌/品类（如蒙牛）",@"isEdit":@(YES)},
                       @{@"title":@"产品",@"placeholder":@"请输入产品名称（如牛奶）",@"isEdit":@(YES)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    return array1;
}

//定妆方式
+(NSArray*)getShotWay
{
    NSArray *array =  @[@{@"title":@"平面影棚",@"content":@"定妆费",@"desc":@"专业度中，面积中，免收预约意向金",@"price":@"600",@"ischoose":@(NO),@"type":@(22)},
                        @{@"title":@"自备场地",@"content":@"意向金",@"desc":@"",@"price":@"0",@"ischoose":@(NO),@"type":@(1)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    
    return array1;
}

//定妆类型
+(NSArray*)getMakeupWay
{
    NSArray *array =  @[@{@"title":@"自助定妆",@"desc":@"自备场地，脸探客服通知演员准时到达您指定的地点定妆",@"price":@"0",@"ischoose":@(NO),@"type":@(1)},
                        @{@"title":@"脸探定妆",@"desc":@"脸探提供定妆影棚，并负责拍摄及联络演员准时到场定妆",@"price":@"600",@"ischoose":@(NO),@"type":@(2)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    
    return array1;
}

//锁档方式
+(NSArray*)getScheduleWay
{
    NSArray *array =  @[@{@"title":@"不预付档期预约金",@"content":@"不锁定艺人档期，演员如果单方面解除拍摄合约，没有赔付",@"desc":@"艺人如若爽约，没有赔付",@"price":@"0",@"ischoose":@(NO),@"type":@(2)},
                        @{@"title":@"预付档期预约金",@"content":@"锁定艺人档期，演员单方面解约，将向您赔偿双倍预约金，并退还预约金，拍摄完成后，预约金将转为演出费抵扣尾款",@"desc":@"",@"price":@"400",@"ischoose":@(NO),@"type":@(1)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    
    return array1;
}

//拍摄类别
+(NSArray*)getShotTypes
{
    NSArray *array=  @[@{@"title":@"拍摄城市",@"placeholder":@"请选择拍摄城市（可多选）",@"isEdit":@(NO)},
                       @{@"title":@"拍摄日期",@"placeholder":@"",@"isEdit":@(NO)},
                       @{@"title":@"肖像周期",@"placeholder":@"请选择肖像周期",@"isEdit":@(NO)},
                       @{@"title":@"肖像范围",@"placeholder":@"请选择肖像范围",@"isEdit":@(NO)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    
    return array1;
}

//拍摄定装费用
+(NSArray*)getShotPrice
{
    NSArray *array = @[@{@"title":@"定装费",@"price":@"400.00",@"ischoose":@(NO)},
                       @{@"title":@"跟片员费",@"price":@"500.00",@"ischoose":@(YES)}
//                       @{@"title":@"保险费",@"price":@"500.00",@"ischoose":@(NO)}
                       ];
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    return array1;
}

//微出镜任务要求
+(NSArray*)getMirrorRequirement
{
    NSArray *array=  @[@{@"title":@"微出镜周期",@"placeholder":@"请选择微出镜周期",@"isEdit":@(NO)},
                       @{@"title":@"微出镜区域",@"placeholder":@"请选择微出镜区域",@"isEdit":@(NO)},
                       @{@"title":@"微出镜范围",@"placeholder":@"请选择微出镜范围（可多选）",@"isEdit":@(NO)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    return array1;
}

//试葩间任务要求
+(NSArray*)getTrialRequirement
{
    NSArray *array=  @[@{@"title":@"素材使用周期",@"placeholder":@"请选择素材使用周期",@"isEdit":@(NO)},
                       @{@"title":@"素材使用区域",@"placeholder":@"请选择素材使用区域",@"isEdit":@(NO)},
                       @{@"title":@"素材使用范围",@"placeholder":@"请选择素材使用范围",@"isEdit":@(NO)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    return array1;
}

//续约内容
+(NSArray*)getRenewalContent
{
    NSArray *array=  @[@{@"title":@"续约类别",@"placeholder":@"请选择续约类别（可多选）",@"isEdit":@(NO)},
                       @{@"title":@"续约周期",@"placeholder":@"请选择续约周期",@"isEdit":@(NO)},
                       @{@"title":@"续约范围",@"placeholder":@"请选择续约范围",@"isEdit":@(NO)},
                       @{@"title":@"原合同到期日",@"placeholder":@"请选择原合同到期时间",@"isEdit":@(NO)}];
    
    NSMutableArray  *array1 = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i =0; i<array.count; i++) {
        OrderStructM *model = [[OrderStructM alloc]initWithDic:array[i]];
        [array1 addObject:model];
    }
    return array1;
}

//获取报价系数
+(CGFloat)getRatioWithSinglePrice:(CGFloat)price
{
    CGFloat ratio =0.00;
    if (price<=3000) {
        ratio =0.135;
    }
    else if (price<=6000)
    {
        ratio =0.115;
    }
    else if (price<=10000)
    {
        ratio =0.095;
    }
    else if (price<=20000)
    {
        ratio =0.075;
    }
    else
    {
        ratio =0.075;
    }
    return (ratio+1)/0.94;
}
+(CGFloat)getRatioWithSinglePriceWithNew:(CGFloat)price
{
    CGFloat ratio =0.00;
    if (price<=3000) {
        ratio =0.135;
    }
    else if (price<=6000)
    {
        ratio =0.115;
    }
    else if (price<=10000)
    {
        ratio =0.095;
    }
    else if (price<=20000)
    {
        ratio =0.075;
    }
    else
    {
        ratio =0.075;
    }
    return  ((ratio+1)/0.94)/0.94;
}

@end

@implementation OrderStructM

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.title = (NSString*)safeObjectForKey(dic, @"title");
        self.desc = (NSString*)safeObjectForKey(dic, @"desc");
        self.price = (NSString*)safeObjectForKey(dic, @"price");
        self.isChoose = [(NSNumber*)safeObjectForKey(dic, @"ischoose") boolValue];
        self.isEdit = [(NSNumber*)safeObjectForKey(dic, @"isEdit") boolValue];
        self.content = (NSString*)safeObjectForKey(dic, @"content");
        self.placeholder = (NSString*)safeObjectForKey(dic, @"placeholder");
        self.type = [(NSNumber*)safeObjectForKey(dic, @"type") integerValue];
    }
    return self;
}
@end

