//
//  ZTSetupSearchView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 11.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTSetupSearchView: UIView {
    @IBOutlet var titleLabel          : UILabel!
    @IBOutlet var zipLabel            : UILabel!
    @IBOutlet var performSearchButton : UIButton!
    @IBOutlet var zipPickerView       : UIPickerView!
    @IBOutlet var priceSlider         : UISlider!
    @IBOutlet var priceTitleLabel     : UILabel!
    @IBOutlet var minPriceLabel       : UILabel!
    @IBOutlet var maxPriceLabel       : UILabel!
    @IBOutlet var loadingContainer    : UIView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //setup slider
        priceSlider.maximumValue = Float(ZTUIConstants.maxPrice)
        priceSlider.minimumValue = Float(ZTUIConstants.minPrice)
        
        //setup labels
        minPriceLabel.text = ZTUIConstants.minPrice.formattedWithSeparator
        maxPriceLabel.text = ZTUIConstants.defaultPrice.formattedWithSeparator
    }
    
    func setupFromSettings(settings: ZTSearchSettings) {
        if let index = ZTUIConstants.zips.firstIndex(of: settings.zip) {
            zipPickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
        priceSlider.value = Float(settings.maxPrice)
        maxPriceLabel.text = settings.maxPrice.formattedWithSeparator
    }
    
    func updateSubviewsWhileLoading(loadingFinished: Bool) {
        DispatchQueue.main.async { [unowned self] in
            if loadingFinished {
                self.activityIndicator.stopAnimating()
                self.loadingContainer.isHidden = true
                self.performSearchButton.alpha = 1.0
            } else {
                self.activityIndicator.startAnimating()
                self.loadingContainer.isHidden = false
                self.performSearchButton.alpha = 0.3
            }
        }
    }
    
}
