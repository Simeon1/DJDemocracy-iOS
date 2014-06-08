//
//  DJDPlaylist.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDPlaylist.h"
#import "DJDSongTableViewCell.h"

@interface DJDPlaylist ()

@property (nonatomic, strong) NSMutableArray* songs;

@end



@implementation DJDPlaylist

-(instancetype)init {
    if (self = [super init]) {
        _songs = [NSMutableArray array];
    }
    return self;
}


-(void)addSong:(DJDSong*)song {
    if (![self.songs containsObject:song]) {
        [self.songs addObject:song];
    }
}

-(DJDSong*)getSong:(NSInteger)index {
    return self.songs[index];
}


-(void)clearPlaylist {
    [self.songs removeAllObjects];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.songs count]) {
        return 1;
    } else {
        return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.songs count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DJDSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaylistCell" forIndexPath:indexPath];
    
    DJDSong* song = self.songs[indexPath.row];
    cell.title.text = song.title;
    cell.artist.text = song.artist;
    
    cell.votes.text = @"12";
    
    
    
    return cell;
}





@end
