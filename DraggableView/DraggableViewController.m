//
//  DraggableScrollviewViewController.m
//  DraggableScrollview
//
//  Created by Botang Li on 11-07-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DraggableViewController.h"
#import "TPDraggableItemView.h"

@implementation DraggableViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initScrollView];
}

- (void)initScrollView {
    int row = 0, col = 0;
    int box_width = 80, box_height = 80;
    int border = 10;
    
    float width = box_width + border*2;
    float height = box_height + border*2;
    
    int numberOfItemsInRow = self.view.bounds.size.width / width;
    
    scrollView = [[TPDraggableScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.numberOfItemsInRow = numberOfItemsInRow;
    
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    [scrollView release];    
    
    for (int i = 0; i<11; i++) {
        CGRect rect = CGRectMake(row * width + border, col * height + border, box_width, box_height);
        TPDraggableItemView *itemView = [[TPDraggableItemView alloc] initWithFrame:rect];
        
        itemView.delegate = scrollView;
        itemView.tag = i + 1; //avoid assigning 0
        itemView.label.text = [NSString stringWithFormat:@"%d", i + 1];
        itemView.borderWidth = border;
        [itemView setDraggingEnabled:YES];
        
        [scrollView addSubview:itemView];
        [itemView release];
        
        row++;
        if (row == scrollView.numberOfItemsInRow) {
            row = 0;
            col++;
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
