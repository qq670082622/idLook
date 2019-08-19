//
//  PriceModel.m
//  IDLook
//
//  Created by HYH on 2018/7/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceModel.h"

@implementation PriceModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.type  = [(NSNumber *)safeObjectForKey(dic, @"adverttype") integerValue];
        self.subType  = [(NSNumber *)safeObjectForKey(dic, @"singletype") integerValue];
        self.price  = [(NSNumber *)safeObjectForKey(dic, @"singleprice") integerValue];
        self.creativeid  = [(NSNumber *)safeObjectForKey(dic, @"creativeid") floatValue];
     self.waitPrice = [(NSNumber *)safeObjectForKey(dic, @"waitPrice") integerValue];
        self.status =  [(NSNumber *)safeObjectForKey(dic, @"status") integerValue];
         self.examinestate =  [(NSNumber *)safeObjectForKey(dic, @"examinestate") integerValue];
        NSDictionary *dicA = [UserInfoManager getPublicConfig];

        NSArray *array;
        if (self.type==1) {
            array=dicA[@"adVideoType"];
        }
        else if (self.type==2) {
            array=dicA[@"adPrintType"];
        }
        else if (self.type==3) {
            array=dicA[@"adActivityType"];
        }
        
        for (int i =0; i<array.count; i++) {
            NSDictionary *dicB = array[i];
            NSInteger idType = [[dicB objectForKey:@"attrid"] integerValue];
            if (idType==self.subType) {
                self.title = dicB[@"attrname"];
            }
        }
    }
    return self;
}

@end
