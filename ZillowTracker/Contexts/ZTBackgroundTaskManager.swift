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
            print(error)
        }
    }
    
    private func performBackgroundSearch(task: BGTask) {
        let searchSettings = ZTSearchSettings()
        let searchContext = ZTSearchPropertiesContext(searchSettings: searchSettings)
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
            searchContext.cancel()
        }
        
        searchContext.perform { (propertyList, error) in
            //schedule notifications
            if let propertyList = propertyList {
                let notificationContext = ZTLocalNotificationContext.init(properties: propertyList)
                notificationContext.run { (finished) in
                    if finished {
                        task.setTaskCompleted(success: true)
                    }
                }
            } else {
                task.setTaskCompleted(success: false)
            }
        }
        
        scheduleBackgroundSearch()
    }
}
