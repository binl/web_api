//
//  CNFlipsideViewController.m
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNFlipsideViewController.h"

#import "CNWebAPI.h"
#include <CommonCrypto/CommonDigest.h>

#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"
@interface CNFlipsideViewController ()

@end

@implementation CNFlipsideViewController
@synthesize fldPassword, fldUsername;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [fldUsername becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    //form fields validation
    if (fldUsername.text.length < 4 || fldPassword.text.length < 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"too short" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //salt the password
    NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", fldPassword.text, kSalt];
    
    //prepare the hashed storage
    NSString* hashedPassword = nil;
    unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
    
    //hash the pass
    NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
    if (CC_SHA1([data bytes], [data length], hashedPasswordData)) {
        hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
    } else {
        NSLog(@"Pswd error");
        return;
    }
    
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    //check whether it's a login or register
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"/users", APICommand,
                                  deviceId, SignInIdentifier,
                                  fldUsername.text, SignInName,
                                  hashedPassword, SignInToken,
                                  @"NONE", SignInSNS,
                                  @"dummyUser1", @"username",
                                  @"dummy1@user.com", @"email",
                                  nil];
    
    //make the call to the web API
    [[CNWebAPI sharedInstance] postWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //result returned
                                   //TODO: Parse the result
                                   NSDictionary* res = json;
                                   
                                   if ([json objectForKey:@"error"]==nil) {
                                       NSLog(@"\n\njson: %@", res);
                                       [[CNWebAPI sharedInstance] saveUser: res];
                                       
                                       //show message to the user
                                       [[[UIAlertView alloc] initWithTitle:@"Logged in"
                                                                   message:[NSString stringWithFormat:@"Welcome %@",[res objectForKey:@"username"] ]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"Close"
                                                         otherButtonTitles: nil] show];
                                       [self.delegate flipsideViewControllerDidFinish:self];
                                   } else {
                                       //error
                                       NSLog(@"\n\nError: %@", [json description]);
                                       return;
                                   }
                               }];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}


@end
