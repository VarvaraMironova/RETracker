//
//  ZTNotification.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 6/9/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

struct ZTNotification {
    var identifier : String!
    var title      : String!
    var text       : String?
    var link       : URL?
    var imageURL   : URL?
    var grade      : Int8 = 0
    
    init(evaluatedHouse: ZTEvaluatedModel) {
        let house = evaluatedHouse.model
        
        identifier = house.identifier
        imageURL = URL(fileURLWithPath: house.link)
        title = "House for $\(house.price ?? 0)"
        text = "\(house.beds ?? 0) bedrooms; \(house.baths ?? 0) bathrooms;"
        
        if let area = house.area {
            text?.append("\nSize: \(area.size) sqft;")
        }
        
        if let lot = house.lot {
            text?.append("\nLot: \(lot.size) sqft;")
        }
        
        if let imagePath = house.thumbnail {
            imageURL = URL(fileURLWithPath: imagePath)
        }
    }
}
