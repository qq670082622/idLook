//
//  WorkCellB.h
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkCellB : UICollectionViewCell
-(void)reloadUIWithModel:(WorksModel*)model;
@property(nonatomic,copy)void(^chooseAction)(BOOL select);
@property(nonatomic,copy)void(^playAction)(void);

@end
