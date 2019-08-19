//
//  NoticeActorVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeActorVC : UIViewController
@property(nonatomic,strong)NSArray *effectOrders;
@property(nonatomic,strong)NSArray *effectActor;
@property(nonatomic,strong)NSDictionary *projectDic;
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,copy)NSString *projectStart;
@property(nonatomic,copy)NSString *projectEnd;
@end

NS_ASSUME_NONNULL_END
