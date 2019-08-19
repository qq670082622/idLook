//
//  CustomTextField.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CustomTextField.h"

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface CustomTextField ()
@property(nonatomic,assign)BOOL isHaveDian;
@end

@implementation CustomTextField

-(id)init
{
    if (self=[super init]) {
        self.delegate=self;
    }
    return self;
}

//控制清除按钮的位置
-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    if (self.isNormal) {
        return CGRectMake(bounds.origin.x + bounds.size.width - 60, bounds.origin.y, bounds.size.height, bounds.size.height);
    }
    return CGRectMake(bounds.origin.x + bounds.size.width - 30, bounds.origin.y, bounds.size.height, bounds.size.height);
}



////控制左视图位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.size.width-30, bounds.origin.y, bounds.size.width-250, bounds.size.height);
//    return inset;
//}

//控制显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//    
//}
////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.isNumber==YES)
    {
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            self.isHaveDian=NO;
        }
        if ([string length]>0){
            
            unichar single=[string characterAtIndex:0];//当前输入的字符
            
            if ((single >='0' && single<='9') || single=='.'){//数据格式正确
                //首字母不能为0和小数点
                if([textField.text length]==0)
                {
                    if(single =='.'){
                        [SVProgressHUD showImage:nil status:@"提示，第一个数字不能为小数点"];
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
//                    if (single =='0') {
//                        [SVProgressHUD showImage:nil status:@"提示，第一个数字不能为0"];
//                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
//                        return NO;
//                    }
                }
                if (single=='.'){//text中还没有小数点
                    if(!self.isHaveDian){
                        self.isHaveDian=YES;
                        return YES;
                    }else{
                        [SVProgressHUD showImage:nil status:@"提示，您已经输入过小数点了"];
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{//存在小数点
                    if (self.isHaveDian){
                        //判断小数点的位数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=(int)(range.location-ran.location);
                        if (tt <=2){
                            return YES;
                        }else{
                            [SVProgressHUD showImage:nil status:@"提示，您最多输入两位小数"];
                            return NO;
                        }
                    }
                    else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                [SVProgressHUD showImage:nil status:@"提示，您输入的格式不正确"];
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
            
        } else {
            return YES;
        }
    }
    if (self.isPasswordType) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    return YES;
}

@end
