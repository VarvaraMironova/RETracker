//
//  ZTSetupSearchViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/28/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

extension UIViewController {
    func showAlert(error: NSError, completion block: (() -> Void)? = nil) {
        DispatchQueue.main.async {[unowned self] in
            let continueAction = UIAlertAction(title   : "Continue",
                                               style   : .cancel,
                                               handler : nil)
            let title = error.userInfo[ZTUIConstants.errorTitleKey] as? String
            let message = error.userInfo[ZTUIConstants.errorMessageKey] as? String
            let alertcontroller = UIAlertController(title          : title,
                                                    message        : message,
                                                    preferredStyle : .alert)
            alertcontroller.addAction(continueAction)
            
            self.present(alertcontroller,
                         animated   : true,
                         completion : block)
        }
    }
}

class ZTSetupSearchViewController: UIViewController, UIPickerViewDelegate {
    
    //MARK: - variables & constants
    weak private var rootView: ZTSetupSearchView? {
        return viewIfLoaded as? ZTSetupSearchView
    }
    
    var propertyList : [ZTEvaluatedModel]?
    
    var pickerViewDataSource : ZTPickerViewDataSource?
    
    private var searchContext  : ZTSearchPropertiesContext?
    private lazy var searchSettings = {
        return ZTSearchSettings()
    }()
    
    //MARK: - View Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rootView = rootView {
            let pickerViewDataSource = ZTPickerViewDataSource(zips: searchSettings.zips)
            rootView.zipPickerView.dataSource = pickerViewDataSource
            
            self.pickerViewDataSource = pickerViewDataSource
            
            rootView.updateZipPicker(settings: searchSettings)
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
    
    //MARK: - Interface Handlers
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
    
    @IBAction func onAPITypeSegmentSegmentControl(_ sender: UISegmentedControl) {
        #warning("Block segment control till resolve .forRent's API issue.")
        let error = NSError(domain   : "custom",
                            code     : ZTUIConstants.cancelErrorCode,
                            userInfo : ZTUIConstants.blockForRentAPIUserInfo)
        showAlert(error: error) {
            sender.selectedSegmentIndex = 0
        }
        
//        switch sender.selectedSegmentIndex {
//        case 0:
//            //"For Sale API" is choosen
//            searchSettings.apiType = .forSale
//            break
//        case 1:
//            //"For Rent API" is choosen
//            searchSettings.apiType = .forRent
//            break
//        default:
//            break
//        }
//
//        if let rootView = rootView {
//            rootView.updatePriceSlider(settings: searchSettings)
//        }
    }
    
    @IBAction func onPropertyTypeSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //.single_family, .condo, .multi_family, .mobile
            searchSettings.propertyType = .realEstate
            break
            
        case 1:
            //.land
            searchSettings.propertyType = .land
            break
        case 2:
            //all options are choosen
            searchSettings.propertyType = .all
            break
        default:
            break
        }
    }
    
    @IBAction func onBackgroundSwitch(_ sender: UISwitch) {
        searchSettings.isBackgroundSearchOFF = !sender.isOn
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView            : UIPickerView,
                    didSelectRow row        : Int,
                    inComponent component   : Int)
    {
        searchSettings.zip = searchSettings.zips[row]
    }
    
    func pickerView(_ pickerView              : UIPickerView,
                    attributedTitleForRow row : Int,
                    forComponent component    : Int) -> NSAttributedString?
    {
        var attributedTitle = NSAttributedString()
        
        if let textColor = UIColor(named: "color_textDark") {
            let title = searchSettings.zips[row]
            let key = NSAttributedString.Key.foregroundColor
            attributedTitle = NSAttributedString(string    : title,
                                                 attributes: [key: textColor])
        }
        
        return attributedTitle
    }
    
    //MARK: - Private
    private func performSearch() {
        if let rootView = rootView {
            searchSettings.save()
            let searchContext = ZTSearchPropertiesContext()
            
            rootView.updateSubviewsWhileLoading(loadingFinished: false)
            
            searchContext.perform { (properties, error) in
                rootView.updateSubviewsWhileLoading(loadingFinished: true)
                
                if let properties = properties {
                    self.propertyList = properties
        
                    DispatchQueue.main.async {[weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.performSegue(withIdentifier : ZTUIConstants.showPropertyListSegueId,
                                                sender         : strongSelf)
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

