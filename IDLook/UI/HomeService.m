//
//  HomeService.m
//  IDLook
//
//  Created by HYH on 2018/5/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeService.h"
#import "HomeHeadView.h"
#import "HomeMainCellA.h"
#import "HomeMainCellD.h"
#import "PlayContinuePopV.h"
#import "UIImage+GIF.h"
#import "ActorCell.h"
#import "UserModel.h"
@interface HomeService ()

@end

@implementation HomeService

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     NSDictionary *configDic =   [UserInfoManager getPublicConfig];
     NSDictionary  *homePageInfo = configDic[@"homePageInfo"];
    BOOL enable =  YES;//[homePageInfo[@"EnableShotBroadcast"] boolValue];
    if ( [UserInfoManager getUserType] == 2) {//资源方   ，需要隐藏vip提示 4个新增按钮
        if (enable) {
             return 230;
        }else{
            return 141;
        }
       

    }else if ( [UserInfoManager getUserType] == 1){// 购买方 游客
        NSInteger status = [UserInfoManager getUserStatus];
        if (status>200) {
            return 216;
        }
        return  276;
    }else if ( [UserInfoManager getUserType] == 0){//游客
        return 352;
    }
    return 352;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dsm.ds.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340;// return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *identifer = @"HomeMainCellD";
//
//    HomeMainCellD *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
//    if(!cell)
//    {
//        cell = [[HomeMainCellD alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor=[UIColor clearColor];
//    }
//    if (tableView.animatedStyle != TABTableViewAnimationStart) {
//       __block  UserInfoM *info = self.dsm.ds[indexPath.row];
//        [cell reloadUIWithModel:info withSelect:@""];
//
//
//
//
//    WeakSelf(self);
//    WeakSelf(cell);
//    cell.clickUserInfo = ^{
//        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(didClickUser:withSelect:)]) {
//            [weakself.delegate didClickUser:info withSelect:weakcell.typeContent];
//        }
//    };
//    cell.lookUserOffer = ^{
//        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(lookUserPriceInfo:)]) {
//            [weakself.delegate lookUserPriceInfo:info];
//        }
//    };
//    cell.playVideWithUrl = ^(WorksModel *workModel,NSInteger videoPage) {
//
//        if ([[NetworkNoti shareInstance]getNetworkStatus]==AFNetworkReachabilityStatusReachableViaWWAN && [UserInfoManager getWWanAuthPlay]==NO) {
//            if ([UserInfoManager getAskEachTime]==YES) {
//                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(endDeceleratingPlay)]) {
//                    [weakself.delegate endDeceleratingPlay];
//                }
//
//                PlayContinuePopV *popV = [[PlayContinuePopV alloc]init];
//                [popV show];
//                popV.ContinueBlock = ^{
//                    if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playVideoWithModel:withIndexPath:andPage:)]) {
//                        [weakself.delegate playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
//                    }
//                };
//            }
//            else
//            {
//                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playVideoWithModel:withIndexPath:andPage:)]) {
//                    [weakself.delegate playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
//                }
//            }
//        }
//        else
//        {
//            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playVideoWithModel:withIndexPath:andPage:)]) {
//                [weakself.delegate playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
//            }
//        }
//    };
//    cell.endDeceleratingBlock = ^{
//        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(endDeceleratingPlay)]) {
//            [weakself.delegate endDeceleratingPlay];
//        }
//    };
//}
//    return cell;
   
    ActorCell *cell = [ActorCell cellWithTableView:tableView];
    WeakSelf(self);
    WeakSelf(cell);
    
    if (tableView.animatedStyle != TABTableViewAnimationStart) {
      __block  UserModel *userModel = self.dsm.ds[indexPath.row];
                cell.model = userModel;
        cell.index_row = indexPath.row;
        cell.clickUserInfo = ^{
              UserModel *info = self.dsm.ds[indexPath.row];//此处转info
             [weakself.delegate didClickUser:info withSelect:weakcell.typeContent andiIndexPath:indexPath];
        };
        cell.playVideWithUrl = ^(WorksModel *workModel, NSInteger videoPage){
            if ([[NetworkNoti shareInstance]getNetworkStatus]==AFNetworkReachabilityStatusReachableViaWWAN && [UserInfoManager getWWanAuthPlay]==NO) {
                if ([UserInfoManager getAskEachTime]==YES) {
                    if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(endDeceleratingPlay)]) {
                        [weakself.delegate endDeceleratingPlay];
                    }
                    
                    PlayContinuePopV *popV = [[PlayContinuePopV alloc]init];
                    [popV show];
                    popV.ContinueBlock = ^{
                        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playVideoWithModel:withIndexPath:andPage:)]) {
                            [weakself.delegate playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
                        }
                    };
                }
                else
                {
                    if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playVideoWithModel:withIndexPath:andPage:)]) {
                        [weakself.delegate playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
                    }
                }
            }
            else
            {
                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(playVideoWithModel:withIndexPath:andPage:)]) {
                    [weakself.delegate playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
                }
            }
        };
        cell.selectType =^(NSString *typeString){

        };
        cell.actionType = ^(NSString *type) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(actionType:andUserInfo:andIndexPath:)]) {
                [weakself.delegate actionType:type andUserInfo:userModel andIndexPath:indexPath];
            }
        };
        cell.lookPicture = ^(WorksModel *workModel, NSInteger index) {
//            NSMutableArray *dataS = [NSMutableArray new];
//            for (int i=0; i<userModel.showList.count; i++) {
//                NSDictionary *show = userModel.showList[i];
//
//            }
            [weakself.delegate lookPictureWithModel:workModel withIndexPath:indexPath andPage:index];
        };
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    HomeHeadView *headerView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 315)];
   WeakSelf(self);
    headerView.clickTypeBlock = ^(NSInteger type) {
        if ([weakself.delegate respondsToSelector:@selector(clickEntryVideoWithType:)]) {
            [weakself.delegate clickEntryVideoWithType:type];
        }
    };
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserModel *info = self.dsm.ds[indexPath.row];
    HomeMainCellD *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickUser:withSelect:andiIndexPath:)]) {
        [self.delegate didClickUser:info withSelect:cell.typeContent andiIndexPath:indexPath];
    }
}

-(void)entryMoreVideoPlayer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(entryMoreRecommend)]) {
        [self.delegate entryMoreRecommend];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollUpScreen)]) {
        [self.delegate scrollUpScreen];
    }
   
}
//停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *subViews = scrollView.subviews;
    for (id sub in subViews) {
        if ([sub isKindOfClass:[ActorCell class]]) {
            ActorCell *cell = (ActorCell *)sub;
            [cell reloadOtherVideoViews];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewEndScrollView)]) {
        [self.delegate scrollViewEndScrollView];
    }
}
//停止拖拽 手离开屏幕
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSArray *subViews = scrollView.subviews;
    for (id sub in subViews) {
        if ([sub isKindOfClass:[ActorCell class]]) {
            ActorCell *cell = (ActorCell *)sub;
            [cell reloadOtherVideoViews];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewEndScrollView)]) {
        [self.delegate scrollViewEndScrollView];
    }
}

@end
