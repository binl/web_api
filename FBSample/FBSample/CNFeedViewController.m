//
//  CNFeedViewController.m
//  FBSample
//
//  Created by Lenix Liu on 13-3-20.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNAppDelegate.h"

#import "CNFeedViewController.h"
#import "CNFBLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface CNFeedViewController ()

-(void)showLoginScreen;

@end

@implementation CNFeedViewController
@synthesize tblFeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Logout"
                                              style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(logoutButtonWasPressed:)];
    
    BOOL isLoggedIn = (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded);
    
    if(isLoggedIn) {
        CNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate openSession];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithTitle:@"Logout"
                                                  style:UIBarButtonItemStyleBordered
                                                  target:self
                                                  action:@selector(logoutButtonWasPressed:)];
        return;
    }
    else {
        [self showLoginScreen];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login procedures
-(void)showLoginScreen{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CNFBLoginViewController *loginView = [storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
    [self presentViewController:loginView animated:YES completion:nil];
}

#pragma mark - FB session
-(void)logoutButtonWasPressed:(id)sender {
    [self showLoginScreen];
    [FBSession.activeSession closeAndClearTokenInformation];
}

@end
