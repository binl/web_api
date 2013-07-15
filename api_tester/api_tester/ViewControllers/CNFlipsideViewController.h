//
//  CNFlipsideViewController.h
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNFlipsideViewController;

@protocol CNFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(UIViewController *)controller;
@end

@interface CNFlipsideViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField* fldUsername;
@property (strong, nonatomic) IBOutlet UITextField* fldPassword;
@property (weak, nonatomic) id <CNFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
