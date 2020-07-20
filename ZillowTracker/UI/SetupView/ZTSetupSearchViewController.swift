//
//  ZTSetupSearchViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTSetupSearchViewController: UIViewController, UIPickerViewDelegate {
    //MARK: - variables & constants
    weak private var rootView: ZTSetupSearchView? {
        return viewIfLoaded as? ZTSetupSearchView
    }
    
    var propertyList : [ZTEvaluatedModel]?
    
    var pickerViewDataSource : ZTPickerViewDataSource?
    
    private var searchContext  : ZTSearchPropertiesContext?
    private var searchSettings = ZTSearchSettings()
    
    //MARK: - View Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rootView = rootView {
            let pickerViewDataSource = ZTPickerViewDataSource()
            rootView.zipPickerView.dataSource = pickerViewDataSource
            
            self.pickerViewDataSource = pickerViewDataSource
            
            rootView.setupFromSettings(settings: searchSettings)
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listViewController = segue.destination as? ZTPropertyListViewController
            else {
                return
        }
        
        listViewController.models = propertyList
    }
    
    //MARK: - interface Handlers
    @IBAction func onPerformSearchButton(_ sender: Any) {
        if let searchContext = searchContext {
            switch searchContext.state {
            case .searching:
                cancelSearch()
            default:
                performSearch()
            }
        } else {
            performSearch()
        }
    }
    
    @IBAction func onPriceSlider(_ sender: UISlider) {
        if let priceLabel = rootView?.maxPriceLabel {
            let value = Int(sender.value)
            priceLabel.text = value.formattedWithSeparator
            searchSettings.maxPrice = value
        }
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView            : UIPickerView,
                    didSelectRow row        : Int,
                    inComponent component   : Int)
    {
        searchSettings.zip = ZTUIConstants.zips[row]
    }
    
    func pickerView(_ pickerView            : UIPickerView,
                    titleForRow row         : Int,
                    forComponent component  : Int) -> String?
    {
        return ZTUIConstants.zips[row]
    }
    
    //MARK: - Private
    private func showAlert(error: NSError) {
        let continueAction = UIAlertAction.init(title: "Continue",
                                                style: .cancel,
                                                handler: nil)
        let title = error.userInfo[ZTUIConstants.errorTitleKey] as? String
        let message = error.userInfo[ZTUIConstants.errorMessageKey] as? String
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
            let searchContext = ZTSearchPropertiesContext.init(searchSettings: searchSettings)
            searchSettings.save()
            
            rootView.updateSubviewsWhileLoading(loadingFinished: false)
            
            searchContext.perform { (properties, error) in
                rootView.updateSubviewsWhileLoading(loadingFinished: true)
                
                if let properties = properties {
                    self.propertyList = properties
        
                    DispatchQueue.main.async {[weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.performSegue(withIdentifier: ZTUIConstants.ZTShowPropertyListSegueId, sender: strongSelf)
                    }
                }
                
                if let error = error, error.code != ZTUIConstants.cancelErrorCode {
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
            
            if let rootView = rootView {
                rootView.updateSubviewsWhileLoading(loadingFinished: true)
            }
        }
    }
}

