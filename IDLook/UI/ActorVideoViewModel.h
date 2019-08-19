//
//  ActorVideoViewModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActorVideoViewModel : NSObject
@property(nonatomic,copy)NSString *cateName;
@property(nonatomic,copy)NSString *cutVideo;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,assign)NSInteger downloads;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger plays;
@property(nonatomic,assign)NSInteger timeVideo;
@property(nonatomic,assign)NSInteger vtype;//1试戏 2过往 3模特

@end

NS_ASSUME_NONNULL_END
