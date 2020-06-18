//
//  ZTConstants.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

enum ZTConstants {
    static let zips = ["73301", "73344", "78701", "78702", "78703", "78704", "78705", "78708", "78709", "78710", "78711", "78712", "78713", "78714", "78715", "78716", "78717", "78718", "78719", "78720", "78721", "78722", "78723", "78724", "78725", "78726", "78727", "78728", "78729", "78730", "78731", "78732", "78733", "78734", "78735", "78736", "78737", "78738", "78739", "78741", "78742", "78744", "78745", "78746", "78747", "78748", "78749", "78750", "78751", "78752", "78753", "78754", "78755", "78756", "78757", "78758", "78759", "78760", "78761", "78762", "78763", "78764", "78765", "78766", "78767", "78768", "78769", "78772", "78773", "78774", "78778", "78779", "78780", "78781", "78783", "78785", "78789", "78799"]
    static let defaultZip   = "78750"
    static let minPrice     = 0
    static let maxPrice     = 1000000
    static let defaultPrice = 500000
    static let defaultSearchParameters = ["city": "Austin", "limit":"100", "offset":"0"]
    
    //realtor API constants
    static let defaultRealtorAPIHeaders = ["x-rapidapi-host": "realtor.p.rapidapi.com",
    "x-rapidapi-key": "263b6fe994msh72acb0d56a4cfe2p13c208jsn285920a55d4e"]
    static let realtorAPIForSale = "https://realtor.p.rapidapi.com/properties/v2/list-for-sale"
}
