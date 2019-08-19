//
//  AddPriceManger.m
//  IDLook
//
//  Created by HYH on 2018/7/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceManger.h"

@implementation AddPriceManger

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(NSMutableArray*)titleArray
{
    if (!_titleArray) {
        _titleArray=[NSMutableArray new];
    }
    return _titleArray;
}

-(void)refreshPriceInfoWithSinglePrice:(NSInteger)price andAdverType:(NSInteger)tyep
{
    [self.ds removeAllObjects];
    [self.titleArray removeAllObjects];
    
    NSDictionary *dic = [UserInfoManager getPublicConfig];
    
    NSArray *array1;
    if (tyep!=4) {
        array1 = dic[@"shootDays"];;
    }else{
        array1 = dic[@"comboDays"];
        }
    NSArray *array2 = dic[@"shootPlace"];
    NSArray *array3 = dic[@"shotCycle"];
    NSArray *array4 = dic[@"shotRegion"];

    NSMutableArray *dataS1 = [NSMutableArray new];
    NSMutableArray *dataS2 = [NSMutableArray new];
    NSMutableArray *dataS3 = [NSMutableArray new];
    NSMutableArray *dataS4 = [NSMutableArray new];

    for (int i=0; i<array1.count-1; i++) {
        NSDictionary *dicA = array1[i];
        AddPriceModel *model = [[AddPriceModel alloc]initWithDic:dicA];
        [dataS1 addObject:model];
     
        CGFloat ratio =1.00;
        if (tyep!=4) {
           for (int j=0; j<dataS1.count; j++) {
                AddPriceModel *model1 = dataS1[j];
                ratio+=model1.ratio;
            }
        }else{
            for (int j=0; j<dataS1.count; j++) {
                AddPriceModel *model1 = dataS1[j];
                ratio=model1.ratio;
            }
        }
     
        
        //decimal确定价格精度，直接用flaot相乘精度有误差
        NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",price]];
        NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",ratio]];

        // 乘
        NSDecimalNumber *sumNum = [number1 decimalNumberByMultiplyingBy:number2];
        
        model.price=[sumNum integerValue]; //取整
        if (i==array1.count-1) {
            model.price=-1;
        }
    }
    
    for (int i=0; i<array2.count; i++) {
        NSDictionary *dicA = array2[i];
        AddPriceModel *model = [[AddPriceModel alloc]initWithDic:dicA];
        [dataS2 addObject:model];
    
        model.price=price*model.ratio;
    }

    for (int i=0; i<array3.count-1; i++) {
        NSDictionary *dicA = array3[i];
        AddPriceModel *model = [[AddPriceModel alloc]initWithDic:dicA];
        [dataS3 addObject:model];

        CGFloat ratio =0.00;
        for (int j=0; j<dataS3.count; j++) {
            AddPriceModel *model1 = dataS3[j];
            ratio+=model1.ratio;
        }
        model.price=price*ratio;
        if (i==array1.count-1) {
            model.price=-1;
        }
    }

    for (int i=0; i<array4.count-1; i++) {
        NSDictionary *dicA = array4[i];
        AddPriceModel *model = [[AddPriceModel alloc]initWithDic:dicA];
        [dataS4 addObject:model];
        
        model.price=price*model.ratio;
        if (i==array4.count-1) {
            model.price=-1;
        }
    }

    [self.ds addObject:dataS1];
    [self.ds addObject:dataS2];
    [self.ds addObject:dataS3];
    [self.ds addObject:dataS4];

    [self.titleArray setArray:@[@"拍摄天数",@"拍摄城市",@"肖像年限",@"肖像范围"]];
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
}

-(void)changePriceWithTag:(NSInteger)tag withPrice:(CGFloat)price
{
    NSArray *array =[self.ds firstObject];
    if (tag>=array.count) return;
    
    AddPriceModel *model =array[tag];
    model.price=price;
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
}

-(void)changeShotDayPriceWithArray:(NSArray *)array
{
    NSArray *arr =[self.ds firstObject];

    if (arr.count>array.count) return;
    
    for (int i=0; i<arr.count; i++) {
        AddPriceModel *model = arr[i];
        for (int j=0; j<array.count; j++) {
            NSDictionary *dic =array[j];
            if ([model.eng isEqualToString:dic[@"key"]]) {
                model.price =[dic[@"price"]floatValue];
            }
        }
    }
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
}
-(void)changeShotDayPriceWithPriceList:(NSArray *)array
{
    NSArray *arr =[self.ds firstObject];
    
    if (arr.count>array.count) return;
    
    for (int i=0; i<arr.count; i++) {
        AddPriceModel *model = arr[i];
        NSDictionary *dic =array[i];
        NSInteger salePrice = [dic[@"actorPrice"]integerValue];
        if (salePrice>0) {
            model.price =[dic[@"actorPrice"]floatValue];
        }else{
            model.price =[dic[@"examPrice"]floatValue];
        }
        
        
        
    }
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
}
@end
