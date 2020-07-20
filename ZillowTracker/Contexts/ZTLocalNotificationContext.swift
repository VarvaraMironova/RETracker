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

class ZTLocalNotificationContext: NSObject {
    private var notifications = [ZTNotification]()
    
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
    }
    
    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.categoryIdentifier = notification.category
            content.title = notification.title
            let soundName = UNNotificationSoundName.init(notification.soundName)
            content.sound = UNNotificationSound(named: soundName)
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(notification) {
                content.userInfo = ["notification" : data]
            }
            
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
