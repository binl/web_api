//
//  CNUserGeoManager.h
//  api_tester
//
//  Created by Lenix Liu on 13-4-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CNUserGeoManager : NSObject
<CLLocationManagerDelegate> {
    BOOL shouldUpdate;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;

+(CNUserGeoManager *)sharedInstance;
@end
