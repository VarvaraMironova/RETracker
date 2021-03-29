//
//  ZTAnnotationView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 13.11.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import MapKit

class ZTAnnotationView: MKAnnotationView {
    private let maxContentWidth : CGFloat = 90.0
    
    private lazy var contentView   : UIView = {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: ZTAnnotationView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }()
    
    private let contentInsets = UIEdgeInsets(top    : 4.0,
                                             left   : 4.0,
                                             bottom : 4.0,
                                             right  : 4.0)
    
    @IBOutlet var titleLabel    : UILabel!
    @IBOutlet var pinImageView  : UIImageView!
    
    override var intrinsicContentSize: CGSize {
        var size = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width += contentInsets.left + contentInsets.right
        size.height += contentInsets.top + contentInsets.bottom
        
        return size
    }
        
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        canShowCallout = true
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                        UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(contentView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        pinImageView.image = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        if let annotation = annotation as? ZTAnnotation {
            titleLabel.text = annotation.title
        }
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        invalidateIntrinsicContentSize()

        frame.size = intrinsicContentSize
    }
    
}
