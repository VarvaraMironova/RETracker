//
//  AppDelegate.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_                              application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        //MARK:- Configure Firebase
        FirebaseApp.configure()
        
        //MARK:- Register Background Task
        let backgroundTaskManager = ZTBackgroundTaskManager()
        backgroundTaskManager.registerBackgroundSearch()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        ZTBackgroundTaskManager().scheduleBackgroundSearchIfNeeded()
    }

}

