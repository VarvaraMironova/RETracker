//
//  ZTUIConstants.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 17.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

enum ZTUIConstants {
    static let zips = ["73301", "73344", "78701", "78702", "78703", "78704", "78705", "78705", "78709", "78710", "78711", "78712", "78713", "78714", "78715", "78716", "78717", "78718", "78719", "78720", "78721", "78722", "78723", "78724", "78725", "78726", "78727", "78728", "78729", "78730", "78731", "78732", "78733", "78734", "78735", "78736", "78737", "78738", "78739", "78741", "78742", "78744", "78745", "78746", "78747", "78748", "78749", "78750", "78751", "78752", "78753", "78754", "78755", "78756", "78757", "78758", "78759", "78760", "78761", "78762", "78763", "78764", "78765", "78766", "78767", "78768", "78769", "78772", "78773", "78774", "78778", "78779", "78781", "78783", "78785", "78789", "78799"]
    static let defaultZip   = "78750"
    static let minPrice     = 0
    static let maxPrice     = 1000000
    static let defaultPrice = 500000
    
    static let maxPriceKey       = "price_max"
    static let zipKey            = "postal_code"
    
    static let errorDomain            = Bundle.main.bundleIdentifier
    static let errorDomain_undefined  = "undefinedErrorDomain"
    
    static let noResultsErrorCode     = 99
    static let cancelErrorCode        = -999
    
    static let errorMessageKey        = "message"
    static let errorTitleKey          = "title"
    static let noResultsErrorUserInfo = [errorTitleKey  : "No properties found",
                                        errorMessageKey : "Change search parameters and try again."]
    
    //Notifications
    static let bellSound     = "DoorBell.wav"
    static let knockingSound = "Knocking.mp3"
}
