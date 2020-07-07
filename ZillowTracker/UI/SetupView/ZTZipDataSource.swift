//
//  ZTZipDataSource.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 11.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation
import UIKit

class ZTZipDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var selectedZip : String = ZTConstants.defaultZip
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView                        : UIPickerView,
                    numberOfRowsInComponent component   : Int) -> Int
    {
        return ZTConstants.zips.count
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView            : UIPickerView,
                    didSelectRow row        : Int,
                    inComponent component   : Int)
    {
        selectedZip = ZTConstants.zips[row]
    }
    
    func pickerView(_ pickerView            : UIPickerView,
                    titleForRow row         : Int,
                    forComponent component  : Int) -> String?
    {
        return ZTConstants.zips[row]
    }
}
