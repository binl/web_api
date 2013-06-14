//
//  CNMainViewController.h
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNFlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface CNMainViewController : UIViewController
<CNFlipsideViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UITableView *tableYellsList;

@property (strong, nonatomic) IBOutlet UITextField *longtiText;
@property (strong, nonatomic) IBOutlet UITextField *latiText;
@property (strong, nonatomic) IBOutlet UIButton    *updateGeoBtn;

@end
