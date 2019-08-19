/*
 @header  LoginCellModel.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/15
 @description
 
 */

#import "LoginCellModel.h"

@implementation LoginCellModel

/**
 获取登录数据
 @return 数组
 */
+(NSArray*)getLoginDataSource
{
    NSArray *array =@[@{@"image":@"icon_phone",@"placeholder":@"请输入手机号",@"cellType":@(LRCellTypePhone)},
                      @{@"image":@"icon_password",@"placeholder":@"请输入密码",@"cellType":@(LRCellTypePassword)}];
    
    NSMutableArray *dataSource =[NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
        LoginCellStrutM *model = [[LoginCellStrutM alloc]initWithDic:array[i]];
        [dataSource addObject:model];
    }
    return dataSource;
}

/**
 获取注册数据
 @return 数组
 */
+(NSArray*)getReginDataSource
{
    NSArray *array =@[@{@"image":@"icon_phone",@"placeholder":@"请输入手机号",@"cellType":@(LRCellTypePhone)},
                      @{@"image":@"icon_ code",@"placeholder":@"请输入验证码",@"cellType":@(LRCellTypeVerificationCode)},
                      @{@"image":@"icon_password",@"placeholder":@"请输入密码",@"cellType":@(LRCellTypePassword)},
                      @{@"image":@"icon_password",@"placeholder":@"请再次输入密码",@"cellType":@(LRCellTypePassword)},
                      @{@"userType":@(UserTypeResourcer),@"buyType":@(-1),@"cellType":@(LRCellTypeIdentity)}];
    
    NSMutableArray *dataSource =[NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
        LoginCellStrutM *model = [[LoginCellStrutM alloc]initWithDic:array[i]];
        [dataSource addObject:model];
    }
    return dataSource;
}

/**
 获取重置密码数据
 @return 数组
 */
+(NSArray*)getResetPswDataSource
{
    NSArray *array =@[@{@"image":@"icon_phone",@"placeholder":@"请输入手机号",@"cellType":@(LRCellTypePhone)},
                      @{@"image":@"icon_ code",@"placeholder":@"请输入验证码",@"cellType":@(LRCellTypeVerificationCode)},
                      @{@"image":@"icon_password",@"placeholder":@"请输入新密码",@"cellType":@(LRCellTypePassword)},
                      @{@"image":@"icon_password",@"placeholder":@"请再次输入密码",@"cellType":@(LRCellTypePassword)}];
    
    NSMutableArray *dataSource =[NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
        LoginCellStrutM *model = [[LoginCellStrutM alloc]initWithDic:array[i]];
        [dataSource addObject:model];
    }
    return dataSource;
}

/**
 获取更换手机号第一步数据
 @return 数组
 */
+(NSArray*)getChangeMobileStep1DataSource
{
    NSArray *array =@[ @{@"image":@"icon_phone",@"placeholder":@"请输入旧手机号",@"cellType":@(LRCellTypePhone)},
                       @{@"image":@"icon_ code",@"placeholder":@"请输入验证码",@"cellType":@(LRCellTypeVerificationCode)}];
    
    NSMutableArray *dataSource =[NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
        LoginCellStrutM *model = [[LoginCellStrutM alloc]initWithDic:array[i]];
        [dataSource addObject:model];
    }
    return dataSource;
}

/**
 获取更换手机号地二步数据
 @return 数组
 */
+(NSArray*)getChangeMobileStep2DataSource
{
    NSArray *array =@[ @{@"image":@"icon_phone",@"placeholder":@"请输入新手机号",@"cellType":@(LRCellTypePhone)},
                       @{@"image":@"icon_ code",@"placeholder":@"请输入验证码",@"cellType":@(LRCellTypeVerificationCode)},];
    
    NSMutableArray *dataSource =[NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
        LoginCellStrutM *model = [[LoginCellStrutM alloc]initWithDic:array[i]];
        [dataSource addObject:model];
    }
    return dataSource;
}

@end


@implementation LoginCellStrutM

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.imageN = (NSString *)safeObjectForKey(dic, @"image");
        self.placeholder = (NSString *)safeObjectForKey(dic, @"placeholder");
        self.content = (NSString *)safeObjectForKey(dic, @"content");
        self.cellType =[(NSNumber *)safeObjectForKey(dic, @"cellType") integerValue];
        self.userType =[(NSNumber *)safeObjectForKey(dic, @"userType") integerValue];
        self.buyType =[(NSNumber *)safeObjectForKey(dic, @"buyType") integerValue];
    }
    return self;
}

@end
