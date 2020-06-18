//
//  ZTArea.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 6/2/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

struct ZTArea: Decodable {
    var size  : Int64 = 0
    var units : String?
    
    enum CodingKeys: String, CodingKey {
        case size  = "size"
        case units = "units"
    }
    
}
