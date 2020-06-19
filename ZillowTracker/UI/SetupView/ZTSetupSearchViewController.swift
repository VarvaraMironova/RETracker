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
            let maxPrice = Int(rootView.priceSlider.value)
            let parameters = ["price_max" : maxPrice, "postal_code" : zipDataSource.selectedZip] as [String : Any]
            
            rootView.updateSubviewsWhileLoading(loadingFinished: false)
            
            DispatchQueue.main.async {[weak self] in
                guard let strongSelf = self else { return }
                ZTClient().performSearch(parameters: parameters) { (property, error) in
                    if let property = property {
                        let evaluatedProperties = property.evaluate()
                        strongSelf.properties = evaluatedProperties
                        
                        if evaluatedProperties.count > 0 {
                            let notificationContext = ZTLocalNotificationContext(properties: evaluatedProperties)
                            
                            notificationContext.run()
                            
                            DispatchQueue.main.async {
                                rootView.updateSubviewsWhileLoading(loadingFinished: true)
                                strongSelf.performSegue(withIdentifier: strongSelf.ZTShowPropertyListSegueId, sender: true)
                            }
                        } else {
                            //show alert
                            DispatchQueue.main.async {
                                rootView.updateSubviewsWhileLoading(loadingFinished: false)
                                let continueAction = UIAlertAction.init(title: "Continue", style: .cancel, handler: nil)
                                let alertcontroller = UIAlertController.init(title: "No properties found",
                                                                             message: "Change search parameters and try again.",
                                                                             preferredStyle: .alert)
                                alertcontroller.addAction(continueAction)
                                
                                strongSelf.present(alertcontroller,
                                                   animated: true,
                                                   completion: nil)
                            }
                        }
                        
                        return
                    }
                    
                    if let error = error {
                        DispatchQueue.main.async {
                            rootView.updateSubviewsWhileLoading(loadingFinished: false)
                            let continueAction = UIAlertAction.init(title: "Continue", style: .cancel, handler: nil)
                            let message = error.userInfo[ZTConstants.errorMessageKey] as? String
                            let alertcontroller = UIAlertController.init(title: "Error occured",
                                                                         message: message,
                                                                         preferredStyle: .alert)
                            alertcontroller.addAction(continueAction)
                            
                            strongSelf.present(alertcontroller,
                                               animated: true,
                                               completion: nil)
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

