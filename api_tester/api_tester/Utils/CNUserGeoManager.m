//
//  CNUserGeoManager.m
//  api_tester
//
//  Created by Lenix Liu on 13-4-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNUserGeoManager.h"

#import "CNWebAPI.h"

@implementation CNUserGeoManager

@synthesize locationManager;
@synthesize longitude, latitude;


+(CNUserGeoManager *)sharedInstance {
    static CNUserGeoManager *sharedInstance = nil;

    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[CNUserGeoManager alloc] init];
        sharedInstance->shouldUpdate = YES;
        sharedInstance.locationManager = [[CLLocationManager alloc] init];
        sharedInstance.locationManager.delegate = sharedInstance;
        sharedInstance.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        sharedInstance.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer; // 100 m
        [sharedInstance.locationManager startUpdatingLocation];
    });
    
    return sharedInstance;
}

#pragma mark - Location Delegate

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"in Pause");
    self->shouldUpdate = NO;
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"in Resume");
    self->shouldUpdate = YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"in Update");
    CLLocation *newLocation = [locations objectAtIndex:0];
    self.longitude = [NSNumber numberWithDouble:newLocation.coordinate.longitude];
    self.latitude = [NSNumber numberWithDouble:newLocation.coordinate.latitude];
    [self updateUserGeo];
}

-(void)updateUserGeo{
    //Update geo location
    if (self->shouldUpdate == NO){
        return;
    }
    
    NSArray *coordinate = [NSArray arrayWithObjects:self.longitude, self.latitude, nil];
    NSDictionary* geoInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Point", @"type",
                             coordinate, @"coordinates", nil];
    
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"/geos", APICommand,
                                  [[[CNWebAPI sharedInstance] user] objectForKey:@"userId"], UserID,
                                  geoInfo, UserLocation,
                                  nil];
    NSLog(@"\nParams: %@", params);
    [[CNWebAPI sharedInstance] postWithParams:params
                                 onCompletion:^(NSDictionary *json) {
                                     //result returned
                                     //TODO: Parse the result
                                     NSDictionary* res = json;
                                     
                                     if ([json objectForKey:@"error"]==nil) {
                                         NSLog(@"\n\njson: %@", res);
                                     } else {
                                         NSLog(@"\n\nError: %@", [json description]);
                                         return;
                                     }
                                 }];
}
@end
