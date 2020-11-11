//
//  ZTLoadingView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 22.10.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import AdjustableVisualEffectView

class ZTLoadingView : UIView {
    lazy var loadingImageView : UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        
        return imageView
    }()
    
    lazy var spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor.lightGray
        spinner.center = loadingImageView.center
        addSubview(spinner)
        
        return spinner
    }()
    
    lazy var blurView : AdjustableVisualEffectView = {
        let blurView = AdjustableVisualEffectView(frame : bounds)
        blurView.effect = UIBlurEffect(style: .light)
        blurView.intensity = 0.4
        addSubview(blurView)
        
        return blurView
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        
    }
    
    //MARK: - Public
    public func show(loadingImagePath: String) {
        spinner.startAnimating()
        loadingImageView.imageFromUrl(urlString: loadingImagePath)
    }
    
    public func show(placeholderName: String) {
        spinner.startAnimating()
        loadingImageView.image = UIImage(named: placeholderName)
    }
    
    public func hide() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
        loadingImageView.removeFromSuperview()
        removeFromSuperview()
    }
}
