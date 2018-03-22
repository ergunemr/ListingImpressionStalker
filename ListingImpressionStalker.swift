//
//  ListingImpressionStalker.swift
//  ImpressionsDemoApp
//
//  Created by Emre on 23.03.2018.
//  Copyright © 2018 Emre. All rights reserved.
//

import UIKit

protocol ListingImpressionItem {
    func getUniqueId()->String
}

protocol ListingImpressionStalkerDelegate:NSObjectProtocol {
    func sendEventForCell(atIndexPath indexPath:IndexPath)
}

class ListingImpressionStalker: NSObject {
    
    //MARK: Variables & Constants
    let minimumPercentageOfCell: CGFloat
    let collectionView: UICollectionView
    static fileprivate var alreadySentIdentifiers = [String]()
    static let minimumPercentageOfCellDefaultValue = CGFloat(0.5)
    static let minimumPercentageMinValue = CGFloat.leastNonzeroMagnitude
    static let minimumPercentageMaxValue = CGFloat(1.0)
    weak var delegate: ListingImpressionStalkerDelegate?
    
    //MARK: Initializers
    init(minimumPercentageOfCell: CGFloat, collectionView: UICollectionView, delegate:ListingImpressionStalkerDelegate) {
        
        if minimumPercentageOfCell < ListingImpressionStalker.minimumPercentageMinValue || minimumPercentageOfCell > ListingImpressionStalker.minimumPercentageMaxValue {
            self.minimumPercentageOfCell = ListingImpressionStalker.minimumPercentageOfCellDefaultValue
        } else {
            self.minimumPercentageOfCell = minimumPercentageOfCell
        }
        self.collectionView = collectionView
        self.delegate = delegate
    }
    
    init(collectionView: UICollectionView, delegate:ListingImpressionStalkerDelegate) {
        self.minimumPercentageOfCell = ListingImpressionStalker.minimumPercentageOfCellDefaultValue
        self.collectionView = collectionView
        self.delegate = delegate
    }
    
    //MARK: Public Methods
    func stalkCells(){
        
        for cell in collectionView.visibleCells {
            if let listingItemCell = cell as? UICollectionViewCell&ListingImpressionItem{
                let visiblePercentOfCell = percentOfVisiblePart(ofCell: listingItemCell, inCollectionView: collectionView)
                
                if visiblePercentOfCell >= minimumPercentageOfCell, !ListingImpressionStalker.alreadySentIdentifiers.contains(listingItemCell.getUniqueId()){
                    
                    guard let indexPath = collectionView.indexPath(for: listingItemCell), let delegate = delegate else{
                        continue
                    }
                    delegate.sendEventForCell(atIndexPath: indexPath)
                    ListingImpressionStalker.alreadySentIdentifiers.append(listingItemCell.getUniqueId())
                }
            }
        }
    }
    
    //MARK: Private Methods
    private func percentOfVisiblePart(ofCell cell:UICollectionViewCell, inCollectionView collectionView:UICollectionView) -> CGFloat{
        
        guard let indexPathForCell = collectionView.indexPath(for: cell),
            let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPathForCell) else {
                return CGFloat.leastNonzeroMagnitude
        }
        
        let cellFrameInSuper = collectionView.convert(layoutAttributes.frame, to: collectionView.superview)
        
        let interSectionRect = cellFrameInSuper.intersection(collectionView.frame)
        let percentOfIntersection: CGFloat = interSectionRect.height/cellFrameInSuper.height
        
        return percentOfIntersection
    }
}

