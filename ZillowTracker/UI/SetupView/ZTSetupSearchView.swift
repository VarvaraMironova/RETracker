//
//  ZTSetupSearchView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 11.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

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
        priceSlider.maximumValue = Float(ZTConstants.maxPrice)
        priceSlider.minimumValue = Float(ZTConstants.minPrice)
        priceSlider.value = Float(ZTConstants.defaultPrice)
        
        //setup labels
        minPriceLabel.text = ZTConstants.minPrice.formattedWithSeparator
        maxPriceLabel.text = ZTConstants.defaultPrice.formattedWithSeparator
    }
    
    func setupDefaultPickerView() {
        if let defaultZipIndex = ZTConstants.zips.firstIndex(of: ZTConstants.defaultZip) {
            zipPickerView.selectRow(defaultZipIndex, inComponent: 0, animated: false)
        }
    }
    
    func updateSubviewsWhileLoading(loadingFinished: Bool) {
        performSearchButton.isEnabled = loadingFinished
        
        if loadingFinished {
            activityIndicator.stopAnimating()
            bringSubviewToFront(performSearchButton)
        } else {
            activityIndicator.startAnimating()
            bringSubviewToFront(loadingContainer)
        }
    }
    
}
