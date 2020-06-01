//
//  ZTHouse.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

struct ZTHouse : Hashable {
    static func == (lhs: ZTHouse, rhs: ZTHouse) -> Bool {
        return  lhs.address     == rhs.address &&
                lhs.zip         == rhs.zip &&
                lhs.identifier  == rhs.identifier &&
                lhs.beds        == rhs.beds &&
                lhs.baths       == rhs.baths &&
                lhs.area        == rhs.area &&
                lhs.price       == rhs.price &&
                lhs.lot         == rhs.lot
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(address)
        hasher.combine(zip)
        hasher.combine(identifier)
        hasher.combine(beds)
        hasher.combine(baths)
        hasher.combine(area)
        hasher.combine(price)
        hasher.combine(lot)
    }
    
    private var identifier : String?
    
    var address            : String?
    var zip                : UInt8?
    var beds               : UInt8?
    var baths              : UInt8?
    var area               : Float = 0.0
    var price              : Float = 0.0
    var lot                : Float = 0.0
    var pricePerSquareFeet : Float = 0.0
    
    init(data: NSDictionary) {
        if 0 != area {
            pricePerSquareFeet = price / area
        }
    }
}
