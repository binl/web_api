//
//  CNSignInViewController.m
//  api_tester
//
//  Created by Lenix Liu on 13-7-14.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNSignInViewController.h"

#import "CNWebAPI.h"
#include <CommonCrypto/CommonDigest.h>

#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"

@interface CNSignInViewController ()

@end

@implementation CNSignInViewController

@synthesize fldEmail, fldPswd, fldShownName;

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
    // Do any additional setup after loading the view from its nib.
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
    if (fldShownName.text.length < 4 || fldPswd.text.length < 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"too short" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //salt the password
    NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", fldPswd.text, kSalt];
    
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
                                  fldShownName.text, SignInName,
                                  hashedPassword, SignInToken,
                                  @"NONE", SignInSNS,
                                  fldEmail, @"username",
                                  fldEmail, @"email",
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
                                         //Now that the user has signed in
                                         //Show image picker and set the user
                                         
                                         
                                     } else {
                                         //error
                                         NSLog(@"\n\nError: %@", [json description]);
                                         return;
                                     }
                                 }];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
