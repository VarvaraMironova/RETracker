//
//  ZTEvaluationContext.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/31/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTEvaluationContext: NSObject {
    private var pool : Array<ZTHouse>?
    
    init(models: Array<ZTHouse>) {
        self.pool = models
    }
    
    //The function evaluates models in pool of houses
    //Each model become a grade.
    //Add a pair (model, grade) to resulting set
    //Sort set by the grades
    public func evaluate() -> Set<ZTEvaluatedModel> {
        var evaluatedPool = Set<ZTEvaluatedModel>()
        
        //evaluate by pricePerSquareFeet
        var maxPricePerSquareFeet : Float = 0.0
        var minPricePerSquareFeet : Float = 0.0
        
        pool?.sort(by: { (house1 : ZTHouse, house2 : ZTHouse) -> Bool in
            return house1.pricePerSquareFeet > house2.pricePerSquareFeet
        })
        
        if let mostExpensiveHouse = pool?.last {
            maxPricePerSquareFeet = mostExpensiveHouse.pricePerSquareFeet
        }
        
        if let cheapestHouse = pool?.first {
            minPricePerSquareFeet = cheapestHouse.pricePerSquareFeet
        }
        
        let deltaPricePerSquareFeet = (maxPricePerSquareFeet - minPricePerSquareFeet) / 100.0
        
        //evaluate by lotSize
        var maxLot : Float = 0.0
        var minLot : Float = 0.0
        pool?.sort(by: { (house1 : ZTHouse, house2 : ZTHouse) -> Bool in
            return house1.lot > house2.lot
        })
        
        if let biggestLotHouse = pool?.last {
            maxLot = biggestLotHouse.lot
        }
        
        if let smalestLotHouse = pool?.first {
            minLot = smalestLotHouse.lot
        }
        
        let deltaLot = (maxLot - minLot) / 100.0
        
        if let pool = pool {
            for house in pool {
                var gradeByPricePerSquareFeet : Float = 0.0
                if deltaPricePerSquareFeet != 0 {
                    gradeByPricePerSquareFeet = (maxPricePerSquareFeet - house.pricePerSquareFeet) / deltaPricePerSquareFeet
                }
                
                var gradeByLot : Float = 0.0
                if deltaLot != 0 {
                    gradeByLot = (maxLot - house.lot) / deltaLot
                }
                
                let grade = gradeByPricePerSquareFeet * 0.7 + gradeByLot * 0.3
                let evaluatedHouse = ZTEvaluatedModel(model: house, grade: grade)
                evaluatedPool.insert(evaluatedHouse)
            }
        }
        
        return evaluatedPool
    }

}
