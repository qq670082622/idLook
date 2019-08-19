/*
 @header  AuthModel.h
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/16
 @description
     认证model
 */

typedef NS_ENUM(NSInteger,AuthCellType)
{
    AuthCellTypeCustom=0,       //cell类型,图片类型
    AuthCellTypeArrow,     //有箭头
    AuthCellTypeImage      //图片
};

typedef NS_ENUM(NSInteger,AuthBasicType)
{
    AuthBasicTypeCustom,
    AuthBasicTypeRealName,          //真实姓名
    AuthBasicTypeCertificateNo,     //证件号
    AuthBasicTypeOccupation,       //所属职业
    AuthBasicTypeCompanyName,          //公司名称
    AuthBasicTypeLicensenumber,    //营业执照号
    AuthBasicTypeManageName,       //经办人姓名
    AuthBasicTypeCompanyType,             //公司类型
    AuthBasicTypeCertificateImage,     //证件号图片
    AuthBasicTypeLicenseImage,       //经办人图片

};


#import <Foundation/Foundation.h>


@interface AuthModel : NSObject

/**
 获取资源方认证数据
 @return 数据
 */
+(NSArray*)getResourceAuthDataSource;


/**
  获取购买方个人认证数据
 @return 数据
 */
+(NSArray*)getBuyerPersonDataSource;

/**
 获取购买方企业认证数据
 @return 数据
 */
+(NSArray*)getBuyerCompanyDataSource;

@end

@interface AuthStructModel : NSObject

/**
 标题
 */
@property(nonatomic,copy)NSString *title;

/**
 提示文字
 */
@property(nonatomic,copy)NSString *placeholder;

/**
 内容
 */
@property(nonatomic,copy)NSString *content;

/**
 cell类型
 */
@property(nonatomic,assign)AuthCellType cellType;

/**
 类型
 */
@property(nonatomic,assign)AuthBasicType type;

/**
 headview文字
 */
@property(nonatomic,copy)NSString *headTitle;

/**
 证件图片1
 */
@property(nonatomic,strong)UIImage *image1;

/**
 证件图片2
 */
@property(nonatomic,strong)UIImage *image2;

/**
 参数
 */
@property(nonatomic,copy)NSString *parameter;


-(id)initWithDic:(NSDictionary*)dic;

@end
