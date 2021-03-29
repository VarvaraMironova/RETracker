//
//  ZTMapView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 13.11.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import MapKit
import AdjustableVisualEffectView

class ZTMapView: UIView {
    @IBOutlet var blurBackgroundView: AdjustableVisualEffectView!
    @IBOutlet var mapInfoView       : ZTMapInfoView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        overrideUserInterfaceStyle = .light        
    }

}
