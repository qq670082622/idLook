//
//  AssetModel.m
//  IDLook
//
//  Created by HYH on 2018/7/24.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AssetModel.h"

@implementation AssetModel


-(NSString*)getOrderNameWithType:(NSInteger)type withPrice:(CGFloat)price
{
    NSString *str;
    if (type==1) {
        if (price>0) {
            str=@"微出镜收入";
        }
        else
        {
            str=@"微出镜支出";
        }
    }
    else if (type==2)
    {
        if (price>0) {
            str=@"试葩间收入";
        }
        else
        {
            str=@"试葩间支出";
        }
    }
    else if (type==3)
    {
        if (price>0) {
            str=@"试镜收入";
        }
        else
        {
            str=@"试镜支出";
        }
    }
    else if (type==4)
    {
        if (price>0) {
            str=@"拍摄收入";
        }
        else
        {
            str=@"拍摄支出";
        }
    }
    else if (type==5)
    {
        if (price>0) {
            str=@"肖像续约收入";
        }
        else
        {
            str=@"肖像续约支出";
        }
    }
    else if (type==100)
    {
        str=@"余额提现";
    }
    else if (type==101)
    {
        if (price>0) {
            str=@"违约金收入";
        }
        else
        {
            str=@"违约金支出";
        }
    }
    else if (type==102)
    {
        if (price>0) {
            str=@"违约金收入";
        }
        else
        {
            str=@"违约金支出";
        }
    }
    else if (type==200)
    {
        str=@"余额提现";
    }
    else
    {
        str=@"其他";
    }
    return str;
}

@end
