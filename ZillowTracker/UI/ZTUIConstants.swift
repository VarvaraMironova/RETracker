//
//  ZTUIConstants.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 17.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

enum ZTUIConstants {
    static let cancelErrorCode = -999
    
    static let errorMessageKey = "message"
    static let errorTitleKey   = "title"
    
    static let showPropertyListSegueId    = "showPropertyList"
    static let showPropertyDetailsSegueId = "showPropertyDetails"
    
    static let propertyDetailCollectionViewCellID = "ZTPropertyDetailCollectionViewCell"
    
    //collectionView constants
    static let minInterItemSpacingPhoto : CGFloat = 4.0
    
    static let blockForRentAPIUserInfo = [errorTitleKey   : "For Rent API error.",
                                          errorMessageKey : "The API is currently unavailable."]
}
