//
//  CNWebAPI.m
//  api_tester
//
//  Created by Lenix Liu on 13-3-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "CNWebAPI.h"
//the web location of the service

@implementation CNWebAPI
@synthesize user;

#pragma mark - Singleton methods
/**
 * Singleton methods
 */
+(CNWebAPI *)sharedInstance
{
    static CNWebAPI *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAPIHost]];
    });
    
    return sharedInstance;
}

-(BOOL)isAuthorized
{
    return [[user objectForKey:@"userID"] intValue]>0;
}

-(void)postWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock
{
    [self setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *apiRequest =
    [self requestWithMethod:@"POST"
                       path:[NSString stringWithFormat:@"%@%@", kAPIPath, [params objectForKey:@"command"]]
                 parameters:params];
    
    NSLog(@"Client: %@", [self description]);
    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest: apiRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success!
        NSLog(@"[WebAPI]Response status code: %d", [[operation response] statusCode]);
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //failure :(
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
    
    [operation start];
}

-(void)getWithCommand:(NSString *)command onCompletion:(JSONResponseBlock)completionBlock
{
    [self setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *apiRequest =
    [self requestWithMethod:@"GET"
                       path:[NSString stringWithFormat:@"%@%@", kAPIPath, command]
                 parameters:nil];
    
    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest: apiRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success!
        NSLog(@"[WebAPI]Response status code: %d", [[operation response] statusCode]);
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //failure :(
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
    
    [operation start];
}


#pragma mark - init
//intialize the API class with the destination host name

-(CNWebAPI *)init
{
    //call super init
    self = [super init];
    
    if (self != nil) {
        //initialize the object
        user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

- (void)saveUser:(NSDictionary *) userInfo {
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"user"];
    [self setUser:userInfo];
}

@end
