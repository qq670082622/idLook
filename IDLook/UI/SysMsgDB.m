
//
//  SysMsgDB.m
//  IDLook
//
//  Created by HYH on 2018/7/30.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SysMsgDB.h"
#import "FMDB.h"

@interface SysMsgDB ()
@property(nonatomic,strong) FMDatabaseQueue *dbQueue;
@end

@implementation SysMsgDB

+(SysMsgDB*)shareInstance
{
    static dispatch_once_t once;
    static SysMsgDB *instance;
    dispatch_once(&once, ^ {
        instance = [[self alloc] init];
        [instance initDB];
    });
    return instance;
}

- (void) initDB
{
    NSString *userDBPath = [self getPath];
    NSString * databaseFileName = [NSString stringWithFormat:@"%@/%@.sqlite",userDBPath,@"sysmsgdbv2"];
    self.dbQueue =[FMDatabaseQueue databaseQueueWithPath:databaseFileName];
}

- (void)createChatMainTableSQLWithPeerID:(NSString*)peerId
{
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS SYSTEMMSG_%@ (MSGID TEXT PRIMARY KEY,"//PeerID消息id作主键
                            "PEERID TEXT,"              //用户ID
                            "CONTENT TEXT,"            //消息内容
                            "TITLE TEXT,"              //标题
                            "DATETIME TEXT,"           //时间
                            "URL TEXT,"               //图片url
                            "OBLII2 INTEGER,"
                            "OBLII3 INTEGER);",peerId];
    [self.dbQueue inDatabase:^(FMDatabase *db){
        if (![db open])
        {
            [db close];
            return;
        }
        [db executeUpdate:createSQL];
    }];
}


- (void) insertSysMsgList:(NSDictionary *) dic
{
    [self createChatMainTableSQLWithPeerID:dic[@"userid"]];
    
    NSString *  update=[NSString stringWithFormat: @"INSERT OR REPLACE INTO SYSTEMMSG_%@ (MSGID,"
                        "PEERID,"
                        "CONTENT,"
                        "TITLE,"
                        "DATETIME,"
                        "URL)"
                        "VALUES(?,?,?,?,?,?);",dic[@"userid"]];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         if (![db open])
         {
             [db close];
             return;
         }
         
         BOOL rt= [db executeUpdate:update,
                   dic[@"creativeid"],
                   dic[@"userid"],
                   dic[@"content"],
                   dic[@"title"],
                   dic[@"datetime"],
                   dic[@"url"]];
         if(rt)
         {
             NSLog(@"insert chat ok");
         }
         
     }];
}

- (NSMutableArray *) loadSystemMsgWithPeerID:(NSString*)peerId
{
    __block NSMutableArray * array = [[NSMutableArray alloc] init];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM SYSTEMMSG_%@ ORDER BY MSGID DESC",peerId];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         if (![db open])
         {
             [db close];
             return;
         }
         
         FMResultSet * rs= [db executeQuery:sql];
         while ([rs next])
         {
             NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
             [dic setObject:[rs stringForColumn:@"MSGID"] forKey:@"creativeid"];
             [dic setObject:[rs stringForColumn:@"PEERID"] forKey:@"userid"];
             [dic setObject:[rs stringForColumn:@"CONTENT"] forKey:@"content"];
             [dic setObject:[rs stringForColumn:@"DATETIME"] forKey:@"datetime"];
             [dic setObject:[rs stringForColumn:@"TITLE"] forKey:@"title"];
             [dic setObject:[rs stringForColumn:@"URL"] forKey:@"url"];
             [array addObject:dic];
         }
         [rs close];
         
     }];
    
    return array;
}

//数据库路径
- (NSString *)getPath
{
    NSString *AppMainDocumentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *relativePath = [NSString stringWithFormat:@"/DB/SysMsg"];
    
    NSString *folderPath = [AppMainDocumentPath stringByAppendingString:relativePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:folderPath];
    if (!fileExists)
    {
        //DNSLog(@"不存在,创建%@",relativePath);
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    else
    {
        //DNSLog(@"已经存在,%@",relativePath);
    }
    return folderPath;
}

@end
