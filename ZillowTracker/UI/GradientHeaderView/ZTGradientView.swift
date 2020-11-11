//
//  ZTGradientView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 30.10.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

@IBDesignable
public class ZTGradientView: UIView {
    @IBInspectable var startColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var endColor  : UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var startLocation: Double = 0.05 {
        didSet {
            updateLocations()
        }
    }
    
    @IBInspectable var endLocation : Double = 0.95 {
        didSet {
            updateLocations()
        }
    }
    
    @IBInspectable var horizontalMode: Bool = true {
        didSet {
            updatePoints()
        }
    }
    
    @IBInspectable var diagonalMode : Bool = false {
        didSet {
            updatePoints()
        }
    }

    lazy var gradientLayer: CAGradientLayer = {
        return layer as! CAGradientLayer
    }()
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

}
