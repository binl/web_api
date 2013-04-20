//
//  CNAppDelegate.h
//  FBSample
//
//  Created by Lenix Liu on 13-3-20.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNFeedViewController.h"

@interface CNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) CNFeedViewController *mainViewController;

-(void)openSession;
@end
