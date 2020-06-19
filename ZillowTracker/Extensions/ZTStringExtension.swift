//
//  ZTStringExtension.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 6/9/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

extension String {
    func convertToDate(format: String = "YYYY-MM-dd'T'HH:mm:ss'Z'") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            dateFormatter.dateFormat = "YYYY-MM-dd"
            return dateFormatter.date(from: self)
        }
    }
}
