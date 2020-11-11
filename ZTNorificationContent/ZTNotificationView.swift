//
//  ZTNotificationView.swift
//  ZTNorificationContent
//
//  Created by Varvara Myronova on 15.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTNotificationView: UIView {
    @IBOutlet var backgroundView                : UIVisualEffectView!
    @IBOutlet var propertyImageView             : UIImageView!
    @IBOutlet var notificationDescriptionLabel  : UILabel!
    @IBOutlet var gradeLabel: UILabel!
    
    func fill(notification: ZTNotification) {
        if let imageURL = notification.imageURL {
            propertyImageView.imageFromUrl(urlString: imageURL)
        }
        
        gradeLabel.text = String(Int(notification.grade))
        notificationDescriptionLabel.text = notification.text
    }

}
