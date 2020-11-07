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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = UIColor(red   : 185.0 / 255.0,
                                                 green : 124.0 / 255.0,
                                                 blue  : 126.0 / 255.0,
                                                 alpha : 1.0)
        self.backgroundView = backgroundView
    }
    
    func fill(text: String?) {
        zipLabel.text = text
    }

}
