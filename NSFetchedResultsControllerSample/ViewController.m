//
//  ViewController.m
//  NSFetchedResultsControllerSample
//
//  Created by Shinji Kobayashi on 13/02/23.
//  Copyright (c) 2013年 Shinji Kobayashi. All rights reserved.
//

#import "ViewController.h"
#import "CursorView.h"
#import "Cursor.h"

@interface ViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView* screen;

- (IBAction)addButtonPress:(id)sender;
- (IBAction)colorButtonPress:(id)sender;
- (IBAction)truchButtonPress:(id)sender;

@end


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for (Cursor* cursor in self.fetchedResultsController.fetchedObjects) {
        [self addCursorView:cursor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonPress:(id)sender {
    Cursor* cursor = [NSEntityDescription insertNewObjectForEntityForName:@"Cursor"
                                                   inManagedObjectContext:self.managedObjectContext];
    cursor.x = @(self.screen.bounds.size.width / 2.0f);
    cursor.y = @(self.screen.bounds.size.height / 2.0f);
    cursor.timeStamp = [NSDate date];
}

- (IBAction)colorButtonPress:(id)sender {
    Cursor* cursor = self.currentView.cursor;
    if (cursor == nil)
        return;

    cursor.color = @(cursor.color.intValue + 1);
    if (cursor.color.intValue >= self.currentView.colors.count)
        cursor.color = @(0);
}

- (IBAction)truchButtonPress:(id)sender {
    Cursor* cursor = self.currentView.cursor;
    if (cursor == nil)
        return;

    [self.managedObjectContext deleteObject:cursor];
}

- (void)addCursorView:(Cursor*)cursor {
    CursorView* view= [[CursorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.screen addSubview:view];
    
    view.controller = self;
    view.cursor = cursor;
    self.currentView = view;
    
    [view refresh];
}

- (NSFetchedResultsController*)fetchedResultsController {
    if (_fetchedResultsController != nil)
        return _fetchedResultsController;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Cursor"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:YES]];
        
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                    managedObjectContext:self.managedObjectContext
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:@"cursor"];
    _fetchedResultsController.delegate = self;
    [_fetchedResultsController performFetch:nil];
    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self addCursorView:anObject];
            break;
            
        case NSFetchedResultsChangeDelete: {
            [[self.screen.subviews objectAtIndex:indexPath.row] removeFromSuperview];
            break;
        }
            
        case NSFetchedResultsChangeUpdate:
            [(CursorView*)[self.screen.subviews objectAtIndex:indexPath.row] refresh];
            break;
            
        case NSFetchedResultsChangeMove: {
            [self.screen insertSubview:[self.screen.subviews objectAtIndex:indexPath.row] atIndex:newIndexPath.row];
            break;
        }
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
}


@end

