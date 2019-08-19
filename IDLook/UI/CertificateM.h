//
//  CertificateM.h
//  IDLook
//
//  Created by HYH on 2018/6/1.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CerticateType)
{
    CerticateTypeCooperat,
    CerticateTypeMirrorPhoto,
    CerticateTypeMirrorVideo,
    CerticateTypeTrial
};

@interface CertificateM : NSObject

@property(nonatomic,assign)BOOL isExist;   //是否存在该授权书

@property(nonatomic,copy)NSString *imageUrl;  //url

@property(nonatomic,assign)NSInteger type;  //类型

@property(nonatomic,assign)NSInteger state;  //审核状态

@end
