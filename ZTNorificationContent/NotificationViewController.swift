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

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    weak private var rootView: ZTNotificationView? {
        return viewIfLoaded as? ZTNotificationView
    }
    
    
    func didReceive(_ notification: UNNotification) {
        
    }

}
