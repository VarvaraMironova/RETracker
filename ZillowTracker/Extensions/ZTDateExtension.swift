//
//  ZTDateExtension.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 07.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

extension Date {
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    func convertToString(format: String = "YYYY-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func notificationDate(hrs  : Int,
                          mins : Int,
                          secs : Int) -> Date
    {
        return Calendar.current.date(bySettingHour: hrs,
                                            minute: mins,
                                            second: secs,
                                                of: tomorrow) ?? tomorrow
    }
}
