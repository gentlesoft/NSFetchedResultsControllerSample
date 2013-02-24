//
//  CursorView.h
//  NSFetchedResultsControllerSample
//
//  Created by Shinji Kobayashi on 13/02/23.
//  Copyright (c) 2013年 Shinji Kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cursor;
@class ViewController;

@interface CursorView : UIView

@property (nonatomic, readonly) NSArray* colors;
@property (nonatomic) ViewController* controller;
@property (nonatomic) Cursor* cursor;

- (void)refresh;

@end
