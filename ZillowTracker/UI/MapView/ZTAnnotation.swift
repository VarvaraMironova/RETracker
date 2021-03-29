//
//  ZTAnnotation.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 13.11.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import MapKit
import ZTModels

class ZTAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    lazy var title: String? = {
        return "$\(String(property.price))"
    }()
    
    var property: ZTHouse
    
    init(evaluatedModel: ZTEvaluatedModel) {
        let property = evaluatedModel.model
        let address = property.address
        self.property = property
        self.coordinate = CLLocationCoordinate2D(latitude : address!.lat,
                                                 longitude: address!.long)
        
        super.init()
    }
    
}
