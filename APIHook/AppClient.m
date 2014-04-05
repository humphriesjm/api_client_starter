//
//  AppClient.m
//  APIHook
//
//  Created by Jason Humphries on 4/5/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "AppClient.h"

static AppClient *sharedClient;

@implementation AppClient

- (id)init
{
    if (self = [super init]) {
        NSURL *baseURL = [NSURL URLWithString:API_BASE_URL];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSDictionary *headers = @{ @"Accept"       : @"application/json",
                                   @"Content-Type" : @"application/json" };
        [config setHTTPAdditionalHeaders:headers];
        self = [[AppClient alloc] initWithBaseURL:baseURL
                             sessionConfiguration:config];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        // set custom header values
//        [self.requestSerializer setValue:USER_ID forHTTPHeaderField:@"x-user-id"];
        // set response serializer to work better with JSON
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    return self;
}

+ (id)sharedClient
{
    if (!sharedClient) {
        sharedClient = [[self alloc] init];
    }
    return sharedClient;
}

#pragma mark - GET STUFF FROM SERVER

- (void)getServerStuff:(void (^)(NSArray *))success
               failure:(void (^)(NSError *))failure
{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/server_stuff";
    AppClient *client = [AppClient sharedClient];
    // paging header values
//    [client.requestSerializer setValue:@"1" forHTTPHeaderField:@"x-page"];
//    [client.requestSerializer setValue:@"20" forHTTPHeaderField:@"x-per-page"];
    [client GET:path
     parameters:nil
        success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         NSAssert(httpResponse, @"httpRespone should not be nil");
         NSAssert(httpResponse.statusCode == 200, @"http response status code should be 200 (OK)");
         NSLog(@"API GET Server Stuff SUCCESS: %@", responseObject);
         if (success) success(responseObject);
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"API GET Server Stuff FAILED: %@", error.localizedDescription);
         if (failure) failure(error);
     }];
}

#pragma mark - POST STUFF TO SERVER

- (void)postStuffToServer:(NSString *)data
                  success:(void (^)(NSDictionary *))success
                  failure:(void (^)(NSError *))failure
{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/server_stuff";
    NSDictionary *params = @{ @"data_param" : data };
    AppClient *client = [AppClient sharedClient];
    // custom headers and paging
//    [client.requestSerializer setValue:@"1" forHTTPHeaderField:@"x-page"];
//    [client.requestSerializer setValue:@"20" forHTTPHeaderField:@"x-per-page"];
    [client POST:path
      parameters:params
         success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         NSAssert(httpResponse, @"httpRespone should not be nil");
         NSAssert(httpResponse.statusCode == 200, @"http response status code should be 200 (OK)");
         NSLog(@"API POST SUCCESS: %@", responseObject);
         if (success) success(responseObject);
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"API POST FAILED: %@", error.localizedDescription);
         if (failure) failure(error);
     }];
}


@end
