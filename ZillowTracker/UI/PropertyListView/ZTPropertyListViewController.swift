//
//  ZTPropertyListViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

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
            tableViewDataSource = ZTTableViewDataSource(models: models)
            rootView.propertyListTableView.dataSource = tableViewDataSource
            
            if let firstModel = models.first,
               let address = firstModel.model.address
            {
                if let neighborhood = address.neighborhood {
                    rootView.fill(title: neighborhood)
                } else {
                    if let zip = address.zip {
                        rootView.fill(title: zip)
                    }
                }
            }
        }
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? ZTPropertyDetailViewController
            else {
                return
        }
        
        if let tableView = rootView?.propertyListTableView, let indexPath = tableView.indexPathForSelectedRow, let models = models
        {
            let model = models[indexPath.row]
            detailViewController.house = model.model
        }
    }
    
    //MARK: - Interface Handling
    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
