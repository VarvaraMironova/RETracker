//
//  ZTPropertyListViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTPropertyListViewController: UIViewController, UITableViewDelegate, UIGestureRecognizerDelegate {
    var models              : [ZTEvaluatedModel]?
    var tableViewDataSource : ZTTableViewDataSource?
    
    weak private var rootView: ZTPropertyListView? {
        return viewIfLoaded as? ZTPropertyListView
    }
    
    //MARK: - View Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let models = models, let rootView = rootView {
            tableViewDataSource = ZTTableViewDataSource.init(models: models)
            rootView.propertyListTableView.dataSource = tableViewDataSource
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let models = models {
            let selectedModel = models[indexPath.row].model
            if let propertyLink = URL.init(string: selectedModel.link) {
                if UIApplication.shared.canOpenURL(propertyLink) {
                    UIApplication.shared.open(propertyLink, options: [ : ], completionHandler: nil)
                }
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ZTPropertyListHeaderView") as? ZTPropertyListHeaderView {
            if let models = models, let firstModel = models.first, let address = firstModel.model.address {
                if let neighborhood = address.neighborhood {
                    headerView.fill(text: neighborhood)
                } else {
                    let zip = address.zip
                    headerView.fill(text: zip)
                }
            }
            
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
