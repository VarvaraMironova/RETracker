//
//  ZTDateExtension.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 07.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

extension Date {
    func convertToString(format: String = "YYYY-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
