//
//  ZTPropertyFeatureView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 27.10.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import AdjustableVisualEffectView

@IBDesignable class ZTPropertyFeatureView: UIView {
    
    fileprivate var _title : String?
    @IBInspectable var title : String? {
        set {
            if newValue != _title {
                featureTitleLabel.text = newValue
                
                _title = newValue
            }
        }
        
        get {
            return _title
        }
    }
    
    fileprivate var _value   : String?
    @IBInspectable var value : String? {
        set {
            if newValue != _value {
                featureValueLabel.text = newValue
                
                _value = newValue
            }
        }
        
        get {
            return _value
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet(newValue) {
            if newValue != nil {
                contentView?.backgroundColor = newValue
            }
        }
    }
    
    override var tintColor: UIColor! {
        didSet(newValue) {
            contentView?.tintColor = newValue
        }
    }
    
    var contentView : UIView!
    
    @IBOutlet var featureTitleLabel  : UILabel!
    @IBOutlet var featureValueLabel  : UILabel!
    @IBOutlet var blurBackgroundView : AdjustableVisualEffectView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func loadFromNib() -> UIView {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: ZTPropertyFeatureView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func setup() {
        contentView = loadFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                        UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(contentView)
    }
    
    //MARK: - Public
    public func fill(title: String, value: String) {
        featureTitleLabel.text = title
        featureValueLabel.text = value
    }
}
