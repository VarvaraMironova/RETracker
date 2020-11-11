//
//  ZTBackgroundTaskManager.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 20.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import BackgroundTasks
import ZTModels
import FirebaseCrashlytics
import FirebaseAnalytics

class ZTBackgroundTaskManager: NSObject {
    
    public func registerBackgroundSearch() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: ZTContextConstants.backgroundTaskID,
            using: DispatchQueue.global()
        ) { task in
            self.performBackgroundSearch(task: task)
        }
    }
    
    public func cancelBackgroundSearch() {
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: ZTContextConstants.backgroundTaskID)
    }
    
    public func scheduleBackgroundSearchIfNeeded() {
        let searchSettings = ZTSearchSettings()
        
        if searchSettings.isBackgroundSearchOFF {
            cancelBackgroundSearch()
        } else {
            scheduleBackgroundSearch()
        }
    }
    
    private func scheduleBackgroundSearch() {
        do {
            let request = BGProcessingTaskRequest(identifier:  ZTContextConstants.backgroundTaskID)
            request.requiresExternalPower = false
            request.requiresNetworkConnectivity = true
            request.earliestBeginDate = Date().notificationDate(hrs: 2, mins: 0, secs: 0)
            try BGTaskScheduler.shared.submit(request)
        } catch {
            Crashlytics.crashlytics().setCustomValue("Scheduling a background task error", forKey: "bgTask_error")
        }
    }
    
    private func performBackgroundSearch(task: BGTask) {
        let searchContext = ZTSearchPropertiesContext()
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
            searchContext.cancel()
        }
        
        searchContext.perform { (propertyList, error) in
            //schedule notifications
            if let propertyList = propertyList {
                let notificationContext = ZTLocalNotificationContext(properties: propertyList)
                notificationContext.run { (finished) in
                    if finished {
                        task.setTaskCompleted(success: true)
                        
                        self.scheduleBackgroundSearch()
                    }
                }
            } else {
                task.setTaskCompleted(success: false)
                let settings = ZTSearchSettings()
                let parameters = [
                    AnalyticsParameterItemID      : "id-noPropertiesFound",
                    AnalyticsParameterItemName    : "noPropertiesFound",
                    "settings"                    : settings.description
                ]
                
                Analytics.logEvent(AnalyticsEventSelectContent,
                                   parameters: parameters)
                self.scheduleBackgroundSearch()
            }
        }
        
        scheduleBackgroundSearch()
    }
}
