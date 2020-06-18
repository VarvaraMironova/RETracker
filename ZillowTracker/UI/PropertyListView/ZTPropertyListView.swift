//
//  ZTPropertyListView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTPropertyListView: UIView {
    @IBOutlet var propertyListTableView: UITableView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let headerNib = UINib.init(nibName: "ZTPropertyListHeaderView", bundle: nil)
        propertyListTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "ZTPropertyListHeaderView")
    }
}
