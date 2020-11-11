//
//  ZTVisualEffectView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 07.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

enum AVStringAlignment: String {
    case natural   = "natural"
    case center    = "center"
    case right     = "right"
    case left      = "left"
    case justified = "justified"
}


@IBDesignable public class AdjustableVisualEffectView: UIView {
    //MARK:- VisualEffectView attributes
    /// Visual effect view customization with given effect and its intensity and fully customized text
    ///
    ///
    /// - Parameters:
    ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
    ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
    @IBOutlet var visualEffectView : UIVisualEffectView!
    
    fileprivate var _intensity          : CGFloat = 0.2
    @IBInspectable public var intensity : CGFloat {
        set {
            if newValue != _intensity {
                setupIntensity(intensity: newValue)
                _intensity = newValue
            }
        }
        
        get {
            return _intensity
        }
    }
    
    fileprivate var _effect : UIBlurEffect = UIBlurEffect(style: .light)
    public var effect       : UIBlurEffect {
        set {
            if newValue != _effect {
                visualEffectView.effect = newValue
                _effect = newValue
            }
        }
        
        get {
            return _effect
        }
    }
    
    //MARK:- TitleLabel attributes
    lazy public var titleLabel : UILabel = {
        var labelFrame = bounds
        let inset : CGFloat = 16.0
        labelFrame.size = CGSize(width  : bounds.size.width - inset,
                                 height : bounds.size.height)
        labelFrame.origin = CGPoint(x: bounds.origin.x + inset/2.0,
                                    y: bounds.origin.y)
        let label = UILabel(frame: labelFrame)
        label.textAlignment = .center
        label.textColor = textColor
        label.font = UIFont(name: fontName,
                            size: fontSize)
        label.numberOfLines = numberOfLines
        
        addSubview(label)
        
        return label
    }()
    
    fileprivate var _text         : String?
    @IBInspectable public var text: String? {
        set {
            if newValue != _text {
                titleLabel.text = newValue
                _text = newValue
            }
        }
        
        get {
            return _text
        }
    }
    
    fileprivate var _fontSize          : CGFloat = 18.0
    @IBInspectable public var fontSize : CGFloat {
        set {
            if newValue != _fontSize {
                let fontName = titleLabel.font.familyName
                titleLabel.font = UIFont(name: fontName, size: newValue)
                _fontSize = newValue
            }
        }
        
        get {
            return _fontSize
        }
    }
    
    fileprivate var _fontName          : String = "ZapfDingbats"
    @IBInspectable public var fontName : String {
        set {
            if newValue != _fontName {
                titleLabel.font = UIFont(name: newValue, size: fontSize)
                _fontName = newValue
            }
        }
        
        get {
            return _fontName
        }
    }
    
    fileprivate var _textColor          : UIColor = UIColor(named: "color_textLight")!
    @IBInspectable public var textColor : UIColor {
        set {
            if newValue != _textColor {
                titleLabel.textColor = newValue
                _textColor = newValue
            }
        }
        
        get {
            return _textColor
        }
    }
    
    fileprivate var _textAlignment : NSTextAlignment = .center {
        didSet(newValue) {
            titleLabel.textAlignment = newValue
        }
    }
    
    @IBInspectable public var textAlignment : Int {
        set(newValue) {
            if let alignment = NSTextAlignment(rawValue: newValue) {
                _textAlignment = alignment
            }
        }
        
        get {
            return _textAlignment.rawValue
        }
    }
    
    fileprivate var _numberOfLines          : Int = 1
    @IBInspectable public var numberOfLines : Int {
        set(newValue) {
            if newValue != _numberOfLines {
                titleLabel.numberOfLines = newValue
                _numberOfLines = newValue
            }
        }
        
        get {
            return _numberOfLines
        }
    }
    
    //MARK:- ContentView attributes
    fileprivate var _cornerRadius  : CGFloat = 0.0
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            if newValue != _cornerRadius {
                view.layer.cornerRadius = newValue
                view.clipsToBounds = true
                _cornerRadius = newValue
            }
        }
        
        get {
            return _cornerRadius
        }
    }
    
    public override var backgroundColor: UIColor? {
        willSet(newValue) {
            if newValue != backgroundColor {
                view.backgroundColor = backgroundColor
            }
        }
    }
    
    // MARK:- Private
    private var animator: UIViewPropertyAnimator!
    
    lazy private var view : UIView = {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: AdjustableVisualEffectView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }()
    
    // MARK:- Initializations    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
        
    private func setup() {
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                 UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }
    
    deinit {
        animator.stopAnimation(true)
        animator.finishAnimation(at: .current)
    }
    
    //MARK:- Public
    
    public func fill(title: String) {
        titleLabel.text = title
    }
    
    private func setupIntensity(intensity: CGFloat) {
        visualEffectView.effect = nil
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            visualEffectView.effect = effect
        }

        animator.fractionComplete = intensity
    }

}
