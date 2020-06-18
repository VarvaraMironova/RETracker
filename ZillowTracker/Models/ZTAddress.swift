//
//  ZTAddress.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 6/2/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

struct ZTAddress: Codable {
    var zip          : String?
    var city         : String?
    var streetLine   : String?
    var state        : String?
    var county       : String?
    var neighborhood : String?
    var lat          : Double?
    var long         : Double?
    
    enum CodingKeys: String, CodingKey {
        case zip          = "postal_code"
        case city         = "city"
        case streetLine   = "line"
        case state        = "state"
        case county       = "county"
        case neighborhood = "neighborhood_name"
        case lat          = "lat"
        case long         = "lon"
    }
    
}
