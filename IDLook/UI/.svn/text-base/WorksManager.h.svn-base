//
//  WorksManager.h
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorksVCM.h"

@interface WorksManager : NSObject <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,copy)void(^chooseAction)(BOOL select,NSIndexPath *indexPath);

@property(nonatomic,copy)void(^playAction)(WorksModel *model);

@property(nonatomic,strong)WorksVCM *dataM;

@end
