//
//  CNMainViewController.h
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNFlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface CNMainViewController : UIViewController <CNFlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
