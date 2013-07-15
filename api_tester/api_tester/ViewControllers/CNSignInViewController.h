//
//  CNSignInViewController.h
//  api_tester
//
//  Created by Lenix Liu on 13-7-14.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNSignInViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *fldShownName;
@property (strong, nonatomic) IBOutlet UITextField *fldEmail;
@property (strong, nonatomic) IBOutlet UITextField *fldPswd;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
@end
