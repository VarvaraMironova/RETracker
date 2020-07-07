//
//  ZTSetupSearchViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTSetupSearchViewController: UIViewController, UIPickerViewDelegate {
    //MARK: - variables & constants
    weak private var rootView: ZTSetupSearchView? {
        return viewIfLoaded as? ZTSetupSearchView
    }
    
    var zipDataSource = ZTZipDataSource()
    var properties    : [ZTEvaluatedModel]?
    
    private var searchContext : ZTSearchPropertiesContext?
    private var isSearching   : Bool = false
    
    let ZTShowPropertyListSegueId = "showPropertyList"
    
    //MARK: - View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rootView = rootView {
            rootView.zipPickerView.dataSource = zipDataSource
            rootView.zipPickerView.delegate = zipDataSource
            
            rootView.setupDefaultPickerView()
        }
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listViewController = segue.destination as? ZTPropertyListViewController
            else {
                return
        }
        
        listViewController.models = properties
    }
    
    //MARK: - interface Handlers
    @IBAction func onPerformSearchButton(_ sender: Any) {
        if isSearching {
            cancelSearch()
        } else {
            performSearch()
        }
    }
    
    @IBAction func onPriceSlider(_ sender: UISlider) {
        if let priceLabel = rootView?.maxPriceLabel {
            priceLabel.text = Int(sender.value).formattedWithSeparator
        }
    }
    
    //MARK: - Private
    private func showAlert(error: NSError) {
        let continueAction = UIAlertAction.init(title: "Continue", style: .cancel, handler: nil)
        let title = error.userInfo[ZTConstants.errorTitleKey] as? String
        let message = error.userInfo[ZTConstants.errorMessageKey] as? String
        let alertcontroller = UIAlertController.init(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
        alertcontroller.addAction(continueAction)
        
        self.present(alertcontroller,
                     animated: true,
                     completion: nil)
    }
    
    private func performSearch() {
        if let rootView = rootView {
            let maxPrice = Int(rootView.priceSlider.value)
            let zip = zipDataSource.selectedZip
            let searchContext = ZTSearchPropertiesContext.init(maxPrice: maxPrice, zip: zip)
            isSearching = true
            
            rootView.updateSubviewsWhileLoading(loadingFinished: false)
            
            searchContext.perform { (properties, error) in
                rootView.updateSubviewsWhileLoading(loadingFinished: true)
                self.isSearching = false
                
                if let properties = properties {
                    self.properties = properties
                    let notificationContext = ZTLocalNotificationContext(properties: properties)
                    
                    notificationContext.run()
                    
                    DispatchQueue.main.async {[weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.performSegue(withIdentifier: strongSelf.ZTShowPropertyListSegueId, sender: strongSelf)
                    }
                }
                
                if let error = error, error.code != ZTConstants.cancelErrorCode {
                    DispatchQueue.main.async {[weak self] in
                        guard let strongSelf = self else { return }
                        rootView.updateSubviewsWhileLoading(loadingFinished: true)
                        strongSelf.showAlert(error: error)
                    }
                }
            }
            
            self.searchContext = searchContext
        }
    }
    
    private func cancelSearch() {
        if let searchContext = searchContext {
            searchContext.cancel()
            self.searchContext = nil
            isSearching = false
            
            if let rootView = rootView {
                rootView.updateSubviewsWhileLoading(loadingFinished: true)
            }
        }
    }
}

