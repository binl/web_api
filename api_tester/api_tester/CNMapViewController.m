//
//  CNMapViewController.m
//  api_tester
//
//  Created by Lenix Liu on 13-6-13.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNMapViewController.h"

@interface CNMapViewController ()

@end

@implementation CNMapViewController

@synthesize radarAnime, radarAnime2, radarAnime3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self animateView:self.radarAnime WithDelay:0];
    [self animateView:self.radarAnime2 WithDelay:1.0];
    [self animateView:self.radarAnime3 WithDelay:2.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animateView:(UIView *)view WithDelay:(CGFloat)delay {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:3
                                  delay:delay
                                options:UIViewAnimationOptionRepeat
                             animations:^{
                view.frame = CGRectMake(-10, 40, 340, 340);
                view.alpha = 0; }
                             completion:^(BOOL finished){
                                 view.frame = CGRectMake(73, 123, 175, 175);
                                 view.alpha = 1;
                             }];
        });
}

@end
