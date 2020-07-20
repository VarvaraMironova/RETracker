//
//  ZTVisualEffectView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 07.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

public class AdjustableVisualEffectView: UIVisualEffectView {
    /// Visual effect view customization with given effect and its intensity
    ///
    /// - Parameters:
    ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
    ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
    @IBInspectable var intensity: CGFloat = 0.2
    
    // MARK: Private
    private var animator: UIViewPropertyAnimator!
    
    // MARK: Initializations
    init(effect: UIVisualEffect, intensity: CGFloat) {
        self.intensity = intensity
        
        super.init(effect: nil)
         
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            self.effect = effect
        }
        
        animator.fractionComplete = intensity
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let initialEffect = effect
        self.effect = nil
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            self.effect = initialEffect
        }
        
        animator.fractionComplete = intensity
    }

}
