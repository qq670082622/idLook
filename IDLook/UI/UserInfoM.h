//
//  UserInfoM.h
//  IDLook
//
//  Created by HYH on 2018/5/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoM : NSObject

@property (nonatomic,copy) NSString *UID;           //用户唯一标识
@property (nonatomic,copy) NSString *mobile;        //手机号码
@property (nonatomic,copy) NSString *pwd;           //密码（随机/自定义）

@property (nonatomic,assign) NSInteger type;           //身份
@property (nonatomic,assign) NSInteger identity;           //身份
@property (nonatomic,assign) NSInteger expert;        //是否是网红
@property (nonatomic,copy) NSString *head;          //头像
@property (nonatomic,copy) NSString *thumHead;      //缩略头像
@property (nonatomic,copy) NSString *nick;          //昵称
@property (nonatomic,copy) NSString *name;          //真实姓名
@property (nonatomic,assign) NSInteger sex;         //性别

@property (nonatomic,copy) NSString *region;           //所在地
@property (nonatomic,copy) NSString *address;          //通讯地址
@property (nonatomic,copy) NSString *postalcode;      //邮编
@property (nonatomic,copy) NSString *contactnumber1;    //联系电话1
@property (nonatomic,copy) NSString *contactnumber2;    //联系电话2
@property (nonatomic,copy) NSString *email;             //电子邮箱

/***********************艺人***************************************/
@property (nonatomic,assign) NSInteger height;      //身高
@property (nonatomic,assign) NSInteger weight;      //体重
@property (nonatomic,assign) NSInteger shoesize;      //鞋码
@property (nonatomic,assign) NSInteger waistline;      //腰围
@property (nonatomic,assign) NSInteger bust;      //胸围
@property (nonatomic,assign) NSInteger hipline;      //臀围

@property (nonatomic,copy) NSString *background;           //主页背景图
@property (nonatomic,copy) NSString *audit;               //审核头像
@property (nonatomic,copy) NSString *miniaudit;           //审核头像x缩略图
//@property (nonatomic,assign) NSInteger headstatus;        //头像审核状态

@property (nonatomic,assign)NSInteger occupation;             //职业
//@property (nonatomic,assign)NSInteger mastery;              //专精 3是外籍演员
@property (nonatomic,copy) NSString *academy;             //毕业院校
@property (nonatomic,copy) NSString *grade;               //年级
@property (nonatomic,copy) NSString *specialty;             //专业
@property (nonatomic,copy) NSString *brief;               //简介
@property (nonatomic,copy) NSString *representativework;  //代表作品
@property (nonatomic,assign)NSInteger ageidentity;  //所属身份年龄段  1:男 2:女 3:老 4:少
@property (nonatomic,copy) NSString *performtype;  //擅长表演类型
@property (nonatomic,copy) NSString *authorizedphoto;  //可开放微出境授权照片类型
@property (nonatomic,copy) NSString *authorizedvideo;  //可开放微出境授权视频类型

@property (nonatomic,copy)NSString *nationality;   //国籍
@property (nonatomic,copy)NSString *language;   //语言
@property (nonatomic,copy)NSString *birth;   //生日
@property (nonatomic,copy)NSString *localism;   //方言

@property (nonatomic,strong)NSArray *authorizationList;    //授权书列表

//@property (nonatomic,assign) NSInteger authentication;      //认证状态   0.未认证 1.已认证  2.认证失败  3.认证审核中

@property (nonatomic,assign) BOOL isCollection;  //是否收藏
@property (nonatomic,assign) BOOL isPraise;  //是否点赞
@property (nonatomic,assign) NSInteger praises;     //被点赞总次数

@property (nonatomic,assign) NSInteger sortKey;     //排序（更新时间）

@property (nonatomic,strong)NSArray *talentList;    //才艺作品list
@property (nonatomic,strong)NSArray *micromirror;    //微出境作品list
@property (nonatomic,strong)NSArray *exoticroom;    //试葩间list
@property (nonatomic,strong)NSArray *mordcardList;    //模特卡list

@property (nonatomic,copy) NSString *authorization1;  //脸探肖像合作授权书
@property (nonatomic,copy) NSString *authorization2;  //微出镜图片授权书
@property (nonatomic,copy) NSString *authorization3;  //微出镜视频授权书
@property (nonatomic,copy) NSString *authorization4;  //试葩间授权书

@property (nonatomic,assign)BOOL isChoose;    //是否选中，选择时用

@property (nonatomic,assign) NSInteger sortpage;     //分页（有分页时用）

