//
//  ZTSetupSearchViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTSetupSearchViewController: UIViewController, UIPickerViewDelegate {
    weak private var rootView: ZTSetupSearchView? {
        return viewIfLoaded as? ZTSetupSearchView
    }
    
    var zipDataSource = ZTZipDataSource()
    var properties : [ZTEvaluatedModel]?
    
    let ZTShowPropertyListSegueId = "showPropertyList"
    
    //MARK: - view Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rootView = rootView {
            rootView.zipPickerView.dataSource = zipDataSource
            rootView.zipPickerView.delegate = zipDataSource
            
            rootView.setupDefaultPickerView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listViewController = segue.destination as? ZTPropertyListViewController
            else {
                return
        }
        
        listViewController.models = properties
    }
    
    //MARK: - interface Handlers

    @IBAction func onPerformSearchButton(_ sender: Any) {
        if let rootView = rootView {
            let maxPrice = String(rootView.priceSlider.value)
            let parameters = ["price_max" : maxPrice, "postal_code" : zipDataSource.selectedZip]
            
            
            DispatchQueue.main.async {[weak self] in
                guard let strongSelf = self else { return }
                ZTClient().performSearch(parameters: parameters) { (property) in
                    if let property = property {
                        let evaluatedProperties = property.evaluate()
                        strongSelf.properties = evaluatedProperties
                        let notificationContext = ZTLocalNotificationContext(properties: evaluatedProperties)
                        
                        notificationContext.run()
                        
                        DispatchQueue.main.async {
                            strongSelf.performSegue(withIdentifier: strongSelf.ZTShowPropertyListSegueId, sender: strongSelf)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onPriceSlider(_ sender: UISlider) {
        if let priceLabel = rootView?.maxPriceLabel {
            priceLabel.text = Int(sender.value).formattedWithSeparator
        }
    }
}

