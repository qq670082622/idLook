//
//  AddPriceSubB.h
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPriceSubB : UIView
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *tipsLab;
-(void)reloadUIWithChange:(BOOL)isChange;
//@property(nonatomic,assign)NSInteger state;//1新增h审核 2删除审核 3修改审核 4正常

@end
