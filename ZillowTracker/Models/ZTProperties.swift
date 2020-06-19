//
//  ZTProperties.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 6/2/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

extension ZTProperties {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let properties = try container.decodeIfPresent([ZTHouse].self, forKey: .properties)
        
        self.init(properties: properties)
  }
}

struct ZTProperties: Decodable {
    let properties  : [ZTHouse]?
    
    enum CodingKeys: String, CodingKey {
        case properties  = "properties"
    }
    
    func evaluate() -> [ZTEvaluatedModel] {
        var evaluatedPool = [ZTEvaluatedModel]()
        
        var pool = properties?.filter({ (house) -> Bool in
            if let lot = house.lot {
                return house.pricePerSquareFeet > 0 && lot.size > 0
            }
            
            return false
        })
        
        //evaluate by pricePerSquareFeet
        var maxPricePerSquareFeet : Double = 0.0
        var minPricePerSquareFeet : Double = 0.0
        
        pool?.sort(by: { (house1 : ZTHouse, house2 : ZTHouse) -> Bool in
            return house1.pricePerSquareFeet < house2.pricePerSquareFeet
        })
        
        if let mostExpensiveHouse = pool?.last {
            maxPricePerSquareFeet = mostExpensiveHouse.pricePerSquareFeet
        }
        
        if let cheapestHouse = pool?.first {
            minPricePerSquareFeet = cheapestHouse.pricePerSquareFeet
        }
        
        let deltaPricePerSquareFeet = (maxPricePerSquareFeet - minPricePerSquareFeet) / 100.0
        
        //evaluate by lotSize
        var maxLot : Int64 = 0
        var minLot : Int64 = 0
        pool?.sort(by: { (house1 : ZTHouse, house2 : ZTHouse) -> Bool in
            if let lot1 = house1.lot, let lot2 = house2.lot {
                return lot1.size < lot2.size
            }
            
            return false
        })
        
        if let biggestLot = pool?.last?.lot {
            maxLot = biggestLot.size
        }
        
        if let smalestLot = pool?.first?.lot  {
            minLot = smalestLot.size
        }
        
        let deltaLot = Double(maxLot - minLot) / 100.0
        
        if let pool = pool {
            let calendar = Calendar.current
            
            for house in pool {
                //filter old properties
                if let lastUpdate = house.lastUpdate {
                    if calendar.isDateInToday(lastUpdate) {
                        var gradeByPricePerSquareFeet : Double = 0.0
                        
                        if deltaPricePerSquareFeet != 0 {
                            gradeByPricePerSquareFeet = (maxPricePerSquareFeet - house.pricePerSquareFeet) / deltaPricePerSquareFeet
                        }
                        
                        var gradeByLot : Double = 0.0
                        if deltaLot != 0, let lot = house.lot {
                            gradeByLot = Double(maxLot - lot.size) / deltaLot
                        }
                        
                        //Weighting coefficient for price/sqft = 0.7
                        //Weighting coefficient for lot size   = 0.3
                        let grade = gradeByPricePerSquareFeet * ZTConstants.wcPricePerSquareFeet + gradeByLot * ZTConstants.wcLotSize
                        let evaluatedHouse = ZTEvaluatedModel(model: house, grade: grade)
                        
                        evaluatedPool.append(evaluatedHouse)
                    }
                }
            }
        }
        
        evaluatedPool.sort {return $0.grade > $1.grade}
        
        return evaluatedPool
    }
}
