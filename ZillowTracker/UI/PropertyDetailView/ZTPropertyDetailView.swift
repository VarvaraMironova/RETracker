//
//  ZTPropertyDetailView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 23.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels
import AdjustableVisualEffectView

class ZTPropertyDetailView: UIView {
    @IBOutlet var addressButton     : UIButton!
    @IBOutlet var viewInSafariButton: UIButton!
    @IBOutlet var backButton        : UIButton!
    
    @IBOutlet var addressView       : AdjustableVisualEffectView!
    @IBOutlet var priceView         : AdjustableVisualEffectView!
    @IBOutlet var mainFeaturesView  : AdjustableVisualEffectView!
    
    @IBOutlet var imagePreviewCollectionView: UICollectionView!
    
    @IBOutlet var typeFeatureView        : ZTPropertyFeatureView!
    @IBOutlet var yearBuitFeatureView    : ZTPropertyFeatureView!
    @IBOutlet var storiesFeatureView     : ZTPropertyFeatureView!
    @IBOutlet var lotFeatureView         : ZTPropertyFeatureView!
    @IBOutlet var HOAFeatureView         : ZTPropertyFeatureView!
    @IBOutlet var pricePerSQFTFeatureView: ZTPropertyFeatureView!
    
    var loadingView : ZTLoadingView?
    
    public func fill(property: ZTHouse) {
        let address = property.address.description
        addressView.fill(title: address)
        
        if let price = property.price, price > 0 {
            priceView.fill(title: "$\(price)")
        } else {
            priceView.fill(title: "Price unknown")
        }
        
        if let details = property.details {
            feelWithDetails(details: details)
        }
        
        if property.pricePerSquareFeet > 0 {
            pricePerSQFTFeatureView.fill(title: "Price per sqft:",
                                         value: "$\(String(property.pricePerSquareFeet))")
        }
        
        if let lot = property.lot, lot.size > 0 {
            lotFeatureView.fill(title: "Lot:", value: "\(lot.size) \(lot.units ?? "acr")")
        } else {
            lotFeatureView.fill(title: "Lot:", value: "--")
        }
        
        if let type = property.propertyType {
            typeFeatureView.fill(title: "Type: ",
                                 value: String(describing: type))
        }
        
        var mainFeaturesText = String()
        
        switch property.propertyType {
        case .farm, .land:
            if let lot = property.lot, lot.size > 0 {
                mainFeaturesText.append("\(String(lot.size)) \(lot.units ?? "acr")")
            } else {
                mainFeaturesText.append("-- acr")
            }
            
            break
            
        default:
            if let beds = property.beds, beds > 0 {
                mainFeaturesText.append("\(String(beds)) bd |")
            } else {
                mainFeaturesText.append("-- bd |")
            }
            
            if let baths = property.baths, baths > 0 {
                mainFeaturesText.append(" \(String(baths)) ba |")
            } else {
                mainFeaturesText.append(" -- ba |")
            }
            
            if let area = property.area,
               area.size > 0
            {
                mainFeaturesText.append(" \(String(area.size)) \(area.units ?? "sqft")")
            } else {
                mainFeaturesText.append(" -- sqft")
            }
        
            break
        }
        
        mainFeaturesView.fill(title: mainFeaturesText)
    }
    
    public func showLoadingView(placeholderPath:String) {
        //show loadingView in imagePreviewCollectionView's cell frame
        let frame = imagePreviewCollectionView.frame
        let size = CGSize(width  : frame.size.width - ZTUIConstants.minInterItemSpacingPhoto,
                          height : frame.size.height)
        let loadingViewFrame = CGRect(origin: frame.origin, size: size)
        let loadingView = ZTLoadingView(frame: loadingViewFrame)
        loadingView.loadingImageView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        addSubview(loadingView)
        
        loadingView.show(loadingImagePath: placeholderPath)
        self.loadingView = loadingView
    }
    
    public func hideLoadingView() {
        if let loadingView = loadingView {
            loadingView.hide()
            
            self.loadingView = nil
        }
    }
    
    public func feelWithDetails(details: ZTHouseDetails) {
        if let yearBuilt = details.yearBuilt {
            yearBuitFeatureView.fill(title: "Year Built:", value: String(yearBuilt))
        } else {
            yearBuitFeatureView.fill(title: "Year Built:", value: "--")
        }
        
        if let HOA = details.HOA {
            HOAFeatureView.fill(title: "HOA per month:", value: "$\(String(HOA))")
        } else {
            HOAFeatureView.fill(title: "HOA per month:", value: "--")
        }
        
        if let stories = details.stories, stories > 0 {
            storiesFeatureView.fill(title: "Stories:", value: String(stories))
        } else {
            storiesFeatureView.fill(title: "Stories:", value: "--")
        }
    }

}
