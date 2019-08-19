//
//  IDTypeModel.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDTypeModel : NSObject

+(NSArray*)getData;

@end

NS_ASSUME_NONNULL_END


@interface IDTypeStructModel : NSObject

/**
 是否展开
 */
@property(nonatomic,assign)BOOL isShowRow;

/**
 标题
 */
@property(nonatomic,copy)NSString *title;

/**
 子类型数组
 */
@property(nonatomic,strong)NSArray *array;

/**
 是否可展开
 */
@property(nonatomic,assign)BOOL isShowArrow;

@end
