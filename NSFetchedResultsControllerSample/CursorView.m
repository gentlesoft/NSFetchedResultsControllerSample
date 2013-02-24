//
//  CursorView.m
//  NSFetchedResultsControllerSample
//
//  Created by Shinji Kobayashi on 13/02/23.
//  Copyright (c) 2013年 Shinji Kobayashi. All rights reserved.
//

#import "CursorView.h"
#import "Cursor.h"
#import "ViewController.h"

@interface CursorView() <UIGestureRecognizerDelegate>

@end

@implementation CursorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _colors = @[[UIColor blackColor], [UIColor redColor], [UIColor greenColor]
                    , [UIColor blueColor], [UIColor grayColor], [UIColor orangeColor]];
        
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handleLongPressGesture:)];
        longPress.minimumPressDuration = 0.05;
        longPress.delegate = self;
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)refresh {
    if (self.cursor == nil)
        [self removeFromSuperview];
    
    self.center = CGPointMake(self.cursor.x.floatValue, self.cursor.y.floatValue);
    self.backgroundColor = [self.colors objectAtIndex:self.cursor.color.intValue];
}

- (IBAction)handleLongPressGesture:(UILongPressGestureRecognizer *)recognizer {
    CGPoint pos = [self convertPoint:[recognizer locationInView:self] toView:self.superview];
    switch ((int)recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.controller.currentView = self;
            self.cursor.timeStamp = [NSDate date];
            break;
            
        case UIGestureRecognizerStateChanged:
            self.cursor.x = @(pos.x);
            self.cursor.y = @(pos.y);
            break;
            
        case UIGestureRecognizerStateEnded:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
