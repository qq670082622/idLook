//
//  WorksVCM.h
//  IDLook
//
//  Created by HYH on 2018/5/30.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorksVCM : NSObject

/**
 数据源
 */
@property (nonatomic,strong)NSMutableArray *ds;

/**
 选中的数据
 */
@property (nonatomic,strong)NSMutableArray *selectDatasource;

/**
 过往作品视频组数
 */
@property(nonatomic,assign)NSInteger pastworkVideoCount;

@property (nonatomic,copy)void(^refreshUIAction)(BOOL isAll);  //刷新一页数据还是全部刷新

- (void)refreshWorksInfo;

//编辑状态
-(void)getEditStateWithTag:(NSInteger)tag withEdit:(BOOL)edit;

//全选,取消
-(void)allChooseWithTag:(NSInteger)tag withSelect:(BOOL)select;

//改变一条数据
-(void)changeoneDataWithTag:(NSInteger)tag withIndaxPath:(NSIndexPath*)indexPath withSelect:(BOOL)select;

//是否全选中
-(BOOL)isAllChooseWithTag:(NSInteger)tag;

//删除作品或者微出镜，试葩间
-(void)delectWorksWithType:(NSInteger)type;

@end
