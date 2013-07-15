//
//  CNDataCentral.h
//  api_tester
//
//  Created by Lenix Liu on 13-6-13.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNDataCentral : NSObject

//current user
@property (strong, nonatomic) NSDictionary* user;
@property (strong, nonatomic) NSMutableArray* yells;

+(CNDataCentral *)sharedInstance;

@end
