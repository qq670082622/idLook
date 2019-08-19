//
//  HomeArtistCell.h
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface HomeArtistCell : UICollectionViewCell
@property(nonatomic,copy)void(^clickUserInfo)(void);  //点击头像进入用户主页
@property(nonatomic,copy)void(^lookUserOffer)(void);  //查看报价
-(void)reloadUIWithModel:(UserModel*)info;
@property(nonatomic,strong) UserModel *userModel;
@end
