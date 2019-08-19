//
//  PriceMode.m
//  IDLook
//
//  Created by HYH on 2018/7/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceModel.h"

@implementation AddPriceModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.desc = (NSString *)safeObjectForKey(dic, @"attrname");
        self.eng = (NSString *)safeObjectForKey(dic, @"eng");
        self.ratio  = [(NSNumber *)safeObjectForKey(dic, @"ratio") floatValue];
    }
    return self;
}

@end
