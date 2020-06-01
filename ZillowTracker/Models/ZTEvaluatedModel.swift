//
//  ZTEvaluatedModel.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/31/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

struct ZTEvaluatedModel : Hashable {
    var model : ZTHouse?
    var grade : Float = 0.0
    
    static func == (lhs: ZTEvaluatedModel, rhs: ZTEvaluatedModel) -> Bool {
        return lhs.grade == rhs.grade && lhs.model == rhs.model
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(model)
        hasher.combine(grade)
    }
    
    init(model : ZTHouse, grade: Float) {
        self.model = model
        self.grade = grade
    }
}
