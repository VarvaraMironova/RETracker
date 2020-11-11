//
//  ZTCollectionViewDataSource.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 24.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import Foundation
import UIKit
import ZTModels

class ZTCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var models: [ZTPhotoModel]
    
    required init(models: [ZTPhotoModel]) {
        self.models = models
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_               collectionView : UICollectionView,
                        numberOfItemsInSection section : Int) -> Int
    {
        return models.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_        collectionView : UICollectionView,
                        cellForItemAt indexPath : IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTUIConstants.propertyDetailCollectionViewCellID,
        for: indexPath) as! ZTPropertyDetailCollectionViewCell
        cell.fill(imageModel: models[indexPath.row])
        
        return cell
    }
}
