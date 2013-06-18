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



@interface CNMainViewController (){
    NSMutableArray *yellsList;
}

@end

@implementation CNMainViewController

@synthesize latiText, longtiText, updateGeoBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Should get data from server:
    yellsList = [[CNDataCentral sharedInstance] yells];
    
    
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
    return 6;//yellsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CNYellsListCell";
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    //(CNYellsListCell *)cell
    
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


#pragma mark - Test actions

-(IBAction)manuelUpdateGeo:(id)sender{
    
    NSNumber *longtNum = [NSNumber numberWithFloat:3.2f];
    NSNumber *latiNum = [NSNumber numberWithFloat:3.2f];
    
    [CNUserGeoManager updateUserGeoWithCoord:[NSArray arrayWithObjects:longtNum, latiNum, nil]];
}

@end
