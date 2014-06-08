//
//  DJDPlaylist.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDPlaylist.h"


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



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.songs count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaylistCell" forIndexPath:indexPath];
    
    DJDSong* song = self.songs[indexPath.row];
    cell.textLabel.text = song.title;
    cell.detailTextLabel.text = song.artist;
    
    return cell;
}





@end
