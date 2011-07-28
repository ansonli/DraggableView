//
//  DraggableScrollviewAppDelegate.h
//  DraggableScrollview
//
//  Created by Botang Li on 11-07-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DraggableViewController;

@interface DraggableViewAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DraggableViewController *viewController;

@end
