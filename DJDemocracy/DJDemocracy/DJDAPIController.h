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
#import "DJDPlaylist.h"

extern NSString* const apiRoot;

@interface DJDAPIController : NSObject

@property (nonatomic, weak) DJDPlaylist* playlist;

-(void)upvoteSong:(DJDSong*)song withPin:(NSString*)pin;
-(void)downvoteSong:(DJDSong*)song withPin:(NSString*)pin;
-(void)updatePlaylist:(NSArray*)songs withPin:(NSString*)pin;

@end
