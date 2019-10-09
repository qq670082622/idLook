//
//  ActorTopModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActorTopModel : NSObject

@property(nonatomic,copy)NSString *videoSnapshotUrl;
@property(nonatomic,copy)NSString *topIcon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *userHeadPortrait;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,strong)NSArray *tags;
//@property(nonatomic,assign)NSInteger praiseCount;
//@property(nonatomic,assign)NSInteger attentionCount;
//@property(nonatomic,assign)NSInteger fansCount;
@property(nonatomic,assign)NSInteger index;
@end

NS_ASSUME_NONNULL_END
