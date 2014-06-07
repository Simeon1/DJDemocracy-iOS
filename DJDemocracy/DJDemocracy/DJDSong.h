//
//  DJDSong.h
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface DJDSong : NSObject 

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* artist;
@property (nonatomic, copy) NSString* votes;


+(instancetype)songWithTitle:(NSString*)title andArtist:(NSString*)artist;

-(NSDictionary*)jsonValue;

@end
