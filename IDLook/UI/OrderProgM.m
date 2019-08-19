//
//  OrderProgM.m
//  IDLook
//
//  Created by HYH on 2018/6/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderProgM.h"

@implementation OrderProgM

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [NSMutableArray new];
    }
    return _ds;
}

-(void)refreshDataWithModel:(OrderModel*)model
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dicArg = @{@"orderid":model.orderId};
    [AFWebAPI getOrderProgress:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array= [object objectForKey:JSON_data];
            [self analyzeProgressWithArray:array withModel:model];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
    
    [self analyzeProgressWithArray:nil withModel:model];
}

-(void)analyzeProgressWithArray:(NSArray*)array withModel:(OrderModel*)model
{
    [self.ds removeAllObjects];
    NSArray *arr;
    if (model.ordertype==OrderTypeAudition)
    {
        if (model.auditionType == 0) {
            arr = @[@{@"title":@"订单提交成功",@"state":@"new"},@{@"title":@"已接受",@"state":@"acceptted"},@{@"title":@"订单已支付",@"state":@"paied"},@{@"title":@"试镜视频已上传",@"state":@"videouploaded"},@{@"title":@"订单已完成",@"state":@"finished"}];
        }
        else if (model.auditionType==2)
        {
            arr = @[@{@"title":@"订单提交成功",@"state":@"new"},@{@"title":@"已接受",@"state":@"acceptted"},@{@"title":@"订单已支付",@"state":@"paied"},@{@"title":@"订单已完成",@"state":@"finished"}];
        }
    }
    if (model.ordertype==OrderTypeShot)
    {
        if (model.ordersubtype==1) {
            arr = @[@{@"title":@"订单提交成功",@"state":@"new"},@{@"title":@"艺人已报价",@"state":@"pricereport"},@{@"title":@"商家已同意报价",@"state":@"priceok"},@{@"title":@"订单已付首款",@"state":@"paiedone"},@{@"title":@"上传授权书",@"state":@"certupload"},@{@"title":@"订单已付尾款",@"state":@"paiedtwo"},@{@"title":@"订单已完成",@"state":@"finished"}];
        }
        else
        {
            arr = @[@{@"title":@"订单提交成功",@"state":@"new"},@{@"title":@"艺人已接受订单",@"state":@"acceptted"},@{@"title":@"订单已付首款",@"state":@"paiedone"},@{@"title":@"上传授权书",@"state":@"certupload"},@{@"title":@"订单已付尾款",@"state":@"paiedtwo"},@{@"title":@"订单已完成",@"state":@"finished"}];
        }

    }
    

    if ([model.orderstate isEqualToString:@"rejected"])
    {
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            arr = @[@{@"title":@"订单提交成功",@"state":@"new"},@{@"title":@"订单已拒绝",@"state":@"rejected"}];
        }
        else
        {
            arr = @[@{@"title":@"订单提交成功",@"state":@"new"},@{@"title":@"订单被拒绝",@"state":@"rejected"}];
        }
    }
    
    if ([model.orderstate isEqualToString:@"pricereject"])
    {
        arr = @[@{@"title":@"订单提交成功",@"state":@"new"},@{@"title":@"已报价",@"state":@"pricereport"},@{@"title":@"商家已拒绝报价",@"state":@"pricereject"}];
    }
    
    for (int i =0; i<arr.count; i++) {
        NSDictionary *dic = arr[i];
        OrderProgStructM *strucM = [[OrderProgStructM alloc]init];
        strucM.title=dic[@"title"];
//        strucM.content=@"请在签约后24小时内支付50%预付款，否则下单失效。";
        strucM.state =dic[@"state"];
        CGFloat headH = 0.0;
        
        strucM.progress=0;
        headH=20.0;
        
        strucM.height=[self heighOfString:strucM.content font:[UIFont systemFontOfSize:13.0] width:UI_SCREEN_WIDTH-50]+40+headH;
        
        [self.ds addObject:strucM];
    }
    
    for (int i =0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        for (int j=0; j<self.ds.count; j++) {
            OrderProgStructM *strucM = self.ds[j];
            if ([dic[@"state"] isEqualToString:strucM.state]) {
                strucM.progress=1;
                strucM.time=dic[@"date"];
                strucM.height=strucM.height+20;
            }
        }
    }
    
    if (self.newDataNeedRefreshed) {
        self.newDataNeedRefreshed();
    }
}





//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 5;
    contentLab.textInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    if (size.height==0) {
        return 20.0;
    }
    
    return ceilf(size.height)<40.0?40.0:ceilf(size.height+10);
}



@end


@implementation OrderProgStructM

@end
