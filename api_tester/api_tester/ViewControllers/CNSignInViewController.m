//
//  CNSignInViewController.m
//  api_tester
//
//  Created by Lenix Liu on 13-7-14.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNSignInViewController.h"

#import "CNUserGeoManager.h"
#import "CNWebAPI.h"
#include <CommonCrypto/CommonDigest.h>

#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"

#define CONTENT_WIDTH 200
#define PAGE_PADDING 30

@interface CNSignInViewController () {
    int currentPic;
}

@end

@implementation CNSignInViewController

@synthesize fldEmail, fldPswd, fldShownName;
@synthesize scrlImageSelect;

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
    
    // a page is the width of the scroll view
    NSUInteger numberPages = 6; //6 default pictures
    
    self.scrlImageSelect.pagingEnabled = YES;
    self.scrlImageSelect.contentSize =
    CGSizeMake((CONTENT_WIDTH + PAGE_PADDING)* numberPages
               , CGRectGetHeight(self.scrlImageSelect.frame));
    self.scrlImageSelect.showsHorizontalScrollIndicator = NO;
    self.scrlImageSelect.showsVerticalScrollIndicator = NO;
    self.scrlImageSelect.scrollsToTop = NO;
    self.scrlImageSelect.delegate = self;
    self.scrlImageSelect.contentOffset = CGPointMake(0, 0);
    for (UIView *subview in self.scrlImageSelect.subviews) {
        [subview removeFromSuperview];
    }
    
    for (int i = 0; i < 6 ; i++) {
        [self loadScrollViewWithPage:i];
    }
    
    currentPic = 0;
}

- (void) viewWillAppear:(BOOL)animated {
    [self.fldEmail becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll view related

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= 6)
        return;
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"defaultPic-%d.png", page]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    CGRect frame;
    frame.origin.x = PAGE_PADDING/2 + (CONTENT_WIDTH + PAGE_PADDING) * page;
    frame.origin.y = 0;
    frame.size.width = CONTENT_WIDTH;
    frame.size.height = CONTENT_WIDTH;
    imgView.frame = frame;
    
    [self.scrlImageSelect addSubview:imgView];
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    NSUInteger page = floor((self.scrlImageSelect.contentOffset.x - CONTENT_WIDTH / 2) / CONTENT_WIDTH) + 1;
    currentPic = page;
    // a possible optimization would be to unload the views+controllers which are no longer visible
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
                                  fldShownName.text, @"username",
                                  fldEmail.text, @"email",
                                  [NSString stringWithFormat:@"%d", currentPic], @"avatar",
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
                                         [CNUserGeoManager sharedInstance];
                                         [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)nextStep:(id)sender {
    [self.fldEmail resignFirstResponder];
    [self.fldPswd resignFirstResponder];
    [self.fldShownName resignFirstResponder];
}

#pragma mark - textField delegate
- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
}

@end
