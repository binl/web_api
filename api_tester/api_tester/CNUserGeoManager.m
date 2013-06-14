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

+(void)updateUserGeo{
    NSDictionary* geoInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Point", @"type",
                             [NSArray arrayWithObjects:[NSNumber numberWithFloat:-79.9961], [NSNumber numberWithFloat:40.4406], nil], @"coordinates"
                             , nil];
    
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"/geos", APICommand,
                                  [[[CNWebAPI sharedInstance] user] objectForKey:@"userID"], UserID,
                                  geoInfo, UserLocation,
                                  nil];
    
    //make the call to the web API
    [[CNWebAPI sharedInstance] postWithParams:params
                                 onCompletion:^(NSDictionary *json) {
                                     NSDictionary* res = json;
                                     
                                     if ([json objectForKey:@"error"]==nil) {
                                         NSLog(@"json: %@", res);
                                         return;
                                     } else {
                                         //error
                                         NSLog(@"Error: %@", [json description]);
                                         return;
                                     }
                                 }];

}

+(void)updateUserGeoWithCoord: (NSArray *)coordinates{
    NSDictionary* geoInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Point", @"type",
                             coordinates, @"coordinates"
                             , nil];
    
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"/geos", APICommand,
                                  [[[CNWebAPI sharedInstance] user] objectForKey:@"userID"], UserID,
                                  geoInfo, UserLocation,
                                  nil];
    
    //make the call to the web API
    [[CNWebAPI sharedInstance] postWithParams:params
                                 onCompletion:^(NSDictionary *json) {
                                     NSDictionary* res = json;
                                     
                                     if ([json objectForKey:@"error"]==nil) {
                                         NSLog(@"json: %@", res);
                                         return;
                                     } else {
                                         //error
                                         NSLog(@"Error: %@", [json description]);
                                         return;
                                     }
                                 }];
    
    [[CNWebAPI sharedInstance] getWithCommand:@"/timelines" onCompletion:^(NSDictionary *json) {
        NSDictionary* res = json;
        NSLog(@"json: %@", res);
        }];
    
}

@end
