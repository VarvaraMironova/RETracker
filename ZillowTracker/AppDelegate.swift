//
//  AppDelegate.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //clean defaults
        #warning("remove if not needed!")
        //UserDefaults.standard.set(nil, forKey: "searchSettings")
        let backgroundTaskManager = ZTBackgroundTaskManager()
        //backgroundTaskManager.cancelBackgroundSearch()
        backgroundTaskManager.registerBackgroundSearch()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let backgroundTaskManager = ZTBackgroundTaskManager()
        backgroundTaskManager.scheduleBackgroundSearch()
    }

}

