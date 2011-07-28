//
//  TPDraggableItemView.h
//  DraggableScrollview
//
//  Created by Botang Li on 11-07-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPDraggableItemView;

@protocol TPDraggableItemDelegate <NSObject>

- (void)draggableItem:(TPDraggableItemView *)item didStartAtPoint:(CGPoint)point;
- (void)draggableItem:(TPDraggableItemView *)item didMoveToPoint:(CGPoint)point;
- (void)draggableItem:(TPDraggableItemView *)item didStopAtPoint:(CGPoint)point;

@end

@interface TPDraggableItemView : UIView {
    BOOL isDraggable;
    CGPoint startPoint;
    UILabel *label;
}

@property(nonatomic, readonly) UILabel *label;
@property(nonatomic, assign) float borderWidth;
@property(nonatomic, assign) id<TPDraggableItemDelegate> delegate;

- (void)setDraggingEnabled:(BOOL)enabled;

@end
