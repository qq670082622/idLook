//
//  EditStructM.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditStructM.h"

@implementation EditStructM

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.title = (NSString*)safeObjectForKey(dic, @"title");
        self.content = (NSString*)safeObjectForKey(dic, @"content");
        self.placeholder = (NSString*)safeObjectForKey(dic, @"placeholder");
        self.parameter = (NSString*)safeObjectForKey(dic, @"parameter");
        self.isShowArrow = [(NSNumber *)safeObjectForKey(dic, @"isShowArrow") integerValue];
        self.IsMustInput = [(NSNumber *)safeObjectForKey(dic, @"IsMustInput") integerValue];
        self.isEdit = [(NSNumber *)safeObjectForKey(dic, @"isEdit") integerValue];
        self.type = [(NSNumber *)safeObjectForKey(dic, @"type") integerValue];
    }
    return self;
}

@end
