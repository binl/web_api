//
//  CNWebAPI.h
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "AFHTTPClient.h"

#import "AFNetworking.h"

typedef void (^JSONResponseBlock)(NSDictionary* json);
@interface CNWebAPI : AFHTTPClient

//the authorized user
@property (strong, nonatomic) NSDictionary* user;

+(CNWebAPI *)sharedInstance;

//check whether there's an authorized user
-(BOOL)isAuthorized;
//send an API command to the server
-(void)postWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;

@end
