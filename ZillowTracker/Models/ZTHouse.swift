//
//  ZTHouse.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

extension ZTHouse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let address = try container.decode(ZTAddress.self, forKey: .address)
        let link = try container.decode(String.self, forKey: .link)
        let beds = try container.decodeIfPresent(Int64.self, forKey: .beds)
        let baths = try container.decodeIfPresent(Int64.self, forKey: .baths)
        let price = try container.decodeIfPresent(Int64.self, forKey: .price)
        let area = try container.decodeIfPresent(ZTArea.self, forKey: .area)
        let lot = try container.decodeIfPresent(ZTArea.self, forKey: .lot)
        let propertyType = try container.decodeIfPresent(PropertyType.self, forKey: .propertyType)
        let thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        let lastUpdateString = try container.decodeIfPresent(String.self, forKey: .lastUpdate)
        let lastUpdate = lastUpdateString?.convertToDate()
        
        self.init(identifier:identifier, link:link, address:address, beds: beds, baths:baths, price:price, area: area, lot: lot, propertyType:propertyType, thumbnail: thumbnail, lastUpdate: lastUpdate)
  }
}

struct ZTHouse : Hashable, Decodable {
    var identifier         : String!
    var link               : String!
    var address            : ZTAddress!
    var beds               : Int64?
    var baths              : Int64?
    var price              : Int64?
    var area               : ZTArea?
    var lot                : ZTArea?
    var propertyType       : PropertyType?
    var thumbnail          : String?
    var lastUpdate         : Date?
    
    var pricePerSquareFeet : Double {
        get {
            if let area = area, let price = price, 0 != area.size {
                return Double(price / area.size)
            }
            
            return 0.0
        }
    }
    
//    enum PropertyStatus: String, Codable {
//        case forSale = ""
//        case pending
//    }
    
    enum PropertyType: String, Codable {
        case singleFamily = "single_family"
        case condo = "condo"
        case land = "land"
        case multyFamily = "multi_family"
    }
    
    enum CodingKeys: String, CodingKey {
        case identifier   = "property_id"
        case link         = "rdc_web_url"
        case address      = "address"
        case price        = "price"
        case baths        = "baths"
        case beds         = "beds"
        case area         = "building_size"
        case lot          = "lot_size"
        case propertyType = "prop_type"
        case thumbnail    = "thumbnail"
        case lastUpdate   = "last_update"
    }
    
    static func == (lhs: ZTHouse, rhs: ZTHouse) -> Bool {
        return  lhs.identifier  == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(beds)
        hasher.combine(baths)
        hasher.combine(price)
    }
}
