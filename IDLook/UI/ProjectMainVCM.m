//
//  ProjectMainVCM.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainVCM.h"

@implementation ProjectMainVCM

-(id)init
{
    if (self=[super init]) {
        [self getNewProjectWithProjectId:@""];
    }
    return self;
}

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)getNewProjectWithProjectId:(NSString *)projectId
{
    NSDictionary *dicArg = @{@"userId":[UserInfoManager getUserUID],
                             @"projectId":projectId
                             };
    [AFWebAPI_JAVA getViewNewProjectWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            NSArray *orderGroupList = (NSArray*)safeObjectForKey(dic, @"orderGroupList");
            [self.ds removeAllObjects];
            self.ds = [NSMutableArray arrayWithArray:orderGroupList];
            self.projectInfo=dic;
            if(self.newDataNeedRefreshed)
            {
                self.newDataNeedRefreshed();
            }
            
            NSLog(@"--%@",dic);
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

/**
 根据订单状态得到cell高度
 @param info 订单信息
 */
-(CGFloat)getCellHeightWithOrderInfo:(ProjectOrderInfoM*)info
{
    CGFloat height = 160;
    if (info.orderType==0) {  //询档
        if([info.subState isEqualToString:@"cancel"])
        {
            height=120;
        }
    }
    else if (info.orderType==3) { //试镜
        if([info.subState isEqualToString:@"finish"] || [info.subState isEqualToString:@"cancel"])
        {
            height=120;
        }
    }
    else if (info.orderType==7)  //锁档
    {
        if([info.subState isEqualToString:@"finish"] || [info.subState isEqualToString:@"cancel"])
        {
            height=120;
        }
    }
    else if (info.orderType==5)  //定妆
    {
        height=178;
    }
    else if (info.orderType==4)  //拍摄
    {
        height=120;
        if([info.subState isEqualToString:@"pay_done"])
        {
            height=160;
        }
    }
    else if (info.orderType==6)  //授权书
    {
        height=144;
    }
    return height;
}



@end
