//
//  CNFBLoginViewController.h
//  FBSample
//
//  Created by Lenix Liu on 13-3-20.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNFBLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *fldUsername;
@property (strong, nonatomic) IBOutlet UITextField *fldPassword;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ldgvLogin;

-(IBAction)performLogin:(id)sender;

@end
