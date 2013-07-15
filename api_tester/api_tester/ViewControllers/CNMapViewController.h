//
//  CNMapViewController.h
//  api_tester
//
//  Created by Lenix Liu on 13-6-13.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNMapViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *radarAnime;
@property (nonatomic, strong) IBOutlet UIImageView *radarAnime2;
@property (nonatomic, strong) IBOutlet UIImageView *radarAnime3;

-(void)animateView:(UIView *)view WithDelay:(CGFloat)delay;
@end
