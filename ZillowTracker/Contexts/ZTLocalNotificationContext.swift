//
//  ZTLocalNotificationContext.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/31/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import UserNotifications

class ZTLocalNotificationContext: NSObject {
    private var notifications = [ZTNotification]()
    
    init(properties: [ZTEvaluatedModel]) {
        for property in properties {
            let notification = ZTNotification(evaluatedHouse: property)
            
            notifications.append(notification)
        }
    }
    
    private func requestPermission(completion: @escaping (Bool) -> Void) -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                completion(granted)
        }
    }
    
    private func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
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
