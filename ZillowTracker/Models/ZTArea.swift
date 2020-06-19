//
//  ZTArea.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 6/2/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

extension ZTArea {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let size = try container.decodeIfPresent(Int64.self, forKey: .size) ?? 0
        let units = try container.decodeIfPresent(String.self, forKey: .units)
        
        self.init(size:size, units:units)
    }
}

struct ZTArea: Decodable {
    var size  : Int64 = 0
    var units : String?
    
    enum CodingKeys: String, CodingKey {
        case size  = "size"
        case units = "units"
    }
    
}
