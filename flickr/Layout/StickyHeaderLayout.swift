//
//  StIckyHeaderLayout.swift
//  flickr
//
//  Created by Devesh Tyagi on 21/04/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
//
class StickyHeaderLayout : UICollectionViewFlowLayout{


   
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
         return true
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = super.layoutAttributesForElements(in: rect) as! [UICollectionViewLayoutAttributes]
        
        let headerNeedingLayout = NSMutableIndexSet()
        for attributes in layoutAttributes{
            if attributes.representedElementCategory == .cell{
                headerNeedingLayout.add(attributes.indexPath.section)
                
            }
        for attributes in layoutAttributes{
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionView.elementKindSectionHeader{
                    headerNeedingLayout.remove(attributes.indexPath.section)
                        
                }
            }
        }
            headerNeedingLayout.enumerate{(index , stop) -> Void in
                let indexPath = NSIndexPath(item: 0, section: index)
                let attributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath as IndexPath)
                layoutAttributes.append(attributes!)
                
            }
            for attributes in layoutAttributes{
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionView.elementKindSectionHeader{
                        let section = attributes.indexPath.section
                        let attributeForFirstItemInSection = layoutAttributesForItem(at: NSIndexPath(item: 0, section: section) as IndexPath)
                        let attributeForLastItemInSection = layoutAttributesForItem(at: NSIndexPath(item:  collectionView!.numberOfSections-1 , section: section ) as IndexPath)
                        var frame = attributes.frame
                        let offset = collectionView!.contentOffset.y
                        let minY = attributeForFirstItemInSection!.frame.minY - frame.height
                        let maxY = attributeForLastItemInSection!.frame.minY - frame.height
                        let y  = min(max(offset, minY),maxY)
                        frame.origin.y = y
                        attributes.frame = frame
                        attributes.zIndex = 99
                        
                            
                    }
                }
            }
          
        }
          return layoutAttributes
    }
    
}
