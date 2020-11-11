//
//  ZTFloatExtensions.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 11.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String? { Formatter.withSeparator.string(for: self) }
}
