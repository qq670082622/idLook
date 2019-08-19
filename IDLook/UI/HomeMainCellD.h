//
//  HomeMainCellD.h
//  IDLook
//
//  Created by Mr Hu on 2018/9/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeMainCellD : UITableViewCell<UIScrollViewDelegate>

@property(nonatomic,copy)void(^clickUserInfo)(void);  //点击头像进入用户主页
@property(nonatomic,copy)void(^lookUserOffer)(void);  //查看报价
@property(nonatomic,copy)void(^playVideWithUrl)(WorksModel *workModel,NSInteger videoPage);  //播放视频

@property(nonatomic,copy)void(^endDeceleratingBlock)(void);  //停止滑动
@property(nonatomic,copy)NSString *typeContent;

-(void)reloadUIWithModel:(UserInfoM *)model withSelect:(NSString*)select;

@end


@interface HomeMainSubV : UIView

-(void)reloadUIWithModel:(WorksModel*)model;

@end
