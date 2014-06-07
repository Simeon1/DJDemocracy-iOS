//
//  DJDAPIController.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDAPIController.h"

NSString* const apiRoot = @"http://myjam.co:8080";

@implementation DJDAPIController


-(NSString*)api:(NSString*)path {
    return [NSString stringWithFormat:@"%@/%@", apiRoot, path];
}



-(void)upvote:(DJDSong*)song {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *params = @{ @"song" : [song jsonValue] };
    
    [manager POST:[self api:@"upvote"]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Upvoted!");
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Upvote failed!");
              
          }
     ];
    
}



-(void)downvote:(DJDSong*)song {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *params = @{ @"song" : song };
    
    [manager POST:[self api:@"downvote"]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Downvoted!");
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Downvote failed!");
              
          }
     ];
    
}



-(void)playlist:(NSArray*)songs {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *params = @{ @"songs" : songs };
    
    [manager POST:[self api:@"addsongs"]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Playlist uploaded!");
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Playlist upload failed!");
              
          }
     ];

}


@end
