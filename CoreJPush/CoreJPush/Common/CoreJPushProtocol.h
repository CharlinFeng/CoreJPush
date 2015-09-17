//
//  CoreJPushProtocol.h
//  CoreJPush
//
//  Created by 冯成林 on 15/9/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

@protocol CoreJPushProtocol <NSObject>

@required
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;


@end