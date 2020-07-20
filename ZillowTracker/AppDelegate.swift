//
//  AppDelegate.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //clean defaults
        #warning("remove if not needed!")
        //UserDefaults.standard.set(nil, forKey: "searchSettings")
        
        return true
    }

    func application(_ application                                      : UIApplication,
                     performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        print("performFetchWithCompletionHandler")
    }
}

