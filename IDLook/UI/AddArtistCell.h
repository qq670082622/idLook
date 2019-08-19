//
//  AddArtistCell.h
//  IDLook
//
//  Created by HYH on 2018/6/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AddArtistCellWidth  (UI_SCREEN_WIDTH-15*3)/2


@interface AddArtistCell : UICollectionViewCell

-(void)reloadUIWithInfo:(UserInfoM*)info;

@end
