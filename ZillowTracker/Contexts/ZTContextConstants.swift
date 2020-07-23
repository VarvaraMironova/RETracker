//
//  ZTContextConstants.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 18.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation

enum ZTContextConstants {
    static let errorDomain            = Bundle.main.bundleIdentifier
    static let errorDomain_undefined  = "undefinedErrorDomain"
    
    static let noResultsErrorCode     = 99
    
    static let errorMessageKey        = "message"
    static let errorTitleKey          = "title"
    static let noResultsErrorUserInfo = [errorTitleKey  : "No properties found",
                                        errorMessageKey : "Change search parameters and try again."]
    
    static let backgroundTaskID       = "com.myronovaVarvara.propertySearch"
}
