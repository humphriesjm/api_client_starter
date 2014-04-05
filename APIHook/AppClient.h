//
//  AppClient.h
//  APIHook
//
//  Created by Jason Humphries on 4/5/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "AFHTTPSessionManager.h"

// set your base api url
#define API_BASE_URL @"http://api.example.com"

@interface AppClient : AFHTTPSessionManager

+ (id)sharedClient;

// GET STUFF FROM SERVER
-(void)getServerStuff:(void (^)(NSArray*))success
              failure:(void (^)(NSError *error))failure;

// POST STUFF TO SERVER
- (void)postStuffToServer:(NSString*)data
                  success:(void (^)(NSDictionary*))success
                  failure:(void (^)(NSError *error))failure;

@end
