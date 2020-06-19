//
//  ZTPropertyListHeaderView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 17.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTPropertyListHeaderView: UITableViewHeaderFooterView {
    @IBOutlet var zipLabel: UILabel!
    
    func fill(text: String?) {
        zipLabel.text = text
    }

}
