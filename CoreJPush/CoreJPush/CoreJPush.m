//
//  CoreJPush.m
//  CoreJPush
//
//  Created by 冯成林 on 15/9/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreJPush.h"
#import "JPUSHService.h"
#import <UIKit/UIKit.h>


#define JPushAppKey @"da9152d6421af29ecf6f36aa"
#define JPushChannel @"AppStore"
#define JPushIsProduction NO

@interface CoreJPush ()

@property (nonatomic,strong) NSMutableArray *listenerM;

@property (nonatomic,copy) void(^ResBlock)(BOOL res, NSSet *tags,NSString *alias);

@end



@implementation CoreJPush
HMSingletonM(CoreJPush)


/** 注册JPush */
+(void)registerJPush:(NSDictionary *)launchOptions{
    
    // Required
    //可以添加自定义categories
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey channel:JPushChannel apsForProduction:JPushIsProduction];
    
}



/** 添加监听者 */
+(void)addJPushListener:(id<CoreJPushProtocol>)listener{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    
    if([jpush.listenerM containsObject:listener]) return;
    
    [jpush.listenerM addObject:listener];
}


/** 移除监听者 */
+(void)removeJPushListener:(id<CoreJPushProtocol>)listener{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    
    if(![jpush.listenerM containsObject:listener]) return;
    
    [jpush.listenerM removeObject:listener];
}


-(NSMutableArray *)listenerM{
    
    if(_listenerM==nil){
        _listenerM = [NSMutableArray array];
    }
    
    return _listenerM;
}


-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [self handleBadge:[userInfo[@"aps"][@"badge"] integerValue]];
    
    if(self.listenerM.count==0) return;
    
    [self.listenerM enumerateObjectsUsingBlock:^(id<CoreJPushProtocol> listener, NSUInteger idx, BOOL *stop) {
        
        if([listener respondsToSelector:@selector(didReceiveRemoteNotification:)]) [listener didReceiveRemoteNotification:userInfo];
    }];
}



/** 处理badge */
-(void)handleBadge:(NSInteger)badge{
    
    NSInteger now = badge-1;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    [UIApplication sharedApplication].applicationIconBadgeNumber=now;
    [JPUSHService setBadge:now];
}



+(void)setTags:(NSSet *)tags alias:(NSString *)alias resBlock:(void(^)(BOOL res, NSSet *tags,NSString *alias))resBlock{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];

    [JPUSHService setTags:tags alias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:jpush];
    
    jpush.ResBlock=resBlock;
}


-(void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias{

    if(self.ResBlock != nil) self.ResBlock(iResCode==0,tags,alias);
}


@end
