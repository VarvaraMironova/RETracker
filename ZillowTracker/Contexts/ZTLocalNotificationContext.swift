//
//  ZTLocalNotificationContext.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/31/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import UserNotifications
import ZTModels

class ZTNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center                                : UNUserNotificationCenter,
                                willPresent notification                : UNNotification,
                                withCompletionHandler completionHandler : @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center                                : UNUserNotificationCenter,
                                didReceive response                     : UNNotificationResponse,
                                withCompletionHandler completionHandler : @escaping () -> Void)
    {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Open Action")
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")
        default:
            print("default")
        }
        
        completionHandler()
    }
}

class ZTLocalNotificationContext: NSObject {
    private var notifications = [ZTNotification]()
    
    var notificationDelegate : ZTNotificationDelegate?
    
    init(properties: [ZTEvaluatedModel]) {
        for property in properties {
            let notification = ZTNotification(evaluatedHouse: property)
            notifications.append(notification)
        }
    }
    
    private func requestPermission(completion: @escaping (Bool) -> Void) -> Void {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            completion(granted)
        }
        
        let delegate = ZTNotificationDelegate()
        center.delegate = delegate
        notificationDelegate = delegate
    }
    
    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            let soundName = UNNotificationSoundName.init(ZTUIConstants.bellSound)
            content.sound = UNNotificationSound(named: soundName)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
            let request = UNNotificationRequest(identifier: notification.identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                //print("Scheduling notification with id: \(notification.identifier ?? "someID")")
            }
        }
    }
    
    func run() {
        requestPermission { (granted) in
            if granted {
                self.scheduleNotifications()
            }
        }
    }

}
