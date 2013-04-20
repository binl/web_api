//
//  CNFBLoginViewController.m
//  FBSample
//
//  Created by Lenix Liu on 13-3-20.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNFBLoginViewController.h"
#import "CNAppDelegate.h"

@interface CNFBLoginViewController ()

@end

@implementation CNFBLoginViewController
@synthesize fldUsername, fldPassword, ldgvLogin;

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
    
    [fldUsername becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(IBAction)performLogin:(id)sender {
    [self.ldgvLogin startAnimating];
    
    CNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
    return;
}

@end
