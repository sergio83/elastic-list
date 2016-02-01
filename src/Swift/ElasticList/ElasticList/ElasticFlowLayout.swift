//
//  ElasticFlowLayout.swift
//  ElasticList
//
//  Created by Sergio Cirasa on 1/31/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

import UIKit

class ElasticFlowLayout: UICollectionViewFlowLayout{
    
    final let DEFAULT_BOUNCE = CGFloat(600)
    var dynamicAnimator: UIDynamicAnimator?

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//-----------------------------------------------------------------------------------------------------------------------------
    override func prepareLayout() {
        super.prepareLayout()
        
        if (self.dynamicAnimator == nil) {
        
            self.dynamicAnimator = UIDynamicAnimator.init(collectionViewLayout: self)
            let contentSize = self.collectionViewContentSize()
            let items = super.layoutAttributesForElementsInRect(CGRectMake(0, 0, contentSize.width, contentSize.height))
            
            for item in items!
            {
                let attachment = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                attachment.length = 0
                attachment.damping = 0.5
                attachment.frequency = 0.8
                self.dynamicAnimator?.addBehavior(attachment)
            }
        }
    }
//-----------------------------------------------------------------------------------------------------------------------------
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]?{
        return self.dynamicAnimator!.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
    }
//-----------------------------------------------------------------------------------------------------------------------------
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?{
        return self.dynamicAnimator?.layoutAttributesForCellAtIndexPath(indexPath)
    }
//-----------------------------------------------------------------------------------------------------------------------------
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool{
        let scrollView = self.collectionView
        let scrollDelta = newBounds.origin.y - scrollView!.bounds.origin.y
        let touchLocation = scrollView?.panGestureRecognizer.locationInView(scrollView)

        for obj in self.dynamicAnimator!.behaviors{
            let attachment = obj as! UIAttachmentBehavior
            let anchorPoint = attachment.anchorPoint;
            let distanceFromTouch = fabs(touchLocation!.y - anchorPoint.y);
            let scrollResistance = distanceFromTouch / DEFAULT_BOUNCE;
            
            let item = attachment.items.first
            var center = item?.center
            center!.y += scrollDelta * scrollResistance;
            item!.center = center!;
            self.dynamicAnimator?.updateItemUsingCurrentState(item!)
        }
        return true;
    }
//-----------------------------------------------------------------------------------------------------------------------------    
}