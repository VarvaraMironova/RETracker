//
//  NotificationViewController.swift
//  ZTNorificationContent
//
//  Created by Varvara Myronova on 13.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import ZTModels

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    weak private var rootView: ZTNotificationView? {
        return viewIfLoaded as? ZTNotificationView
    }
    
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        let userInfo = content.userInfo

        if let notificationData = userInfo["notification"] as? Data {
            let decoder = JSONDecoder()

            if let notification = try? decoder.decode(ZTNotification.self, from: notificationData), let rootView = rootView {
                rootView.fill(notification: notification)
            }
        }
    }

}
