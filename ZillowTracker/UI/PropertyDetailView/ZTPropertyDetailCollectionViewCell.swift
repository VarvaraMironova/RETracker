//
//  ZTPropertyDetailCollectionViewCell.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 23.07.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTPropertyDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet var previewImageView: UIImageView!
    
    var loadingView : ZTLoadingView?
    
    private var imageModel : ZTPhotoModel? {
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
                    showLoadingView()
                    aNewValue.load()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        imageModel?.suspendLoading()
        hideLoadingView()

        super.prepareForReuse()
    }
    
    //MARK:- Public
    public func fill(imageModel: ZTPhotoModel) {
        if let image = imageModel.image {
            previewImageView.image = image
        }
        
        self.imageModel = imageModel
    }
    
    //MARK:- Private
    private func showLoadingView() {
        //show loadingView in imagePreviewCollectionView's cell frame
        let frame = bounds
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
            previewImageView.image = object.image
        }
    }
}
