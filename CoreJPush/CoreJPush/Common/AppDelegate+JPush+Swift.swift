//
//  AppDelegate+JPush.swift
//  CoreJPush
//
//  Created by 冯成林 on 16/1/28.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

}

extension AppDelegate{

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        // Required
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        // Required,For systems with less than or equal to iOS6
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        // IOS 7 Support Required
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.NewData)
        CoreJPush.sharedCoreJPush().didReceiveRemoteNotification(userInfo)
    }
    
}



