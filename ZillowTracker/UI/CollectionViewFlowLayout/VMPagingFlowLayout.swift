//
//  VMPagingFlowLayout.swift
//  VMMushrooms
//
//  Created by Varvara Myronova on 12/28/19.
//  Copyright © 2019 Varvara Myronova. All rights reserved.
//
//  CollectionViewFlowLayout with horizontal cell-based pagination cells with same itemSize.
//  Variables visibleItemsCount and itemSpacing used to set values of visible items number per page and distance between them accordingly.

import UIKit

class VMPagingFlowLayout: UICollectionViewFlowLayout {
    
    public var visibleItemsCount = 1
    public var itemSpacing : CGFloat = .zero
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let collectionView = collectionView {
            minimumInteritemSpacing = itemSpacing
            minimumLineSpacing = .zero
            sectionInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
            
            //count itemSize
            let visibleRectSize = collectionView.bounds.size
            let itemHeight = visibleRectSize.height
            let floatItemsCount = CGFloat(visibleItemsCount)
            let itemWidth = visibleRectSize.width / (floatItemsCount + (floatItemsCount - 1) * itemSpacing)
            itemSize = CGSize(width: itemWidth, height: itemHeight)
            scrollDirection = .horizontal
        }
    }
    
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        guard let collectionView = collectionView
            else { return proposedContentOffset }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x
        let targetRect = CGRect(origin: CGPoint(x: proposedContentOffset.x, y: .zero),
                                size: collectionView.bounds.size)

        for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
            let itemOffset = layoutAttributes.frame.origin.x
            
            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
