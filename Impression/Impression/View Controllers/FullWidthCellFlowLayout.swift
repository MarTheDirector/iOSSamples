//
//  FlowChartFullWidth.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit

class FullWidthCellFlowLayout : UICollectionViewFlowLayout
{
    // MARK: Overrides
    
    /*override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
        updateAttribute(attributes)
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        updateAttribute([attributes])
        return attributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        if !CGRectEqualToRect(newBounds, self.collectionView!.bounds)
        {
            return true
        }
        return false
    }
    
    // MARK: Private
    
    private func updateAttribute(attributes: [UICollectionViewLayoutAttributes])
    {
        for attr in attributes
        {
            attr.frame.size.width = fullWidth()
            attr.frame.origin.x = 0
        }
    }
    
    func fullWidth() -> CGFloat
    {
        return self.collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right
    }*/
}
