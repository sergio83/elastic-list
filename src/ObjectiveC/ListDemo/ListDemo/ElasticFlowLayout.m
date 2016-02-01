//
//  SpringyFlowLayout.m
//  ListDemo
//
//  Created by Sergio Cirasa on 1/31/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import "ElasticFlowLayout.h"

#define  kDefaultBounce 600

@interface ElasticFlowLayout ()
@property(nonatomic,strong) UIDynamicAnimator *dynamicAnimator;
@end

@implementation ElasticFlowLayout
//------------------------------------------------------------------------------------------------------------
- (void)prepareLayout
{
    [super prepareLayout];
    
    if (!self.dynamicAnimator)
    {
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *item in items)
        {
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
            attachment.length = 0;
            attachment.damping = 0.5;
            attachment.frequency = 0.8;
            [self.dynamicAnimator addBehavior:attachment];
        }
    }
}
//------------------------------------------------------------------------------------------------------------
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.dynamicAnimator itemsInRect:rect];
}
//------------------------------------------------------------------------------------------------------------
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}
//------------------------------------------------------------------------------------------------------------
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *attachment in self.dynamicAnimator.behaviors)
    {
        CGPoint anchorPoint = attachment.anchorPoint;
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / kDefaultBounce;
        
        UICollectionViewLayoutAttributes *item = [attachment.items firstObject];
        CGPoint center = item.center;
        center.y += scrollDelta * scrollResistance;
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }
    
    return YES;
}
//------------------------------------------------------------------------------------------------------------

@end
