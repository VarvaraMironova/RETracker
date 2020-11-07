//
//  ZTPropertyDetailViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 23.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTPropertyDetailViewController: UIViewController,
                                      UICollectionViewDelegate,
                                      UIGestureRecognizerDelegate,
                                      UICollectionViewDelegateFlowLayout
{
    var house : ZTHouse!
    
    var client : ZTClient?
    
    var collectionViewDataSource : ZTCollectionViewDataSource?
    
    weak private var rootView: ZTPropertyDetailView? {
        return viewIfLoaded as? ZTPropertyDetailView
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //pre-fill rootView
        if let rootView = rootView {
            rootView.fill(property: house)
            
            if let photos = house.photos {
                let dataSource = ZTCollectionViewDataSource(models: photos)
                rootView.imagePreviewCollectionView.dataSource = dataSource
                collectionViewDataSource = dataSource
            } else if let photos = house.details?.photos {
                let dataSource = ZTCollectionViewDataSource(models: photos)
                rootView.imagePreviewCollectionView.dataSource = dataSource
                collectionViewDataSource = dataSource
            } else {
                loadPropertyDetails()
            }
        }
    }
    
    //MARK:- Interface Handling
    @IBAction func onAddressButton(_ sender: Any) {
        //Todo:
        //Implement map view and show address on the map
    }
    
    @IBAction func onViewInSafaryButton(_ sender: Any) {
        if let propertyLink = URL.init(string: house.link) {
            if UIApplication.shared.canOpenURL(propertyLink) {
                UIApplication.shared.open(propertyLink, options: [ : ], completionHandler: nil)
            }
        }
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer                          : UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(_          collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if let rootView = rootView {
//            rootView.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        }
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView            : UICollectionView,
                        layout collectionViewLayout : UICollectionViewLayout,
                        sizeForItemAt indexPath     : IndexPath) -> CGSize
    {
        let height = collectionView.bounds.size.height
        let width = collectionView.bounds.size.width - ZTUIConstants.minInterItemSpacingPhoto
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView                            : UICollectionView,
                        layout collectionViewLayout                 : UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section : Int) -> CGFloat
    {
        return 0.01
    }
    
    func collectionView(_ collectionView                       : UICollectionView,
                        layout collectionViewLayout            : UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section : Int) -> CGFloat
    {
        return ZTUIConstants.minInterItemSpacingPhoto
    }
    
    func collectionView(_ collectionView            : UICollectionView,
                        layout collectionViewLayout : UICollectionViewLayout,
                        insetForSectionAt section   : Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.zero
    }
    
    //MARK:- Helpers
    func loadPropertyDetails() {
        if let rootView = rootView {
            if let previewImagePath = house.thumbnail?.path {
                rootView.showLoadingView(placeholderPath: previewImagePath)
            }
            
            //load house details
            client?.cancel()
            
            let client = ZTClient()
            
            client.loadPropertyDetails(propertyID: house.identifier) { (details, error) in
                if let details = details {
                    self.house.details = details
                    
                    DispatchQueue.main.async {
                        //update rootView
                        if let photos = details.photos {
                            let dataSource = ZTCollectionViewDataSource(models: photos)
                            rootView.imagePreviewCollectionView.dataSource = dataSource
                            self.collectionViewDataSource = dataSource
                            
                            //rootView.imagePreviewCollectionView.reloadData()
                        }
                        
                        rootView.feelWithDetails(details: details)
                        
                        rootView.hideLoadingView()
                    }
                } else {
                    //display error
                    if let error = error {
                        print(error.description)
                    }
                }
            }
            
            self.client = client
        }
    }
}
