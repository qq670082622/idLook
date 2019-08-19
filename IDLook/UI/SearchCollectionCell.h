//
//  SearchCollectionCell.h
//  IDFace
//
//  Created by HYH on 2018/5/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define searchCellWidth  (UI_SCREEN_WIDTH-15*3)/2

@interface SearchCollectionCell : UICollectionViewCell

-(void)reloadUIWithInfo:(UserInfoM*)info;

@end
