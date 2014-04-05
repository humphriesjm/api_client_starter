//
//  ViewController.m
//  APIHook
//
//  Created by Jason Humphries on 4/5/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "ViewController.h"
#import "AppClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)getServerStuffAction:(id)sender
{
    // GET /server_stuff
    [[AppClient sharedClient] getServerStuff:
     ^(NSArray *response) {
         NSLog(@"SERVER GET RESPONSE: %@", response);
     } failure:^(NSError *error) {
         NSLog(@"SERVER GET FAIL: %@", error.localizedDescription);
     }];

}

- (IBAction)postServerStuffAction:(id)sender
{
    // POST /server_stuff
    [[AppClient sharedClient] postStuffToServer:@"hello server"
                                        success:
     ^(NSDictionary *responseDict) {
         NSLog(@"SERVER POST SUCCESS: %@", responseDict);
     } failure:^(NSError *error) {
         NSLog(@"SERVER POST FAIL: %@", error.localizedDescription);
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
