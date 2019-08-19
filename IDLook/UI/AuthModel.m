/*
 @header  AuthModel.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/16
 @description
 
 */

#import "AuthModel.h"

@implementation AuthModel

+(NSArray*)getResourceAuthDataSource
{
    NSMutableArray *dataS =[NSMutableArray new];

    NSArray *array= @[@{@"title":@"有效证件号",@"content":@"",@"placeholder":@"请填写身份证/护照号",@"cellType":@(AuthCellTypeCustom),@"type":@(AuthBasicTypeCertificateNo)},
                       @{@"title":@"",@"content":@"身份证/护照正面",@"placeholder":@"身份证/护照背面",@"headTitle":@"上传身份证/护照的正反面",@"cellType":@(AuthCellTypeImage),@"type":@(AuthBasicTypeCertificateImage)}];
    
    for (int i=0; i<array.count; i++) {
        AuthStructModel *model = [[AuthStructModel alloc]initWithDic:array[i]];
        [dataS addObject:model];
    }
    
    return dataS;
}

/**
 获取购买方个人认证数据
 @return 数据
 */
+(NSArray*)getBuyerPersonDataSource
{
    NSMutableArray *dataS =[NSMutableArray new];
    
    NSArray *array= @[@{@"title":@"真实姓名",@"content":@"",@"placeholder":@"请填写身份证或护照姓名",@"cellType":@(AuthCellTypeCustom),@"type":@(AuthBasicTypeRealName)},
                       @{@"title":@"有效证件号",@"content":@"",@"placeholder":@"请填写身份证号/护照号",@"cellType":@(AuthCellTypeCustom),@"type":@(AuthBasicTypeCertificateNo)},
                       @{@"title":@"所属职业",@"content":@"",@"placeholder":@"请选择所属职业",@"cellType":@(AuthCellTypeArrow),@"type":@(AuthBasicTypeOccupation)},
                       @{@"title":@"",@"content":@"身份证/护照正面",@"placeholder":@"身份证/护照背面",@"headTitle":@"上传身份证/护照的正反面",@"cellType":@(AuthCellTypeImage),@"type":@(AuthBasicTypeCertificateImage)}];
    for (int i=0; i<array.count; i++) {
        AuthStructModel *model = [[AuthStructModel alloc]initWithDic:array[i]];
        [dataS addObject:model];
    }
    
    return dataS;

}

/**
 获取购买方企业认证数据
 @return 数据
 */
+(NSArray*)getBuyerCompanyDataSource
{
    NSMutableArray *dataS =[NSMutableArray new];
    NSArray *array= @[@{@"title":@"公司名称",@"content":@"",@"placeholder":@"请填写公司名称",@"cellType":@(AuthCellTypeCustom),@"type":@(AuthBasicTypeCompanyName)},
                       @{@"title":@"营业执照号",@"content":@"",@"placeholder":@"请填写营业执照号",@"cellType":@(AuthCellTypeCustom),@"type":@(AuthBasicTypeLicensenumber)},
                       @{@"title":@"公司类型",@"content":@"",@"placeholder":@"请选择公司类型",@"cellType":@(AuthCellTypeArrow),@"type":@(AuthBasicTypeCompanyType)},
                       @{@"title":@"经办人姓名",@"content":@"",@"placeholder":@"请填写经办人姓名",@"cellType":@(AuthCellTypeCustom),@"type":@(AuthBasicTypeManageName)},
                       @{@"title":@"有效证件号",@"content":@"",@"placeholder":@"请填写身份证号/护照号",@"cellType":@(AuthCellTypeCustom),@"type":@(AuthBasicTypeCertificateNo)},
                       @{@"title":@"",@"content":@"营业执照",@"placeholder":@"委托下单授权书",@"headTitle":@"上传营业执照及委托下单授权书",@"cellType":@(AuthCellTypeImage),@"type":@(AuthBasicTypeLicenseImage)},
                       @{@"title":@"",@"content":@"身份证/护照正面",@"placeholder":@"身份证/护照背面",@"headTitle":@"上传经办人身份证/护照的正反面",@"cellType":@(AuthCellTypeImage),@"type":@(AuthBasicTypeCertificateImage)}];
    for (int i=0; i<array.count; i++) {
        AuthStructModel *model = [[AuthStructModel alloc]initWithDic:array[i]];
        [dataS addObject:model];
    }
    return dataS;

}

@end


@implementation AuthStructModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.title = (NSString *)safeObjectForKey(dic, @"title");
        self.placeholder = (NSString *)safeObjectForKey(dic, @"placeholder");
        self.content = (NSString *)safeObjectForKey(dic, @"content");
        self.cellType =[(NSNumber *)safeObjectForKey(dic, @"cellType") integerValue];
        self.headTitle =(NSString *)safeObjectForKey(dic, @"headTitle");
        self.type =[(NSNumber *)safeObjectForKey(dic, @"type") integerValue];

    }
    return self;
}

@end
