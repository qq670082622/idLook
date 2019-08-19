//
//  UIColor+ColorChange.h
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)


/**
 将16进制色值转化为uicolor

 @param color <#color description#>
 @return <#return value description#>
 */
+(UIColor*)colorWithHexString:(NSString*)color;
@end
