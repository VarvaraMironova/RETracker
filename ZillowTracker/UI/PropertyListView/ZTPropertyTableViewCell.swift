//
//  ZTPropertyTableViewCell.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 12.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels
import AdjustableVisualEffectView

class ZTPropertyTableViewCell: UITableViewCell {
    @IBOutlet var titleView         : AdjustableVisualEffectView!
    @IBOutlet var infoView          : AdjustableVisualEffectView!
    @IBOutlet var propertyImageView : UIImageView!
    
    var loadingView : ZTLoadingView?
    
    var imageModel  : ZTPhotoModel? {
        willSet(aNewValue) {
            if aNewValue != imageModel {
                if let imageModel = imageModel {
                    imageModel.cancelLoading()
                    hideLoadingView()
                    imageModel.removeObserver(self,
                                              forKeyPath: "image")
                }
                
                if let aNewValue = aNewValue {
                    aNewValue.addObserver(self,
                                          forKeyPath: "image",
                                          options: .new,
                                          context: nil)
                    if let image = aNewValue.image {
                        propertyImageView.image = image
                    } else {
                        showLoadingView()
                        aNewValue.load()
                    }
                }
            }
        }
    }
    
    var blurView : AdjustableVisualEffectView?
    
    override func prepareForReuse() {
        if let blurView = blurView {
            blurView.removeFromSuperview()
            self.blurView = nil
        }
        
        imageModel?.suspendLoading()
        hideLoadingView()
        
        super.prepareForReuse()
    }
    
    func fillWithModel(model: ZTEvaluatedModel) {
        let house = model.model
        titleView.fill(title: "$\(house.price ?? 0)")
        titleView.textAlignment = 0
        infoView.fill(title: house.description)
        infoView.textAlignment = 0
        
        imageModel = house.thumbnail
        
        let houseRank = model.grade
        if houseRank > 0 {
            addRankView(rank: String(Int(houseRank)))
        }
    }
    
    //MARK:- Private
    private func addRankView(rank: String) {
        let imageOrigin = propertyImageView.frame.origin
        let frame = CGRect(x     : imageOrigin.x,
                           y     : imageOrigin.y,
                           width : 48,
                           height: 48)
        let rankView = AdjustableVisualEffectView(frame: frame)
        rankView.intensity = 0.3
        rankView.fill(title: rank)

        addSubview(rankView)

        blurView = rankView
    }
    
    private func showLoadingView() {
        //show loadingView in imagePreviewCollectionView's cell frame
        let frame = propertyImageView.bounds
        let size = CGSize(width  : frame.size.width - ZTUIConstants.minInterItemSpacingPhoto,
                          height : frame.size.height)
        let loadingViewFrame = CGRect(origin: frame.origin, size: size)
        let loadingView = ZTLoadingView(frame: loadingViewFrame)
        loadingView.loadingImageView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        addSubview(loadingView)
        
        loadingView.show(placeholderName: "noImage_placeholder")
        self.loadingView = loadingView
    }
    
    private func hideLoadingView() {
        if let loadingView = loadingView {
            loadingView.hide()
            
            self.loadingView = nil
        }
    }
    
    //MARK:- KVO
    override func observeValue(forKeyPath keyPath: String?,
                               of object         : Any?,
                               change            : [NSKeyValueChangeKey : Any]?,
                               context           : UnsafeMutableRawPointer?)
    {
        if keyPath == "image", let object = object as? ZTPhotoModel, object.path == imageModel?.path {
            hideLoadingView()
            propertyImageView.image = object.image
        }
    }
}
