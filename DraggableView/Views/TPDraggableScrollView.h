//
//  TPDraggableScrollview.h
//  DraggableScrollview
//
//  Created by Botang Li on 11-07-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDraggableItemView.h"

@interface TPDraggableScrollView : UIScrollView<TPDraggableItemDelegate> {
    TPDraggableItemView *movingItem;
    
    int first_position;
    int drag_position;
    int replace_position;
    int item_count;
    
    float animationDuration;
    
    int numberOfItemsInRow, numberOfRowsInPage;
    
    BOOL isAnimating;
}

@property(nonatomic, assign) int numberOfItemsInRow, numberOfRowsInPage;

- (void)animateItems;
- (int)numberOfDraggableItems;

@end
