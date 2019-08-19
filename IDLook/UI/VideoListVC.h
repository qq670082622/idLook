//
//  VideoListVC.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoListVC : UIViewController

//所属年龄数组，masterType=1 广告演员， 时传参数 ，
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,assign)NSInteger subType; //类型第几个
@property(nonatomic,assign)NSInteger type;

/**
 专精类型
 */
@property(nonatomic,assign)NSInteger masteryType;

@end

NS_ASSUME_NONNULL_END
