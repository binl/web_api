//
//  CNNewYellViewController.h
//  api_tester
//
//  Created by Lenix Liu on 13-4-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNFlipsideViewController.h"

@interface CNNewYellViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView* yellText;
@property (weak, nonatomic) id <CNFlipsideViewControllerDelegate> delegate;

- (IBAction)yell:(id)sender;
- (IBAction)cancel:(id)sender;

@end
