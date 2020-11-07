//
//  ZTPropertyListView.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTPropertyListView: UIView {
    @IBOutlet var propertyListTableView : UITableView!
    
    @IBOutlet var backButton : UIButton!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var headerView : ZTGradientView!
    
    
    public func fill(title: String) {
        titleLabel.text = title
    }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
