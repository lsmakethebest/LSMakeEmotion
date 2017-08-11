

//
//  CommonMacro.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


//随机颜色
#define RandomColor  [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

#define WeakSelf __weak typeof(self) weakSelf=self
//版本号
#define KCBundleVersion [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"]

//沙盒快速设置
#define TGUserDefaultSetObjectWithKey(obj,key)  [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];[[NSUserDefaults standardUserDefaults] synchronize]

//快速取出值
#define TGUserDefaultGetObjectForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

//通知中心
#define TGNotificationCenter [NSNotificationCenter defaultCenter]
#define TGKeyWindow  [UIApplication sharedApplication].windows.firstObject
//拨打电话
#define TGCallPhone(velue) [[UIApplication sharedApplication]openURL:[NSURL URLWithString:StringFormat(@"telprompt://",velue)]]

//快速拨打电话无弹窗
#define TGCallPhoneTel(velue) [[UIApplication sharedApplication]openURL:[NSURL URLWithString:StringFormat(@"tel://",velue)]]

//保存已选过的城市名称
#define  KCUserDefaultSetCityName(cityName) KCUserDefaultSetObjectWithKey(cityName,@"cityName")
#define  KCUserDefaultCityName KCUserDefaultGetObjectForKey(@"cityName")

//转字符串
#define StringFromInt(value) [NSString stringWithFormat:@"%d",value]
#define StringFromDouble(value) [[NSNumber numberWithDouble:value] stringValue]
#define StringFromInteger(value) [NSString stringWithFormat:@"%ld",value]


//身份
#define  KCUserDefaultSetIdentify(identify) KCUserDefaultSetObjectWithKey(identify,@"identify")
#define  KCUserDefaultIdentify KCUserDefaultGetObjectForKey(@"identify")

#define KCUserDefaultSync [[NSUserDefaults standardUserDefaults]synchronize]

//友盟token
#define  KCUserDefaultSetToken(token) KCUserDefaultSetObjectWithKey(token,@"umtoken")
#define  KCUserDefaultToken KCUserDefaultGetObjectForKey(@"umtoken")


#define KCPushWithClassString(value) [self.navigationController pushViewController:[[NSClassFromString((value)) alloc]init] animated:YES]


#define KCPopViewController [self.navigationController popViewControllerAnimated:YES]

//打电话
#define KCCall_Service_Phone  [[UIApplication sharedApplication]openURL:[NSURL URLWithString:StringFormat(@"telprompt://",KCCALL_PHONE_NUMBER)]]


// 系统版本
#define IOS_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]


// 屏幕尺寸
#define SCREEN_W    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H    ([UIScreen mainScreen].bounds.size.height)

// 类初始化
#define CLASS_INIT(x)     [[NSClassFromString(x) alloc] init]


// 字符串拼接
#define StringFormat(a,b) [NSString stringWithFormat:@"%@%@",a,b]
#define StringFormatThree(a,b,c) [NSString stringWithFormat:@"%@%@%@",a,b,c]
#define StringFormatFive(a,b,c,d,e) [NSString stringWithFormat:@"%@%@%@%@%@",a,b,c,d,e]



#define  MaxY(view)   CGRectGetMaxY(view.frame)
#define  MinY(view)   CGRectGetMinY(view.frame)

#define  MaxX(view)   CGRectGetMaxX(view.frame)
#define  MinX(view)   CGRectGetMinX(view.frame)


//判断是否是模拟器
#define kISSimulator  TARGET_IPHONE_SIMULATOR

//判断是否 Retina屏
#define kISRetina ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//判断设备的操做系统是不是ios7
#define kIOS7 (［[UIDevice currentDevice].systemVersion doubleValue] >= 7.0]


//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



#endif /* CommonMacro_h */
