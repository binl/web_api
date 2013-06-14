//
//  CNDataCentral.m
//  api_tester
//
//  Created by Lenix Liu on 13-6-13.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNDataCentral.h"

@implementation CNDataCentral

@synthesize yells;

+ (CNDataCentral *)sharedInstance {
    static CNDataCentral *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance.yells = [[NSMutableArray alloc] init];
    });
    
    return sharedInstance;
}

@end
