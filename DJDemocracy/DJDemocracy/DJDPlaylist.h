//
//  DJDPlaylist.h
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJDSong.h"

@interface DJDPlaylist : NSObject <UITableViewDataSource>

-(void)addSong:(DJDSong*)song;

-(DJDSong*)getSong:(NSInteger)index;

-(void)clearPlaylist;

@end
