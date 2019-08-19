//
//  EditMainM.h
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditStructM.h"

extern NSString * const kEditInfoVCMCellClass;    //cell类名_键
extern NSString * const kEditInfoVCMCellHeight;   //cell高度_键
extern NSString * const kEditInfoVCMCellType;     //cell类型_键
extern NSString * const kEditInfoVCMCellName;     //标题
extern NSString * const kEditInfoVCMCellData;     //数据

typedef NS_ENUM(NSInteger,EditCellType)
{
    EditCellTypeBasicInfo,     //基本资料
    EditCellTypeSpecialty,     //专业信息
    EditCellTypeBrief,        //简介
    EditCellTypeAddress,      //联系地址
    EditCellTypeWorks,        //代表作品
    EditCellTypeCooperation,   //可合作内容
    EditCellTypeMirror,          //微出镜类别
    EditCellTypeModelCard         //形象展示
};


@interface EditMainM : NSObject

@property(nonatomic,copy)void(^reloadTableData)(void);

@property(nonatomic,strong)NSMutableArray *dataS;
@property(nonatomic,strong)NSMutableArray *titleArray;


/**
 刷新数据
 */
-(void)refreshEditInfo;

/**
 更新一条数据源
 @param indexPath 数据源
 @param content 内容
 */
-(void)reloadDataWithIndexPath:(NSIndexPath*)indexPath withContent:(NSString*)content;

@end
