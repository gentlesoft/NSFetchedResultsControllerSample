//
//  ViewController.h
//  NSFetchedResultsControllerSample
//
//  Created by Shinji Kobayashi on 13/02/23.
//  Copyright (c) 2013年 Shinji Kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CursorView;

@interface ViewController : UIViewController

@property (nonatomic) NSManagedObjectContext* managedObjectContext;
@property (nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, weak) CursorView* currentView;

@end
