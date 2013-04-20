//
//  CNUserGeoManager.h
//  api_tester
//
//  Created by Lenix Liu on 13-4-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNUserGeoManager : NSObject

//+(CNUserGeoManager *)sharedInstance;

+(void)updateUserGeo;
+(void)updateUserGeoWithCoord: (NSArray *)coordinates;
@end
