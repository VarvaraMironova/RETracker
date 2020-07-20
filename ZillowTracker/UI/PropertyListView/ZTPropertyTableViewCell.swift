//
//  ZTPropertyTableViewCell.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTPropertyTableViewCell: UITableViewCell {
    @IBOutlet var blurView          : UIVisualEffectView!
    @IBOutlet var titleLabel        : UILabel!
    @IBOutlet var infoLabel         : UILabel!
    @IBOutlet var gradeLabel        : UILabel!
    @IBOutlet var propertyImageView : UIImageView!
    
    func fillWithModel(model: ZTEvaluatedModel) {
        let house = model.model
        titleLabel.text = "$\(house.price ?? 0)"
        gradeLabel.text = String(Int(model.grade))
        var text = "Bedrooms :  \(house.beds ?? 0) \nBathrooms:  \(house.baths ?? 0)"
        
        if let area = house.area {
            text.append("\n\nSize:  \(area.size) \(area.units ?? "sqft")")
        }
        
        if let lot = house.lot {
            text.append("\nLot  :  \(lot.size)  \(lot.units ?? "sqft")")
        }
        
        infoLabel.text = text
        
        if let imagePath = house.thumbnail {
            propertyImageView.imageFromUrl(urlString: imagePath)
        }
    }

}
