//
//  CNMainViewController.m
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNMainViewController.h"
#import "CNUserGeoManager.h"
@interface CNMainViewController ()

@end

@implementation CNMainViewController

@synthesize latiText, longtiText, updateGeoBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
