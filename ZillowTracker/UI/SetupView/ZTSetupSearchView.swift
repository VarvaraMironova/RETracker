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
    @IBOutlet var zipTitleLabel       : UILabel!
    @IBOutlet var performSearchButton : UIButton!
    @IBOutlet var zipPickerView       : UIPickerView!
    @IBOutlet var priceSlider         : UISlider!
    @IBOutlet var priceTitleLabel     : UILabel!
    @IBOutlet var minPriceLabel       : UILabel!
    @IBOutlet var maxPriceLabel       : UILabel!
    @IBOutlet var loadingContainer    : UIView!
    @IBOutlet var activityIndicator   : UIActivityIndicatorView!
    
    @IBOutlet var backgroundSearchSwitch     : UISwitch!
    @IBOutlet var backgroundSearchLabel      : UILabel!
    @IBOutlet var apiTypeSegmentControl      : UISegmentedControl!
    @IBOutlet var propertyTypeSegmentControl : UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let settings = ZTSearchSettings()
        
        //setup slider and labels
        //priceSlider.setThumbImage(UIImage(named: "dollarIcon"), for: .normal)
        updatePriceSlider(settings: settings)
        
        //setup segment controls
        apiTypeSegmentControl.selectedSegmentIndex = settings.apiType == .forSale ? 0 : 1
        let key = NSAttributedString.Key.foregroundColor
        
        if let lightTextColor = UIColor(named: "color_textLight") {
            apiTypeSegmentControl.setTitleTextAttributes([key: lightTextColor], for: .selected)
            propertyTypeSegmentControl.setTitleTextAttributes([key: lightTextColor], for: .selected)
        }
        
        if let darkTextColor = UIColor(named: "color_textDark") {
            apiTypeSegmentControl.setTitleTextAttributes([key: darkTextColor], for: .normal)
            propertyTypeSegmentControl.setTitleTextAttributes([key: darkTextColor], for: .normal)
        }
        
        switch settings.propertyType {
        case .realEstate:
            propertyTypeSegmentControl.selectedSegmentIndex = 0
            break
        case .land:
            propertyTypeSegmentControl.selectedSegmentIndex = 1
            break
        default:
            propertyTypeSegmentControl.selectedSegmentIndex = 2
            break
        }
    }
    
    func updatePriceSlider(settings: ZTSearchSettings) {
        maxPriceLabel.fadeTransition(0.36)
        maxPriceLabel.text = settings.maxPrice.formattedWithSeparator
        let maxPriceRange = settings.maxPriceRange
        priceSlider.maximumValue = Float(maxPriceRange)
        priceSlider.value = Float(settings.maxPrice)
    }
    
    func updateZipPicker(settings: ZTSearchSettings) {
        if let index = settings.zips.firstIndex(of: settings.zip) {
            zipPickerView.selectRow(index,
                                    inComponent: 0,
                                    animated: false)
        }
    }
    
    func updateSubviewsWhileLoading(loadingFinished: Bool) {
        DispatchQueue.main.async { [unowned self] in
            if loadingFinished {
                self.activityIndicator.stopAnimating()
            } else {
                self.activityIndicator.startAnimating()
            }
            
            self.loadingContainer.isHidden = loadingFinished
        }
    }
    
}
