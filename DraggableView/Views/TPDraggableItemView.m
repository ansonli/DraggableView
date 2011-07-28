//
//  TPDraggableItemView.m
//  DraggableScrollview
//
//  Created by Botang Li on 11-07-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TPDraggableItemView.h"

@implementation TPDraggableItemView
@synthesize delegate = _delegate;
@synthesize label, borderWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.borderWidth = 5;
        
        label = [[UILabel alloc] initWithFrame:self.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        [label release];
    }
    return self;
}

- (void)setDraggingEnabled:(BOOL)enabled {
    self.userInteractionEnabled = enabled;
    self.multipleTouchEnabled = enabled;
    isDraggable = enabled;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isDraggable) return;
    
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.superview];
        
        startPoint = point;
        
        [self.delegate draggableItem:self didStartAtPoint:point];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isDraggable) return;
    
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.superview];
        
        CGPoint offset = CGPointMake(point.x - startPoint.x, point.y - startPoint.y);
        
        point = self.frame.origin;
        point.x += self.bounds.size.width / 2;
        point.y += (self.bounds.size.height + self.borderWidth * 2) /2;
        
        self.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
        
        [self.delegate draggableItem:self didMoveToPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isDraggable) return;
    
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.superview];
        
        [self.delegate draggableItem:self didStopAtPoint:point];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isDraggable) return;
    
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.superview];
        
        [self.delegate draggableItem:self didStopAtPoint:point];
    }
}

@end
