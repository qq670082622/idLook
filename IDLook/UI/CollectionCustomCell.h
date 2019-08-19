//
//  CollectionCustomCell.h
//  IDLook
//
//  Created by HYH on 2018/5/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CollectionCellWidth  (UI_SCREEN_WIDTH-15*3)/2

@interface CollectionCustomCell : UICollectionViewCell

@property(nonatomic,copy)void(^CollectionAction)(BOOL iscollection);

-(void)reloadUIWithInfo:(UserInfoM*)info;

@end
