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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //prevent UITableView scrrolling when the content fits on the screen
        propertyListTableView.alwaysBounceVertical = false
    }
    
    public func fill(title: String) {
        titleLabel.text = title
    }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
