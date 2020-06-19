//
//  ZTPropertyTableViewCell.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTPropertyTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel        : UILabel!
    @IBOutlet var infoLabel         : UILabel!
    @IBOutlet var gradeLabel        : UILabel!
    @IBOutlet var propertyImageView : UIImageView!
    
    func fillWithModel(model: ZTEvaluatedModel) {
        let haus = model.model
        titleLabel.text = "$\(haus.price ?? 0)"
        gradeLabel.text = String(Int(model.grade))
        var text = "Bedrooms :  \(haus.beds ?? 0) \nBathrooms:  \(haus.baths ?? 0)"
        
        if let area = haus.area {
            text.append("\n\nSize:  \(area.size) sqft")
        }
        
        if let lot = haus.lot {
            text.append("\nLot  :  \(lot.size) sqft")
        }
        
        infoLabel.text = text
        
        if let imagePath = haus.thumbnail {
            propertyImageView.imageFromUrl(urlString: imagePath)
        }
    }

}
