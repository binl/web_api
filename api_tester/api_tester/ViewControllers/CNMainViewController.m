//
//  CNMainViewController.m
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNMainViewController.h"
#import "CNUserGeoManager.h"
#import "CNDataCentral.h"


#import "CNYellsListCell.h"

#import "CNWebAPI.h"
#import "CNConstants.h"

@interface CNMainViewController (){
    NSMutableArray *yellsList;
}

@end

@implementation CNMainViewController

@synthesize tableYellsList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    yellsList = [[CNDataCentral sharedInstance] yells];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    // Should get data from server:
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [[[CNWebAPI sharedInstance] user] objectForKey:@"userId"], @"recipient",
                                  nil];
    
    NSLog(@"\n %@", [params description]);
    
    //make the call to the web API
    [[CNWebAPI sharedInstance] getCommand:@"/timelines" WithParams:params
                                onCompletion:^(NSDictionary *json) {
                                    //result returned
                                    //TODO: Parse the result
                                    NSDictionary* res = json;
                                    
                                    if ([json objectForKey:@"error"]==nil) {
                                        NSLog(@"json: %@", res);
                                        yellsList = [res objectForKey:@"timelines"];
                                        [self.tableYellsList reloadData];
                                    } else {
                                        NSLog(@"Error: %@", [json description]);
                                        return;
                                    }
                                }];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 106;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return yellsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CNYellsListCell";
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [[(CNYellsListCell *)cell lblYellContent]
     setText:[[[yellsList objectAtIndex:indexPath.row]
               objectForKey:@"yell"] objectForKey:@"content"]];
    
    [[(CNYellsListCell *)cell lblYellerName]
     setText:[[[[yellsList objectAtIndex:indexPath.row]
               objectForKey:@"yell"] objectForKey:@"user"] objectForKey:@"name"]];
    
    NSString *imageName = [[[[yellsList objectAtIndex:indexPath.row]objectForKey:@"yell"]
                            objectForKey:@"user"] objectForKey:@"avatar"];
    
    [[(CNYellsListCell *)cell imgAuthor]
     setImage:[UIImage imageNamed:[NSString stringWithFormat:@"defaultPic-%@.png", imageName]]];
    return cell;

}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(CNFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setDelegate:self];
}


@end
