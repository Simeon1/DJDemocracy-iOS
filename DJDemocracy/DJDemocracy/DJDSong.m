//
//  DJDSong.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDSong.h"

@implementation DJDSong


+(instancetype)songWithTitle:(NSString*)title andArtist:(NSString*)artist {
    DJDSong* song = [[DJDSong alloc] init];
    
    song.title = title;
    song.artist = artist;
    
    return song;
}


-(NSDictionary*)jsonValue {
    return @{ @"title": self.title, @"artist": self.artist };
}

@end
