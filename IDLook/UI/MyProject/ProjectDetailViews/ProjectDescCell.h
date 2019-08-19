//
//  ProjectDescCell.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//简介+图片上传

#import <UIKit/UIKit.h>
#import "ProjectModel2.h"
#import "ProjectModel.h"
#import "mediaModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ProjectDescCellDelegate <NSObject>
@optional
-(void)addAction;
-(void)delectWithRow:(NSInteger)row;
-(void)chekBigImageWithRow:(NSInteger)row;
@end
@interface ProjectDescCell: UITableViewCell
@property(nonatomic,assign)BOOL checkStyle;//查看模式不需要加图片的addcell,并使蒙层btn覆盖所有UI
@property(nonatomic,weak)id<ProjectDescCellDelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)reloadUIWithArray:(NSArray *)array withAssets:(NSArray *)assets;

@property(nonatomic,strong)ProjectModel2 *model;
@property(nonatomic,copy)void(^textViewChangeBlock)(NSString *text);
@property(nonatomic,copy)void(^textFieldChangeBlock)(NSString *text);
@end

NS_ASSUME_NONNULL_END
