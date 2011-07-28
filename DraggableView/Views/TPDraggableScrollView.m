//
//  TPDraggableScrollview.m
//  DraggableScrollview
//
//  Created by Botang Li on 11-07-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TPDraggableScrollview.h"

@implementation TPDraggableScrollView
@synthesize numberOfItemsInRow, numberOfRowsInPage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        drag_position = -1;
        replace_position = -1;
        
        numberOfItemsInRow = 6;
        numberOfRowsInPage = 10;
        animationDuration = .4;
    }
    return self;
}

#pragma mark - dragging delegate methods
- (void)layoutDraggableItems {
    int row, col, i;
    
    for (TPDraggableItemView *item in self.subviews) {
        if (![item isKindOfClass:[TPDraggableItemView class]]) continue;
        
        // ignore dragging item
        if (item.tag > item_count) continue;
        
        float width = item.frame.size.width;
        float height = item.frame.size.height;
        
        i = item.tag;
        // items shift position between replacing and dragging box positions
        if ( i >= replace_position && i < drag_position && drag_position > replace_position) i++;
        else if ( i > drag_position && i <= replace_position  && drag_position < replace_position) i--;
        
        row = i % numberOfItemsInRow;
        col = i / numberOfItemsInRow;
        if (row == 0 && col > 0) {
            row = numberOfItemsInRow;
            col--;
        }
        
        if(row > 0) row--;
            
        [UIView animateWithDuration:animationDuration delay:0
                            options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             item.frame = CGRectMake(row * (width + item.borderWidth * 2) + item.borderWidth, col * (height + item.borderWidth * 2) + item.borderWidth, width, height);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        item.tag = i;
    }   
    
    drag_position = replace_position;
}

- (void)animateItems {
    [self layoutDraggableItems];
}
                      
#pragma mark - drag items
- (void)draggableItem:(TPDraggableItemView *)item didStartAtPoint:(CGPoint)point {
    [self bringSubviewToFront:item];
    
    item_count = [self numberOfDraggableItems];
    movingItem = item;
    drag_position = item.tag;
    
    // mark dragging item
    item.tag = self.subviews.count + 1;
    
    replace_position = drag_position;
    first_position = replace_position;
}

- (void)draggableItem:(TPDraggableItemView *)item didMoveToPoint:(CGPoint)point {
    CGSize itemSize = item.frame.size;
    
    int num_col = item_count / numberOfItemsInRow;
    int mod = item_count % numberOfItemsInRow;
    if (mod > 0) num_col++;  
    
    int row = (int)point.x / (itemSize.width + item.borderWidth * 2) + 1; 
    int col = 0;
    
    // content boundary, [0, 0, content_w, content_h]
    int content_h = num_col * (itemSize.height + item.borderWidth * 2);
    
    // inside the content boundary
    if (point.y > 0 && point.y < content_h) {
        col = (int) point.y / (itemSize.height + item.borderWidth * 2);
        
        int position = row + col * numberOfItemsInRow;
        
        if (position != replace_position && position <= item_count) {
            replace_position = position;
            
            [self animateItems];
        }
    }
    else { // outside conent boundary
        replace_position = first_position;
        
        [self animateItems];
    }
}

- (void)draggableItem:(TPDraggableItemView *)item didStopAtPoint:(CGPoint)point {    
    item_count = [self numberOfDraggableItems];
    
    // move dragging item to the target position
    // re-position all boxes
    [UIView animateWithDuration:.3 animations:^{
        item.transform = CGAffineTransformIdentity;
        item.tag = replace_position;
        
        int i, row = 0, col = 0;
        float width = item.frame.size.width;
        float height = item.frame.size.height;
        
        for (i=1; i<=item_count; i++) {
            TPDraggableItemView *itemView = (TPDraggableItemView *)[self viewWithTag:i];
            
            itemView.frame = CGRectMake(row * (width + item.borderWidth * 2) + item.borderWidth, col * (height + itemView.borderWidth * 2) + item.borderWidth, width, height);
            
            row++;
            if (row == numberOfItemsInRow) {
                row = 0;
                col++;
            }
        }
        
        // reset all positions
        drag_position = -1;
        replace_position = -1;
        first_position = -1;
    }];
}

- (int)numberOfDraggableItems {
    int num = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[TPDraggableItemView class]])
            num++;
    }
    return num;
}

@end
