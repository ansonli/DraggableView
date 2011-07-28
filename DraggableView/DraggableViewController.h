//
//  DraggableScrollviewViewController.h
//  DraggableScrollview
//
//  Created by Botang Li on 11-07-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDraggableScrollview.h"

@interface DraggableViewController : UIViewController {
    TPDraggableScrollView *scrollView;
}

- (void)initScrollView;

@end