@property (nonatomic,copy) NSString *weiboName;  //微博名
@property (nonatomic,assign)CGFloat weiboFans;    //微博粉丝数

@property (nonatomic,strong)NSArray *priceList;    //报价列表

@property (nonatomic,strong)NSArray *showlist;    //作品列表

@property (nonatomic,copy) NSString *bankcard;  //银行卡号
@property (nonatomic,copy) NSString *bankname;  //开户行
@property (nonatomic,copy) NSString *bankUser;  //银行户主

@property (nonatomic,copy) NSString *alipay;  //支付宝账号
@property (nonatomic,copy) NSString *alipayname;  //支付宝姓名

@property (nonatomic,assign) NSInteger unreadNo;     //未读系统消息

@property (nonatomic,strong)NSArray *performance;    //表演类型
@property (nonatomic,strong)NSArray *acqierement;    //才艺展示
@property (nonatomic,strong)NSArray *pastWorksImg;    //过往作品图片
@property (nonatomic,strong)NSArray *pastWorksVdo;    //过往作品视频

@property (nonatomic,copy) NSString *buyername;    //购买放昵称
@property (nonatomic,copy) NSString *companyname;  //公司名称

@property (nonatomic,strong)NSArray *creative;    //首页视频列表

@property (nonatomic,assign) NSInteger actorinfo;          //是否有个人中心   0
@property (nonatomic,assign) NSInteger modelcardType;      //是否有模特卡   1
@property (nonatomic,assign) NSInteger talentshowType;     //是否有作品   2
@property (nonatomic,assign) NSInteger micromirrorType;    //是否有微出境  3
@property (nonatomic,assign) NSInteger exoticroomType;     //是否有试葩间   4
@property (nonatomic,assign) NSInteger pastWorksImgType;   //是否有过往作品图片  5
@property (nonatomic,assign) NSInteger pastWorksVdoType;   //是否有过往作品视频  6
@property (nonatomic,assign) NSInteger acqierementType;    //是否有才艺展示   7
@property (nonatomic,assign) NSInteger quotationType;      //是否有报价    8

@property (nonatomic,assign) NSInteger internalagenttype;      //0:正常用户 1：外模 2：老人 3：小孩 4：中青年

@property (nonatomic,assign) NSInteger studio;      //1:工作室演员，没有或者为0则不是
@property (nonatomic,assign) NSInteger status;      //1开头表示用户状态;* 100正常，101注销，102待审核，104黑名单;2开头表示用户等级;* 200普通用户，201vip用户，202超级vip,
@property (nonatomic,assign) NSInteger vipLevel; //0=普通用户 301=电商vip
@property (nonatomic,assign) float discount;      //vip折扣率

@property (nonatomic,assign) CGFloat rate;      //组合报价折扣率
/***********************java版接口***************************************/
@property (nonatomic,assign) NSInteger actorAgeIdentity;//1=青年男;2=青年女;3=中年男;4=中年女;5=老年男;6=老年女;7=小男孩;8=小女孩
@property (nonatomic,copy) NSString *actorHeadMini;
@property (nonatomic,copy) NSString *actorHeadPorUrl;
@property (nonatomic,copy) NSString *actorName;
@property (nonatomic,copy) NSString *actorNickname;
@property (nonatomic,assign) NSInteger actorOccupation;//1=视频演员,2=平面演员,3=活动模特,4=舞蹈特技
@property (nonatomic,assign) NSInteger praise;//点赞次数
@property (nonatomic,assign) NSInteger collect;//收藏次数
@property (nonatomic,assign) NSInteger startPrice;//价格
@property (nonatomic,assign) NSInteger userId;//id
@property (nonatomic,copy) NSString *actorRegion;//所在地
@property (nonatomic,assign) NSInteger actorSex;//1男 2女
@property (nonatomic,assign) NSInteger actorStudio;//1:工作室演员，没有或者为0则不是
@property (nonatomic,assign) NSInteger authentication;//认证状态 默认为0未提交，1已审核，2审核失败，3.审核中
@property (nonatomic,copy) NSString *headAudit;
@property (nonatomic,copy) NSString *headMiniAudit;
@property (nonatomic,assign) NSInteger headstatus;//头像审核 1,待审核，2,审核成功，3,审核失败
@property (nonatomic,assign) NSInteger mastery;//1广告演员；2影视演员；3外模
@property (nonatomic,strong)NSArray *showList;//作品数组
- (id)initWithDic:(NSDictionary *)dic;

-(id)initJavaDataWithDic:(NSDictionary *)dic;

@end
