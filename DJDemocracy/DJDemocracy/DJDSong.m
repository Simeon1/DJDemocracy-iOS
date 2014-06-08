//
//  DJDSong.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDSong.h"

@implementation DJDSong


+(instancetype)songWithJSON:(NSDictionary*)jsonDictionary {
    DJDSong* song = [[DJDSong alloc] init];
    
    song.title = jsonDictionary[@"title"];
    song.artist = jsonDictionary[@"artist"];
    song.votes = jsonDictionary[@"votes"];
    
    return song;
}


+(instancetype)songWithTitle:(NSString*)title andArtist:(NSString*)artist {
    DJDSong* song = [[DJDSong alloc] init];
    
    song.title = title;
    song.artist = artist;
    
    return song;
}


-(NSString*)description {
    return [[self jsonValue] description];
}


-(NSDictionary*)jsonValue {
    return @{ @"title": self.title, @"artist": self.artist };
}



@end
