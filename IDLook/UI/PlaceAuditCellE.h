//
//  PlaceAuditCellE.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

#define ScriptSubCellWidth (UI_SCREEN_WIDTH-4*10)/3

NS_ASSUME_NONNULL_BEGIN

@protocol PlaceAuditCellECDelegate <NSObject>
-(void)addVideAction;
-(void)delectActionWithRow:(NSInteger)row;
@end

@interface PlaceAuditCellE : UITableViewCell
@property(nonatomic,weak)id<PlaceAuditCellECDelegate>delegate;

-(void)reloadUIWithArray:(NSArray*)array withAssets:(NSArray*)assets;
@end


@protocol  ScriptSubCellADelegate <NSObject>
-(void)delectWorksWithRow:(NSInteger)row;
-(void)addWorksAction;
@end

@interface ScriptSubCellA : UICollectionViewCell
@property(nonatomic,weak)id<ScriptSubCellADelegate>delegate;
@property(copy,nonatomic)void(^photoCellClick)(NSInteger row);
-(void)reloadUIWithImage:(UIImage*)image withDeleBtn:(BOOL)hideDele withAdd:(BOOL)add withRow:(NSInteger)row withVideoDuration:(NSString *)duration;

@end

NS_ASSUME_NONNULL_END
