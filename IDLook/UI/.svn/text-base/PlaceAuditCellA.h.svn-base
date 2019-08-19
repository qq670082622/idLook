//
//  PlaceAuditCellA.h
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceAuditCellADelegate <NSObject>

//添加艺人
-(void)addArtist;

//删除艺人
-(void)delectArtistWithIndex:(NSInteger)index;
@end

@interface PlaceAuditCellA : UITableViewCell
@property(nonatomic,weak)id<PlaceAuditCellADelegate>delegate;
-(void)reloadUIWithArray:(NSArray *)array;
@end

@interface PlaceAuditSubCellA : UITableViewCell
@property(nonatomic,copy)void(^ArtistDelect)(void);
-(void)reloadUIWithUserInfo:(UserInfoM*)info WithIndex:(NSInteger)index;
@end

