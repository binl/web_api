//
//  CNNewYellViewController.m
//  api_tester
//
//  Created by Lenix Liu on 13-4-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNNewYellViewController.h"

#import "CNWebAPI.h"
#import "CNUserGeoManager.h"

@interface CNNewYellViewController ()

@end

@implementation CNNewYellViewController

@synthesize yellText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions

- (IBAction)yell:(id)sender {
    //form fields validation
    if (yellText.text.length < 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"too short" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSArray *coordinate = [NSArray arrayWithObjects:[NSNumber numberWithFloat:40.2222], [NSNumber numberWithFloat:40.2222], nil];
    NSDictionary* geoInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Point", @"type",
                             coordinate, @"coordinates", nil];
    
    
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"/yells", APICommand,
                                  [[[CNWebAPI sharedInstance] user] objectForKey:@"userID"], UserID,
                                  yellText.text, YellContent,
                                  [NSNumber numberWithInt:1000], YellRadius,
                                  geoInfo, UserLocation,
                                  nil];
    
    //make the call to the web API
    [[CNWebAPI sharedInstance] postWithParams:params
                                 onCompletion:^(NSDictionary *json) {
                                     //result returned
                                     //TODO: Parse the result
                                     NSDictionary* res = json;
                                     
                                     if ([json objectForKey:@"error"]==nil) {
                                         NSLog(@"json: %@", res);
                                         [CNUserGeoManager updateUserGeoWithCoord:coordinate];

                                         [self.delegate flipsideViewControllerDidFinish:self];
                                     } else {
                                         //error
                                         NSLog(@"Error: %@", [json description]);
                                         return;
                                     }
                                 }];

}


- (IBAction)cancel:(id)sender {
   [self.delegate flipsideViewControllerDidFinish:self]; 
}



@end
