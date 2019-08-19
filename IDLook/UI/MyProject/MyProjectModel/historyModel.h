//
//  historyModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/5/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface historyModel : NSObject
@property(nonatomic,strong) NSArray *changeDetailList;
@property(nonatomic,copy)NSString *changeTime;
@end

NS_ASSUME_NONNULL_END
