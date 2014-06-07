//
//  DJDAPIController.h
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AFNetworking/AFNetworking.h>
#import "DJDSong.h"

extern NSString* const apiRoot;

@interface DJDAPIController : NSObject

-(void)upvote:(DJDSong*)track;
-(void)downvote:(DJDSong*)track;
-(void)playlist:(NSArray*)songs;

@end
