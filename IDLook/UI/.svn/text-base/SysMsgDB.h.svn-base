//
//  SysMsgDB.h
//  IDLook
//
//  Created by HYH on 2018/7/30.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysMsgDB : NSObject

+(SysMsgDB*)shareInstance;

-(void)initDB;


/**
 一条系统消息写进数据库
 @param dic 消息内容
 */
- (void) insertSysMsgList:(NSDictionary *)dic;


/**
 读取系统 消息
 @return 消息数组
 */
- (NSMutableArray *) loadSystemMsgWithPeerID:(NSString*)peerId;

@end
