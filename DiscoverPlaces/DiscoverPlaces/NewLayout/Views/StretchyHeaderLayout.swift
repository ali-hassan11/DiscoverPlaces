//
//  StretchyHeaderLayout.swift
//  DiscoverPlaces
//
//  Created by user on 04/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {

    //Modify attrs of heady component
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttrs = super.layoutAttributesForElements(in: rect)
        
        layoutAttrs?.forEach {
            if $0.representedElementKind == UICollectionView.elementKindSectionHeader {
                //header
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                print(contentOffsetY)
                
                if contentOffsetY > 0 { return }
                
                let width = collectionView.frame.width
                
                let height = $0.frame.height - contentOffsetY
                
                $0.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                
            }
        }
        
        return layoutAttrs
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
