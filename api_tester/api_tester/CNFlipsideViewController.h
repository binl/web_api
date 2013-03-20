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
- (void)flipsideViewControllerDidFinish:(CNFlipsideViewController *)controller;
@end

@interface CNFlipsideViewController : UIViewController

@property (weak, nonatomic) id <CNFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
