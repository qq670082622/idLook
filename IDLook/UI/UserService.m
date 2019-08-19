//
//  UserService.m
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserService.h"
#import "NoDataFootV.h"
#import "UserInfoCellA.h"
#import "UserInfoCellB.h"
#import "UserInfoCellC.h"

@interface UserService ()
@end

@implementation UserService

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSArray *array = self.dataM.ds[self.selectIndex];
    if (array.count) {
        //当高度不足时，用headview填充，使其正常滑动
        CGFloat totalH = 0.0;
        totalH=totalH+array.count*208;
        
        CGFloat vHeight =  0.0;
        if ([UserInfoManager getUserType]==UserTypePurchaser) {
            vHeight =  (UI_SCREEN_HEIGHT-50-SafeAreaTopHeight-SafeAreaTabBarHeight_IphoneX-96);
        }
        else
        {
            vHeight =  (UI_SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaTabBarHeight_IphoneX-96);
        }
//        if (totalH<vHeight) {
//            return vHeight-totalH;
//        }
        return vHeight-208;
    }
    else
    {
        if ([UserInfoManager getUserType]==UserTypePurchaser) {
            return (UI_SCREEN_HEIGHT-50-SafeAreaTopHeight-SafeAreaTabBarHeight_IphoneX-96);
        }
        else
        {
            return  (UI_SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaTabBarHeight_IphoneX-96);
        }
    }
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 96;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataM.ds.count) {
        return [self.dataM.ds[self.selectIndex] count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 208;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataM.ds[self.selectIndex];
    UserInfoCellC *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UserInfoCellC alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"reuseIdentifier"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell reloadUIWithWorksModel:array[indexPath.row]];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSArray *array = self.dataM.ds[self.selectIndex];
    if (array.count==0) {
        static NSString *identifer = @"UITableViewHeaderFooterView";
        NoDataFootV *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
        if(!footerView)
        {
            footerView = [[NoDataFootV alloc] initWithReuseIdentifier:identifer];
            [footerView.backgroundView setBackgroundColor:[UIColor clearColor]];
        }
        [footerView reloadUI];
        return footerView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(lookWorkDetialWithIndex:)]) {
        [self.delegate lookWorkDetialWithIndex:indexPath.row];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrolloffY:)]) {
        [self.delegate scrolloffY:scrollView.contentOffset.y];
    }
}


@end
