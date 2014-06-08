//
//  DJDAPIController.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDAPIController.h"

NSString* const apiRoot = @"http://beta.myjam.co:3000";

@implementation DJDAPIController


-(NSString*)api:(NSString*)path {
    return [NSString stringWithFormat:@"%@/%@", apiRoot, path];
}



-(void)upvoteSong:(DJDSong*)song withPin:(NSString*)pin {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSDictionary *params = @{
                             @"pin": pin,
                             @"song": [song jsonValue]
                            };
    
    [manager POST:[self api:@"upvote"]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Upvoted!");
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Upvote failed! %@", error.description);
              
          }
     ];
    
}



-(void)downvoteSong:(DJDSong*)song withPin:(NSString*)pin {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSDictionary *params = @{
                             @"pin": pin,
                             @"song": [song jsonValue]
                            };
    
    [manager POST:[self api:@"downvote"]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"Downvoted!");
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Downvote failed: %@", [error description]);
              
          }
     ];
    
}



-(void)updatePlaylist:(NSArray*)songs withPin:(NSString*)pin {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSMutableArray *jsonSongs = [NSMutableArray array];
    for (DJDSong* song in songs) {
        [jsonSongs addObject:[song jsonValue]];
    }
    
    NSDictionary *params = @{
                             @"pin": pin,
                             @"songs": jsonSongs
                            };
    
    NSLog(@"Sending songs: %@", jsonSongs);
    
    [manager POST:[self api:@"playlist"]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSArray *json = (NSArray*)responseObject;
              NSLog(@"Got playlist: %@", json);
              
              for (NSDictionary* jsong in json) {
                  DJDSong *song = [DJDSong songWithJSON:jsong];
                  [self.playlist addSong:song];
              }
              
              [[NSNotificationCenter defaultCenter] postNotificationName:@"DJDPlaylistUpdatedNotification" object:nil];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Playlist upload failed!");
              
          }
     ];

}


@end
