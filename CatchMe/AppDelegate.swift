//
//  AppDelegate.swift
//  CatchMe
//
//  Created by 三谷昌平 on 2017/10/20.
//  Copyright © 2017年 CareQube Developers. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //ナビゲーションアイテムの色を変更
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        if #available(iOS 10.0, *) {
            
            //ios10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                if granted {
                    debugPrint("通知許可")
                    center.delegate = self
                    application.registerForRemoteNotifications()
                } else {
                    debugPrint("通知拒否")
                }
            })
            
        } else {
            // ios9
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        return true
    }

    //リモート通知
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // そのままだと「32bit」という文字列なので以下の処理を行います
        let deviceTokenString: String = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        print("deviceTokenString \(deviceTokenString)")
        print("test")
        //util.setUserDefaultsObject(value: deviceTokenString, key: udDeviceToken) // これは自前
    }

    //リモート通知を拒否したときの動作
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {1
        debugPrint("リモート通知の設定は拒否されました")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

