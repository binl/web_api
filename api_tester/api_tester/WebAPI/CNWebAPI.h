//
//  CNWebAPI.h
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "AFHTTPClient.h"

#import "AFNetworking.h"
#import "CNConstants.h"

typedef void (^JSONResponseBlock)(NSDictionary* json);
@interface CNWebAPI : AFHTTPClient

//the authorized user
@property (strong, nonatomic) NSDictionary* user;

+(CNWebAPI *)sharedInstance;

//check whether there's an authorized user
-(BOOL)isAuthorized;
-(void)saveUser:(NSDictionary *) userInfo;
//send an API command to the server
-(void)postWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;
-(void)getWithCommand:(NSString *)command onCompletion:(JSONResponseBlock)completionBlock;
@end
