//
//  Cursor.h
//  NSFetchedResultsControllerSample
//
//  Created by Shinji Kobayashi on 13/02/23.
//  Copyright (c) 2013年 Shinji Kobayashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cursor : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * color;

@end
