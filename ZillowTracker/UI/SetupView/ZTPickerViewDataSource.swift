//
//  ZTZipDataSource.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 11.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation
import UIKit
import ZTModels

class ZTPickerViewDataSource: NSObject, UIPickerViewDataSource {
    var zips : [String]?
    
    init(zips: [String]) {
        super.init()
        
        self.zips = zips
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView                        : UIPickerView,
                    numberOfRowsInComponent component   : Int) -> Int
    {
        if let zips = zips {
            return zips.count
        } else {
            return 0
        }
    }
}
