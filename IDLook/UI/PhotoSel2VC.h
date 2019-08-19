//
//  PhotoSel2VC.h
//  miyue
//
//  Created by wsz on 16/5/3.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSel2VC : UIViewController

@property (nonatomic,copy)void(^doCancle)(void);
@property (nonatomic,copy)void(^doUpdata)(NSMutableArray *array);

- (id)initWithDic:(NSDictionary *)dic;


@end
