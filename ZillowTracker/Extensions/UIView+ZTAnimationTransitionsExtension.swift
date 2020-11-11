//
//  UIView+ZTAnimationTransitionsExtension.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 28.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
